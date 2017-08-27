
library(tidyverse)

# Download raw data files -------------------------------------------------

url = "https://trends.collegeboard.org/sites/default/files/2016-trends-college-pricing-source-data_0.xlsx"
fil = "data-raw/2016-trends-college-pricing-source-data_0.xlsx"

if (!file.exists(fil)) download.file(url, fil)

pdf_url = "https://trends.collegeboard.org/sites/default/files/2016-trends-college-pricing-web_1.pdf"
pdf_fil = "data-raw/2016-trends-college-pricing-web_1.pdf"

if (!file.exists(pdf_fil)) download.file(pdf_url, pdf_fil)

# 1: List of universities -------------------------------------------------

readxl::read_excel(fil, sheet = 10, range = "A3:B53") %>%
    rename(univ = `In 2016 Dollars`, state = STATE) -> univ
univ

# 2: In-state tuition and fees in 2016 dollars -----------------------------

readxl::read_excel(fil, sheet = 10, range = "B3:L53") %>%
    rename(state = STATE) %>%
    gather(school_year, instatetf_2016_dollars, -state) -> instatetf_2016_dollars
instatetf_2016_dollars

# 3: In-state tuition and fees in current dollars -------------------------

readxl::read_excel(fil, sheet = 10, range = "B55:L105") %>%
    rename(state = STATE) %>%
    gather(school_year, instatetf_current_dollars, -state) -> instatetf_current_dollars
instatetf_current_dollars

# 4: Out-of-state tuition and fees in 2016 dollars -------------------------

univ %>%
    select(state) %>%
    bind_cols(readxl::read_excel(fil, sheet = 10, range = "O3:X53")) %>%
    gather(school_year, outstatetf_2016_dollars, -state) -> outstatetf_2016_dollars
outstatetf_2016_dollars

# 5: Out-of-state tuition and fees in current dollars ----------------------

univ %>%
    select(state) %>%
    bind_cols(readxl::read_excel(fil, sheet = 10, range = "O55:X105")) %>%
    gather(school_year, outstatetf_current_dollars, -state) -> outstatetf_current_dollars
outstatetf_current_dollars

# 6: Fall-time fall enrollment --------------------------------------------

univ %>%
    select(state) %>%
    bind_cols(readxl::read_excel(fil, sheet = 10, range = "AA3:AI53")) %>%
    gather(school_year, enrollment, -state) %>%
    mutate(school_year =
               paste0(school_year, "-",
                      substr(as.integer(school_year) + 1, 3, 4))) -> enrollment
enrollment

# Combine all the columns -------------------------------------------------

univ %>%
    left_join(instatetf_2016_dollars, by = "state") %>%
    left_join(instatetf_current_dollars, by = c("state", "school_year")) %>%
    left_join(outstatetf_2016_dollars, by = c("state", "school_year")) %>%
    left_join(outstatetf_current_dollars, by = c("state", "school_year")) %>%
    left_join(enrollment, by = c("state", "school_year")) %>%
    labelled::set_variable_labels(
        instatetf_2016_dollars = "In-state tuition and fees, 2016 dollars",
        instatetf_current_dollars = "In-state tuition and fees, current dollars",
        outstatetf_2016_dollars = "Out-of-state tuition and fees, 2016 dollars",
        outstatetf_current_dollars = "Out-of-state tuition and fees, current dollars",
        enrollment = "Fall-time fall enrollment"
    ) -> flagship

# Add univ ids ------------------------------------------------------------

tibble::tribble(
    ~univ,   ~unitid,      ~opeid,   ~opeid6,
    "University of Alabama",  "100751",  "00105100",  "001051",
    "University of Alaska Fairbanks",  "102614",  "00106300",  "001063",
    "University of Arizona",  "104179",  "00108300",  "001083",
    "University of Arkansas",  "106397",  "00110800",  "001108",
    "University of California: Berkeley",  "110635",  "00131200",  "001312",
    "University of Colorado at Boulder",  "126614",  "00137000",  "001370",
    "University of Connecticut",  "129020",  "00141700",  "001417",
    "University of Delaware",  "130943",  "00143100",  "001431",
    "University of Florida",  "134130",  "00153500",  "001535",
    "University of Georgia",  "139959",  "00159800",  "001598",
    "University of Hawaii at Manoa",  "141574",  "00161000",  "001610",
    "University of Idaho",  "142285",  "00162600",  "001626",
    "University of Illinois at Urbana-Champaign",  "145637",  "00177500",  "001775",
    "Indiana University Bloomington",  "151351",  "00180900",  "001809",
    "University of Iowa",  "153658",  "00189200",  "001892",
    "University of Kansas",  "155317",  "00194800",  "001948",
    "University of Kentucky",  "157085",  "00198900",  "001989",
    "Louisiana State University and Agricultural and Mechanical College",  "159391",  "00201000",  "002010",
    "University of Maine",  "161253",  "00205300",  "002053",
    "University of Maryland: College Park",  "163286",  "00210300",  "002103",
    "University of Massachusetts Amherst",  "166629",  "00222100",  "002221",
    "University of Michigan",  "170976",  "00232500",  "002325",
    "University of Minnesota: Twin Cities",  "174066",  "00396900",  "003969",
    "University of Mississippi",  "176017",  "00244000",  "002440",
    "University of Missouri: Columbia",  "178396",  "00251600",  "002516",
    "University of Montana",  "180489",  "00253600",  "002536",
    "University of Nebraska - Lincoln",  "181464",  "00256500",  "002565",
    "University of Nevada: Reno",  "182290",  "00256800",  "002568",
    "University of New Hampshire",  "183044",  "00258900",  "002589",
    "Rutgers, The State University of New Jersey: New Brunswick/Piscataway Campus",  "186380",  "00262900",  "002629",
    "University of New Mexico",  "187985",  "00266300",  "002663",
    "State University of New York at Buffalo",  "196088",  "00283700",  "002837",
    "University of North Carolina at Chapel Hill",  "199120",  "00297400",  "002974",
    "University of North Dakota",  "200280",  "00300500",  "003005",
    "Ohio State University: Columbus Campus",  "204796",  "00309000",  "003090",
    "University of Oklahoma",  "207500",  "00318400",  "003184",
    "University of Oregon",  "209551",  "00322300",  "003223",
    "Penn State University Park",  "214777",  "00332900",  "003329",
    "University of Rhode Island",  "217484",  "00341400",  "003414",
    "University of South Carolina",  "218663",  "00344800",  "003448",
    "University of South Dakota",  "219471",  "00347400",  "003474",
    "University of Tennessee: Knoxville",  "221759",  "00353000",  "003530",
    "University of Texas at Austin",  "228778",  "00365800",  "003658",
    "University of Utah",  "230764",  "00367500",  "003675",
    "University of Vermont",  "231174",  "00369600",  "003696",
    "University of Virginia",  "234076",  "00374500",  "003745",
    "University of Washington",  "236948",  "00379800",  "003798",
    "West Virginia University",  "238032",  "00382700",  "003827",
    "University of Wisconsin-Madison",  "240444",  "00389500",  "003895",
    "University of Wyoming",  "240727",  "00393200",  "003932"
) -> ids
ids

# Combine flagship data with ids ------------------------------------------

ids %>%
    left_join(flagship, by = "univ") -> flagship
flagship

# Save the dataset! -------------------------------------------------------

devtools::use_data(flagship, overwrite = TRUE)

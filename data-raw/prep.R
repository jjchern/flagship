
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
devtools::use_data(flagship)

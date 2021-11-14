
library(glue)
library(tidyverse)

# ---- General ----

table_to_section <- function(data) {

  data <- data %>%
    mutate(
      subtitle = ifelse(is.na(subtitle), "N/A", subtitle),
      location = ifelse(is.na(location), "N/A", location),
      date = ifelse(is.na(date), "N/A", date),
      body = ifelse(is.na(body), "", body),
    )

  glue_template <- "
  ### {title}

  {subtitle}

  {location}

  {date}

  {body}

  "
  print(glue_data(data, glue_template))
}

# ---- Publications ----

combine_strings <- function(s) {
  paste(s, collapse = ", ")
}

specific_title_changes <- function(s) {
  s %>%
    str_replace("\\$\\\\beta\\$", "β")
}

clean_strings <- function(s) {
  unlist(s) %>%
    str_squish() %>%
    str_replace_all("\\{|\\}", "*")
}

highlight_me <- function(authors) {
  ifelse(str_detect(authors, "Joshua"), glue("**{authors}**"), authors)
}

format_authors <- function(pub) {
  as.character(pub$author) %>%
    unlist() %>%
    highlight_me() %>%
    combine_strings() %>%
    clean_strings()
}

print_pubs <- function(pub) {
  glue_template <- "
  ### {title}

  *{journal}*

  N/A

  {year}

  {authors}

  "

  data <- list(
    title = clean_strings(pub$title) %>% specific_title_changes(),
    journal = clean_strings(pub$journal),
    year = pub$year,
    authors = format_authors(pub)
  )

  print(glue_data(data, glue_template))
  return(NULL)
}

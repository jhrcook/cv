
library(glue)
library(tidyverse)

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

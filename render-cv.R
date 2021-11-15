#!/usr/bin/env Rscript

# ---- Config ----

CV_RMD <- here::here("cv", "cv.Rmd")
CV_HTML <- here::here("cv", "cv.html")
INDEX_HTML <- here::here("docs", "index.html")
PDF_OUT <- here::here("cv", "Joshua-Cook-CV.pdf")

# ----------------

CV_RMD <- here::here("cv", "cv.Rmd")
stopifnot(file.exists(CV_RMD))

# ---- CV (html) ----

rmarkdown::render(
  CV_RMD,
  params = list(pdf_mode = FALSE),
  output_file = CV_HTML
)

# Copy file to "docs/index.html" for GitHub pages.
fs::file_copy(CV_HTML, INDEX_HTML, overwrite = TRUE)

# ---- CV (pdf) ----

tmp_html_cv_loc <- fs::file_temp(ext = ".html")
rmarkdown::render(
  CV_RMD,
  params = list(pdf_mode = TRUE),
  output_file = tmp_html_cv_loc
)

# Convert to PDF using Pagedown.
pagedown::chrome_print(input = tmp_html_cv_loc, output = PDF_OUT)

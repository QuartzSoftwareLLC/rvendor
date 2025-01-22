test_that("multiplication works", {
  current_dir <- getwd()
  print(current_dir)
  dir <- tempdir()
  print(dir)
  setwd(dir)
  renv::init()
  source("renv/activate.R")
  package_dir <- paste0(current_dir, "/mockWithDeps")
  rvendor::install(package_dir)
  rvendor::activate()
  library(mockWithDeps)
  print(hello_world())
})










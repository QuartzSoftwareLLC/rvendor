test_that("can install local package with dependencies then load and call functions from that package", {
  current_dir <- getwd()
  print(current_dir)
  dir <- tempdir()
  print(dir)
  setwd(dir)
  rvendor_install <- rvendor::install
  rvendor_activate <- rvendor::activate
  renv::init(force = T, bare = T)
  source("renv/activate.R")
  renv::install("pkgload", prompt = F)

  package_dir <- paste0(current_dir, "/mockWithDeps")
  rvendor_install(package_dir, prompt = F)
  rvendor_activate()
  library(mockWithDeps)
  res <- hello_world()
  renv::deactivate()
  expect_equal(res, "hello")
})

# setwd("tests/testthat")
rvendor_install <- rvendor::install
rvendor_activate <- rvendor::activate

test_dir <- getwd()


dir <- tempdir()
dir.create(file.path(dir, "base"))
setwd(paste0(dir, "/base"))

renv::init(force = T, bare = T)
source("renv/activate.R")
renv::install("pkgload", prompt = F)
renv::install("testthat", prompt = F)


#' This test file verifies that rvendor can properly install packages and their dependencies
#' into an renv environment, and that those packages can then be loaded and used.
#' 
#' The tests:
#' 1. Set up a clean renv environment in a temporary directory
#' 2. Install packages using rvendor::install
#' 3. Activate the environment using rvendor::activate
# 4. Verify the packages work as expected
#
# The test environment is reset between each test using initialize_test_env()
initialize_test_env <- function() {
  unlink(paste0(dir, "/test"), recursive = T)
  dir.create(file.path(dir, "test"))
  file.copy(list.files(paste0(dir, "/base"), full.names = TRUE), paste0(dir, "/test"), recursive = TRUE)
  setwd(paste0(dir, "/test"))
  source("renv/activate.R")
}


test_that("can install local package with dependencies then load and call functions from that package", {
  initialize_test_env()

  rvendor_install(paste0(test_dir, "/mockWithDeps"), prompt = F)
  rvendor_activate()
  library(mockWithDeps)
  res <- hello_world()
  renv::deactivate()


  expect_equal(res, "hello")
})

test_that("can install cran packages", {
  initialize_test_env()
  rvendor_install("svUnit", prompt = F)
  rvendor_activate()
  library(svUnit)
  renv::deactivate()
})


test_that("can uninstall", {
  initialize_test_env()
  rvendor_install("svUnit", prompt = F)
  rvendor::uninstall("svUnit")
  renv::deactivate()
})




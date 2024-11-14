#' install
#' @inheritParams renv::install
#' @export
#' @description Installs the vendored package to the `./rvendor` directory
install <- function(...) {
  dir.create(here::here("./rvendor"), showWarnings = FALSE, recursive = TRUE)
  withr::with_libpaths(here::here("./rvendor"), renv::install(..., force = TRUE, dependencies = F))
}

#' activate
#' @export
#' @description Activates the vendored package by adding the `./rvendor` directory to the search path
activate <- function() {
  .libPaths(c(here::here("./rvendor"), .libPaths()))
}

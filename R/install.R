#' install
#' @inheritParams renv::install
#' @export
#' @description Installs the vendored package to the `./rvendor` directory
#' @inheritParams renv::install
#' @examples
#' \dontrun{
#' rvendor::install("../<my-local-path>")
#' rvendor::install("<org-name>/<repo-name>")
#' }
install <- function(...) {
  args <- c(...)
  package_name <- pkgload::pkg_name(args[[1]])
  print("Installing Vendored Packages")
  dir.create("./rvendor", showWarnings = FALSE, recursive = TRUE)
  # remove package from ignored list
  ignored <- renv::settings$ignored.packages()
  ignored <- ignored[ignored != package_name]
  renv::settings$ignored.packages(ignored, persist = T)

  # remove rvendor from the path in case it has already been activated
  old_lib_path <- .libPaths()
  new_lib_path  <- old_lib_path[!grepl("rvendor", old_lib_path)]
  .libPaths(new_lib_path)

  renv::install(...)

  .libPaths(old_lib_path)

  # renv install path
  renv_install_path <- paste0(renv::paths$library(), "/", package_name)
  rvendor_install_path <- paste0("rvendor/", package_name)


  renv::settings$ignored.packages(package_name, persist = T)

  #delete the package from the revndor library
  unlink(Sys.glob(paste0("rvendor/", package_name)), recursive = T)
  file.rename(renv_install_path, rvendor_install_path)
  renv::settings$ignored.packages(package_name, persist = T)

  # add activate to .Rprofile
  rprofile <- file(".Rprofile", "a")
  lines <- readLines(".Rprofile", warn = FALSE)
  if (!any(grepl("rvendor::activate()", lines))) {
    writeLines("rvendor::activate()", rprofile)
  }
  close(rprofile)
}

#' activate
#' 
#' Activates the vendored package by adding the `./rvendor` directory to the search path.
#' This script can often be included in a .Rprofile script to activate automatically at shell activation.
#' @export
#' @examples
#' \dontrun{
#' rvendor::activate()
#' }
activate <- function() {
  .libPaths(c(.libPaths(), "./rvendor"))
}





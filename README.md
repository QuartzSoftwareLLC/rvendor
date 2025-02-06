# rvendor

# The Problem/Background

Our team deploys packages to a sandboxed rstudio environment which can only install packages from CRAN or public github repositories. We wanted to install private packages from our own github repository in this sandboxed environment.

Package vendoring is a common solution to this problem. The idea is to download the package from the private repository, bundle it with the code that uses it, and install it from the local file. This is a manual process that can be automated.

# The Solution

RVendor is designed to make it easy to install private and local R packages into sandboxed environements in tandem with renv. 

Here is a general workflow:

```r
renv::init()

# close and reopen terminal

renv::install("quartzsoftwarellc/rvendor") 

rvendor::install("<path to my.private.package>") # installs all deps as renv dependencies and adds the packge to ignored dependencies while installing it locally to ./rvendor/<package_name>

rvendor::activate() # add all packages in ./rvendor/<package_name> to the library path

library(my.private.package) # load the package as a normal library
```

If you want to then use the package in a shiny app. Add the following to your app.R file:

```r
rvendor::activate()
library(my.private.package)
```

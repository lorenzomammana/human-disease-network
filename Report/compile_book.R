pkgTest <- function(x)
{
  if (!require(x, character.only = TRUE))
  {
    install.packages(x, dep = TRUE)
    if (!require(x, character.only = TRUE))
      stop("Package not found")
  }
}

pkgTest("igraph")

fn <- "_main.Rmd"
if (file.exists(fn))
  file.remove(fn)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
bookdown::render_book("index.Rmd")


# Import of libraries
import_libaries <- function(libraries_list) {
  if(!require("easypackages")) {
    install.packages("easypackages")
  }
  library(easypackages)
  packages(libraries_list)
  libraries(libraries_list)
}

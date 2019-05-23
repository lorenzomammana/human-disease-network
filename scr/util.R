# Import of libraries
import_libraries <- function(libraries_list) {
  if(!require("easypackages")) {
    install.packages("easypackages")
  }
  library(easypackages)
  packages(libraries_list)
  libraries(libraries_list)
}

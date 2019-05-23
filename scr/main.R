# set working directory
setwd("~/Human-Disease-Network/scr")

# source a set of functions
source("util.R")

# import libraries
libraries_list <- c("ggraph", "igraph", "dplyr", "readr", "DiagrammeR", "tidyverse", "Cairo", "networkD3")
import_libaries(libraries_list)

# import graph
edges <- read_delim("dataset/diseasome [Edges].csv", ",",
                              escape_double = FALSE, 
                              trim_ws = TRUE,
                              locale = locale(encoding = 'UTF-8'))

nodes <- read_delim("dataset/diseasome [Nodes].csv", ",",
                          escape_double = FALSE, 
                          trim_ws = TRUE,
                          locale = locale(encoding = 'UTF-8'))

graph <- graph.data.frame(edges, vertices = nodes)

print(graph, e=TRUE, v=TRUE) ## IGRAPH 9af20f4 DNW- 1419 3926

ggraph(graph, layout = 'kk') + 
  geom_edge_fan(colour = "gray") + 
  geom_node_point() #+ 
  #geom_node_text(aes(label=nodes$label)) ## FIXME; label size

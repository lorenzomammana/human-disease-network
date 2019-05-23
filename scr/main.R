# set working directory
setwd("~/Human-Disease-Network/scr")

# source a set of functions
source("util.R")

# import libraries
libraries_list <- c("ggraph", "igraph", "dplyr", "readr", "DiagrammeR", "tidyverse", "Cairo", "networkD3", "CINNA")
import_libaries(libraries_list)

# import graph
edges <- read_delim("dataset/diseasome [Edges].csv", ",",
                    escape_double = FALSE,
                    trim_ws = TRUE,
                    col_types = cols(Source = col_integer(),
                                     Target = col_integer(),
                                     Type = col_character(),
                                     id = col_integer(),
                                     label = col_character(),
                                     timeset = col_character(),
                                     weight = col_integer()),
                    locale = locale(encoding = 'UTF-8'))

nodes <- read_delim("dataset/diseasome [Nodes].csv", ",",
                    escape_double = FALSE,
                    trim_ws = TRUE,
                    col_types = cols(id = col_integer(),
                                     label = col_character(),
                                     timeset = col_character(),
                                     `0` = col_character(),
                                     `1` = col_character()),
                    locale = locale(encoding = 'UTF-8'))

nodes <- nodes %>% select(-timeset)
edges <- edges %>% select(-timeset, -label)

graph <- graph.data.frame(edges, vertices = nodes)

print(graph, e=TRUE, v=TRUE) ## IGRAPH 9af20f4 DNW- 1419 3926

ggraph(graph, layout = 'kk') + 
  #geom_edge_link(aes(alpha = edges$weight)) +
  geom_edge_fan(colour = "gray") + 
  geom_node_point() +
  theme_graph()
#+  #geom_node_text(aes(label=nodes$label)) ## FIXME: label size

# similarities
ggplot(edges, aes(x = edges$Source, y = edges$Target, color = "red")) + geom_point()

# no isolated nodes

### Centrality Analitycs ###
## Degree
degree <- centr_degree(graph, mode = "all", normalized = TRUE)
hist(degree$res, breaks = 20)

# ggraph(graph, layout = 'kk') + 
#   geom_edge_fan(colour = "gray") + 
#   geom_node_point(aes(size = degree)) +
#   theme_graph()

# node with the higest degree
V(graph)$label[degree$res==max(degree$res)] # "Colon cancer"

## Betweenness
betweenness <- betweenness(graph, v = V(graph), directed = TRUE, normalized = TRUE)
hist(betweenness, breaks = 20, xlim = c(0, 1))

ggraph(graph, layout = 'kk') + 
  geom_edge_fan(colour = "gray") + 
  geom_node_point(aes(size = betweenness)) +
  theme_graph()

# node with the higest betweenness
V(graph)$label[betweenness==max(betweenness)] # "Cardiomyopathy"

## Closeness
closeness <- closeness(graph, v = V(graph), normalized = TRUE)
hist(closeness, breaks = 20, xlim = c(0, 1))

ggraph(graph, layout = 'kk') + 
  geom_edge_fan(colour = "gray") + 
  geom_node_point(aes(size = closeness)) +
  theme_graph()

# node with the higest closeness
V(graph)$label[closeness==max(closeness)] # "Lipodystrophy"

## Pagerank
pagerank <- page_rank(graph, v = V(graph), directed = TRUE)
hist(pagerank$vector, xlim = c(0, 1))

# ggraph(graph, layout = 'kk') + 
#   geom_edge_fan(colour = "gray") + 
#   geom_node_point(aes(size = pagerank)) +
#   theme_graph()

# node with the higest pagerank
V(graph)$label[pagerank$vector==max(pagerank$vector)] # "Colon cancer"

library(jsonlite)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

filename <- "C:/Users/loren/Desktop/Human-Disease-Network/demo/gexf/human-disease-network.json"
algo <- c("betweennes", "fastgreedy", "louvain", "spinglass", "markov",
                           "leiden", "label prop", "label prop init", "lead eigenvector")

built.graph <- fromJSON(filename, flatten=TRUE)
colors <- c(unique(built.graph$nodes$color))

built.graph$edges <- built.graph$edges[as.numeric(built.graph$edges$targetID) < 1308, ]
mark_to_delete <- c()

for (i in 1:length(built.graph$edges$sourceID))
{
  if (i %in% mark_to_delete)
  {
    
  } else
  {
    edge <- built.graph$edges[i, ]
    invedge <- which(built.graph$edges$sourceID == toString(edge$targetID) &
                     built.graph$edges$targetID == toString(edge$sourceID))
    mark_to_delete <- c(mark_to_delete, invedge)
  }
}

built.graph$edges <- built.graph$edges[-mark_to_delete, ]

for (i in 1:length(algo))
{

  disease_clusters <- unique(V(UD_nogenes)$X1)
  
  for (j in 1:length(nodes_results[, 2]))
  {
    idx <- which(built.graph$nodes$label == nodes_results[j, 2])
    color <- colors[which(disease_clusters == nodes_results[j, 3 + i])]
    built.graph$nodes[idx, ]$color <- color
  }
  
  jsongraph <- toJSON(built.graph)
  
  sink(paste("../demo/gexf/", algo[i], ".json", sep = ""))
  cat(jsongraph)
  sink()
}










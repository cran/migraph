## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(migraph)
brandes
autographr(brandes)

## ----coercion-----------------------------------------------------------------
as_igraph(brandes)
as_network(brandes)
mat <- as_matrix(brandes)

## ----degreesum----------------------------------------------------------------
(degrees <- rowSums(mat))
rowSums(mat) == colSums(mat)
# Are they all equal? Why?
# You can also just use a built in command in migraph though:
node_degree(brandes)

## ----distrib------------------------------------------------------------------
ggdistrib(brandes, node_degree)

## ----micent-------------------------------------------------------------------
node_betweenness(brandes)
node_closeness(brandes)
node_eigenvector(brandes)
# TASK: Can you create degree distributions for each of these?

## ----ggid---------------------------------------------------------------------
ggidentify(brandes, node_degree)
ggidentify(brandes, node_betweenness)
ggidentify(brandes, node_closeness)
ggidentify(brandes, node_eigenvector)

## ----centzn-------------------------------------------------------------------
graph_degree(brandes)
graph_betweenness(brandes)
graph_closeness(brandes)
graph_eigenvector(brandes) # note that graph_eigenvector() is not yet implemented for two-mode networks
graph_eigenvector(brandes, digits = 4)
graph_eigenvector(brandes, digits = FALSE)

## ----multiplot----------------------------------------------------------------
gd <- ggidentify(brandes, node_degree) + 
  ggtitle("Degree", subtitle = graph_degree(brandes))
gc <- ggidentify(brandes, node_closeness) + 
  ggtitle("Closeness", subtitle = round(graph_closeness(brandes), 2))
gb <- ggidentify(brandes, node_betweenness) + 
  ggtitle("Betweenness", subtitle = round(graph_betweenness(brandes), 2))
ge <- ggidentify(brandes, node_eigenvector) + 
  ggtitle("Eigenvector")
grid.arrange(gd, gb, gc, ge, ncol = 2)
# ggsave("brandes-centralities.pdf")


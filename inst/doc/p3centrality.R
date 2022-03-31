## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(migraph)
ison_brandes
autographr(ison_brandes)

## ----coercion-----------------------------------------------------------------
as_igraph(ison_brandes)
as_network(ison_brandes)
mat <- as_matrix(ison_brandes)

## ----degreesum----------------------------------------------------------------
(degrees <- rowSums(mat))
rowSums(mat) == colSums(mat)
# Are they all equal? Why?
# You can also just use a built in command in migraph though:
node_degree(ison_brandes)

## ----distrib------------------------------------------------------------------
ggdistrib(ison_brandes, node_degree)

## ----micent-------------------------------------------------------------------
node_betweenness(ison_brandes)
node_closeness(ison_brandes)
node_eigenvector(ison_brandes)
# TASK: Can you create degree distributions for each of these?

## ----ggid---------------------------------------------------------------------
ggidentify(ison_brandes, node_degree)
ggidentify(ison_brandes, node_betweenness)
ggidentify(ison_brandes, node_closeness)
ggidentify(ison_brandes, node_eigenvector)

## ----centzn-------------------------------------------------------------------
graph_degree(ison_brandes)
graph_betweenness(ison_brandes)
graph_closeness(ison_brandes)
graph_eigenvector(ison_brandes) # note that graph_eigenvector() is not yet implemented for two-mode networks
graph_eigenvector(ison_brandes, digits = 4)
graph_eigenvector(ison_brandes, digits = FALSE)

## ----multiplot----------------------------------------------------------------
gd <- ggidentify(ison_brandes, node_degree) + 
  ggtitle("Degree", subtitle = graph_degree(ison_brandes))
gc <- ggidentify(ison_brandes, node_closeness) + 
  ggtitle("Closeness", subtitle = round(graph_closeness(ison_brandes), 2))
gb <- ggidentify(ison_brandes, node_betweenness) + 
  ggtitle("Betweenness", subtitle = round(graph_betweenness(ison_brandes), 2))
ge <- ggidentify(ison_brandes, node_eigenvector) + 
  ggtitle("Eigenvector")
library(patchwork)
(gd | gb) / (gc | ge)
# ggsave("brandes-centralities.pdf")


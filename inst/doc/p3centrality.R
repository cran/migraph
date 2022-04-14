## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(migraph)
autographr(ison_brandes)

## ----coercion-----------------------------------------------------------------
ison_brandes
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
plot(node_degree(ison_brandes), "h") +
  plot(node_degree(ison_brandes), "d")

## ----micent-------------------------------------------------------------------
node_betweenness(ison_brandes)
node_closeness(ison_brandes)
node_eigenvector(ison_brandes)
# TASK: Can you create degree distributions for each of these?

## ----ggid---------------------------------------------------------------------
autographr(ison_brandes, node_measure = node_degree) +
autographr(ison_brandes, node_measure = node_betweenness)
autographr(ison_brandes, node_measure = node_closeness) +
autographr(ison_brandes, node_measure = node_eigenvector)

## ----centzn-------------------------------------------------------------------
graph_degree(ison_brandes)
graph_betweenness(ison_brandes)
graph_closeness(ison_brandes)
graph_eigenvector(ison_brandes)
graph_degree(ison_southern_women)
graph_betweenness(ison_southern_women)
graph_closeness(ison_southern_women)
graph_eigenvector(ison_southern_women)

## ----multiplot----------------------------------------------------------------
gd <- autographr(ison_brandes, node_measure = node_degree) + 
  ggtitle("Degree", subtitle = round(graph_degree(ison_brandes), 2))
gc <- autographr(ison_brandes, node_measure = node_closeness) + 
  ggtitle("Closeness", subtitle = round(graph_closeness(ison_brandes), 2))
gb <- autographr(ison_brandes, node_measure = node_betweenness) + 
  ggtitle("Betweenness", subtitle = round(graph_betweenness(ison_brandes), 2))
ge <- autographr(ison_brandes, node_measure = node_eigenvector) + 
  ggtitle("Eigenvector", subtitle = round(graph_eigenvector(ison_brandes), 2))
library(patchwork)
(gd | gb) / (gc | ge)
# ggsave("brandes-centralities.pdf")


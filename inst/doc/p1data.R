## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----importedges, include = TRUE, eval = FALSE--------------------------------
#  library(migraph)
#  g1 <- read_edgelist("~Downloads/mynetworkdata.xlsx")
#  g1 <- read_edgelist("~Downloads/mynetworkdata.csv")
#  g1 <- read_edgelist()
#  n1 <- read_nodelist()

## ----exportdata, include = FALSE, eval = FALSE--------------------------------
#  write_edgelist(southern_women)
#  write_edgelist()
#  write_nodelist(southern_women)
#  write_nodelist()

## ----otherimports, include = TRUE, eval = FALSE-------------------------------
#  # for importing .net or .paj files
#  read_pajek()
#  write_pajek()
#  # for importing .##h files
#  # (.##d files are automatically imported alongside)
#  read_ucinet()
#  write_ucinet()

## ----as-----------------------------------------------------------------------
library(migraph)
southern_women # this is in igraph format
as_tidygraph(southern_women) # now let's make it a tidygraph tbl_graph object
as_network(southern_women) # a network object
as_matrix(southern_women) # a matrix object
# this is an incidence matrix since it is a two-mode network
# if it were a one-mode network, the function would return an adjacency matrix
as_edgelist(southern_women) # an edgelist data frame/tibble

## ----combine------------------------------------------------------------------
to_unnamed(ison_marvel_relationships)
to_named(ison_m182)
to_undirected(ison_m182)
to_unsigned(ison_marvel_relationships, keep = "positive")

## ----project------------------------------------------------------------------
project_rows(southern_women)
project_cols(southern_women)

## ----mutate-------------------------------------------------------------------
as_tidygraph(mpn_elite_mex) %>% 
  mutate(order = 1:11,
         color = "red",
         degree = node_degree(mpn_elite_mex))

## ----mutateedges--------------------------------------------------------------
generate_random(10, .3) %>% 
  mutate_edges(generate_random(10, .3), "next")

## ----grab---------------------------------------------------------------------
node_names(mpn_elite_mex) # gets the names of the nodes
node_attribute(ison_marvel_relationships, "Gender") # gets any named nodal attribute
edge_attribute(ison_marvel_relationships, "sign") # gets any named edge attribute
edge_weights(mpn_elite_mex)


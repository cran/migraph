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
#  write_edgelist(ison_southern_women)
#  write_edgelist()
#  write_nodelist(ison_southern_women)
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
ison_southern_women # this is in igraph format
as_tidygraph(ison_southern_women) # now let's make it a tidygraph tbl_graph object
as_network(ison_southern_women) # a network object
as_matrix(ison_southern_women) # a matrix object
# this is an incidence matrix since it is a two-mode network
# if it were a one-mode network, the function would return an adjacency matrix
as_edgelist(ison_southern_women) # an edgelist data frame/tibble

## ----combine------------------------------------------------------------------
to_unnamed(ison_marvel_relationships)
to_named(ison_algebra)
to_undirected(ison_algebra)
to_unsigned(ison_marvel_relationships, keep = "positive")

## ----project------------------------------------------------------------------
project_rows(ison_southern_women)
project_cols(ison_southern_women)

## ----mutate-------------------------------------------------------------------
as_tidygraph(mpn_elite_mex) %>% 
  mutate(order = 1:35,
         color = "red",
         degree = node_degree(mpn_elite_mex))

## ----mutateedges--------------------------------------------------------------
generate_random(10, .3) %>% 
  join_edges(generate_random(10, .3), "next")

## ----grab---------------------------------------------------------------------
node_names(mpn_elite_mex) # gets the names of the nodes
node_attribute(ison_marvel_relationships, "Gender") # gets any named nodal attribute
edge_attribute(ison_marvel_relationships, "sign") # gets any named edge attribute
edge_weights(mpn_elite_mex)


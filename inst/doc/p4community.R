## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
suppressPackageStartupMessages(library(igraph))
suppressPackageStartupMessages(library(migraph))
data("ison_m182", package = "migraph")
# ?migraph::ison_m182

## ----addingnames--------------------------------------------------------------
ison_m182 <- to_named(ison_m182)
autographr(ison_m182)

## ----separatingnets-----------------------------------------------------------
(m182_friend <- to_uniplex(ison_m182, "friend_tie"))
gfriend <- autographr(m182_friend) + ggtitle("Friendship")
(m182_social <- to_uniplex(ison_m182, "social_tie"))
gsocial <- autographr(m182_social) + ggtitle("Social")
(m182_task <- to_uniplex(ison_m182, "task_tie"))
gtask <- autographr(m182_task) + ggtitle("Task")
grid.arrange(gfriend, gsocial, gtask, ncol = 3)

## ----dens-explicit------------------------------------------------------------
length(E(m182_task))/(length(V(m182_task))*(length(V(m182_task))-1))

## ----dens---------------------------------------------------------------------
graph_density(m182_task)

## ----recip--------------------------------------------------------------------
graph_reciprocity(m182_task)

## ----trans--------------------------------------------------------------------
graph_transitivity(m182_task)

## ----comp-no------------------------------------------------------------------
graph_components(m182_friend)
graph_components(m182_friend, method = "strong")

## ----comp-memb----------------------------------------------------------------
m182_friend <- m182_friend %>% 
  mutate(weak_comp = node_components(m182_friend),
         strong_comp = node_components(m182_friend, method = "strong"))
autographr(m182_friend, node_color = "weak_comp")
autographr(m182_friend, node_color = "strong_comp")

## ----manip-fri----------------------------------------------------------------
(m182_friend <- to_main_component(m182_friend))
(m182_friend <- to_undirected(m182_friend))
autographr(m182_friend)

## ----walk---------------------------------------------------------------------
friend_wt <- cluster_walktrap(m182_friend, steps=50)
friend_wt

## ----walkdendro---------------------------------------------------------------
friend_dend <- as.dendrogram(friend_wt, use.modularity=TRUE)
ggtree(friend_dend)

## ----walkplot-----------------------------------------------------------------
m182_friend <- m182_friend %>% 
  mutate(walk_comm = friend_wt$membership)
autographr(m182_friend, node_color = "walk_comm")
# to be fancy, we could even draw the group borders around the nodes
autographr(m182_friend, node_group = "walk_comm")
# or both!
autographr(m182_friend, 
           node_color = "walk_comm", 
           node_group = "walk_comm")

## ----eb-----------------------------------------------------------------------
friend_eb <- cluster_edge_betweenness(m182_friend)
friend_eb

## ----ebdendro-----------------------------------------------------------------
friend_eb$removed.edges
friend_eb$modularity
ggtree(as.dendrogram(friend_eb, use.modularity = T))

## ----ebplot-------------------------------------------------------------------
m182_friend <- m182_friend %>% 
  mutate(eb_comm = friend_eb$membership)
autographr(m182_friend, 
           node_color = "eb_comm", 
           node_group = "eb_comm")

## ----fg-----------------------------------------------------------------------
friend_fg <- cluster_fast_greedy(m182_friend)
friend_fg # Does this result in a different community partition?
friend_fg$modularity # Compare this to the edge betweenness procedure

# Again, we can visualise these communities in different ways:
ggtree(as.dendrogram(friend_fg, use.modularity = T)) # dendrogram
m182_friend <- m182_friend %>% 
  mutate(fg_comm = friend_fg$membership)
autographr(m182_friend, 
           node_color = "fg_comm", 
           node_group = "fg_comm")

## ----setup-women--------------------------------------------------------------
data("southern_women")
southern_women
autographr(southern_women, node_color = "type")

## ----hardway------------------------------------------------------------------
twomode_matrix <- as_matrix(southern_women)
women_matrix <- twomode_matrix %*% t(twomode_matrix)
event_matrix <- t(twomode_matrix) %*% twomode_matrix

## ----easyway------------------------------------------------------------------
women_graph <- project_rows(southern_women)
autographr(women_graph)
event_graph <- project_cols(southern_women)
autographr(event_graph)

## ----twomode-cohesion---------------------------------------------------------
graph_equivalency(southern_women)
graph_transitivity(women_graph)
graph_transitivity(event_graph)


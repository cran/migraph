## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(migraph)
marvel_friends <- to_unsigned(ison_marvel_relationships, keep = "positive")
marvel_friends <- to_main_component(marvel_friends)
marvel_friends <- marvel_friends %>% to_subgraph(Appearances >= mean(Appearances))
marvel_friends

## ----vis----------------------------------------------------------------------
autographr(marvel_friends, 
           node_shape = "Gender",
           node_color = "PowerOrigin")

## ----blau---------------------------------------------------------------------
graph_blau_index(marvel_friends, "Gender")
graph_blau_index(marvel_friends, "PowerOrigin")
graph_blau_index(marvel_friends, "Attractive")
graph_blau_index(marvel_friends, "Rich")
graph_blau_index(marvel_friends, "Intellect")

## ----crossref-----------------------------------------------------------------
graph_blau_index(marvel_friends, "Gender", "PowerOrigin")
graph_blau_index(marvel_friends, "Intellect", "Gender")

## ----blaugroups---------------------------------------------------------------
autographr(marvel_friends, 
           node_group = "PowerOrigin", 
           node_shape = "Gender")
autographr(marvel_friends, 
           node_group = "Gender", 
           node_shape = "Intellect")

## ----ei-----------------------------------------------------------------------
(obs.gender <- graph_ei_index(marvel_friends, "Gender"))
(obs.powers <- graph_ei_index(marvel_friends, "PowerOrigin")) 
(obs.attract <- graph_ei_index(marvel_friends, "Attractive")) 

## ----rando--------------------------------------------------------------------
rand.gender <- test_random(marvel_friends, 
                            graph_ei_index, attribute = "Gender", 
                           times = 200)
rand.power <- test_random(marvel_friends, 
                           graph_ei_index, attribute = "PowerOrigin", 
                           times = 200)
rand.attract <- test_random(marvel_friends, 
                             graph_ei_index, attribute = "Attractive", 
                           times = 200)
library(patchwork)
plot(rand.gender) / 
plot(rand.power) /
plot(rand.attract)

## ----perm---------------------------------------------------------------------
old <- autographr(marvel_friends, 
                  labels = FALSE, node_size = 6, 
                  node_color = "PowerOrigin", 
                  node_shape = "Gender")
new <- autographr(generate_permutation(marvel_friends, with_attr = TRUE),
                   labels = FALSE, node_size = 6,
                  node_color = "PowerOrigin",
                  node_shape = "Gender")
library(patchwork)
old + new

## ----test_permute-------------------------------------------------------------
perm.gender <- test_permutation(marvel_friends, 
                                graph_ei_index, attribute = "Gender",
                                times = 200)
perm.power <- test_permutation(marvel_friends, 
                               graph_ei_index, attribute = "PowerOrigin",
                                times = 200)

## ----cugqap-------------------------------------------------------------------
library(patchwork)
(plot(rand.gender) | plot(rand.power)) /
(plot(perm.gender) | plot(perm.power))

## ----intro-eies---------------------------------------------------------------
ison_networkers
autographr(ison_networkers,
           node_color = "Discipline")

## ----qap-max------------------------------------------------------------------
model1 <- network_reg(weight ~ alter(Citations) + same(Discipline), 
                      ison_networkers, times = 200)

## ----qap-interp---------------------------------------------------------------
tidy(model1)
glance(model1)
plot(model1)


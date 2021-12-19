## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(migraph)
marvel_friends <- to_unsigned(ison_marvel_relationships, keep = "positive")
marvel_friends <- to_main_component(marvel_friends)
marvel_friends <- marvel_friends %>% filter(Appearances >= mean(Appearances))
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
(rand.gender <- test_random(marvel_friends, graph_ei_index, attribute = "Gender"))
(rand.power <- test_random(marvel_friends, graph_ei_index, attribute = "PowerOrigin"))
(rand.attract <- test_random(marvel_friends, graph_ei_index, attribute = "Attractive"))
par(mfrow=c(1,3))
plot(rand.gender)
plot(rand.power)
plot(rand.attract)

## ----perm---------------------------------------------------------------------
old <- autographr(marvel_friends, 
                  labels = FALSE, node_size = 6, 
                  node_color = "PowerOrigin", 
                  node_shape = "Gender")
new <- autographr(generate_permutation(marvel_friends),
                   labels = FALSE, node_size = 6,
                  node_color = "PowerOrigin",
                  node_shape = "Gender")
grid.arrange(old, new)

## ----test_permute-------------------------------------------------------------
par(mfrow=c(1,2))
perm.gender <- test_permutation(marvel_friends, graph_ei_index, attribute = "Gender")
plot(perm.gender) # Sorry the labelling on this is not right yet, will fix this next...
perm.power <- test_permutation(marvel_friends, graph_ei_index, attribute = "PowerOrigin")
plot(perm.power)

## ----cugqap-------------------------------------------------------------------
plot(rand.gender)
plot(rand.power)
plot(perm.gender)
plot(perm.power)

## ----intro-eies---------------------------------------------------------------
autographr(ison_eies,
           node_color = "Discipline")

## ----qap-attr-----------------------------------------------------------------
model1 <- network_reg(weight ~ ego(Citations) + alter(Citations) + same(Discipline), ison_eies)
summary(model1)


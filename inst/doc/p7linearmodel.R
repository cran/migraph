## ----setup------------------------------
library(migraph)
marvel_friends <- to_unsigned(ison_marvel_relationships, keep = "positive")
marvel_friends <- to_giant(marvel_friends)
marvel_friends <- marvel_friends %>% to_subgraph(Appearances >= mean(Appearances))
marvel_friends


## ---------------------------------------
autographr(marvel_friends, 
           node_shape = "Gender",
           node_color = "PowerOrigin")


## ----blau-------------------------------
graph_diversity(marvel_friends, "Gender")
graph_diversity(marvel_friends, "PowerOrigin")
graph_diversity(marvel_friends, "Attractive")
graph_diversity(marvel_friends, "Rich")
graph_diversity(marvel_friends, "Intellect")


## ----crossref---------------------------
graph_diversity(marvel_friends, "Gender", "PowerOrigin")
graph_diversity(marvel_friends, "Intellect", "Gender")


## ----blaugroups-------------------------
autographr(marvel_friends, 
           node_group = "PowerOrigin", 
           node_color = "Gender")
autographr(marvel_friends, 
           node_color = "Gender", 
           node_size = "Intellect")


## ----ei---------------------------------
(obs.gender <- graph_homophily(marvel_friends, "Gender"))
(obs.powers <- graph_homophily(marvel_friends, "PowerOrigin")) 
(obs.attract <- graph_homophily(marvel_friends, "Attractive")) 


## ----rando------------------------------
rand.gender <- test_random(marvel_friends, 
                            graph_homophily, attribute = "Gender", 
                           times = 20)
rand.power <- test_random(marvel_friends, 
                           graph_homophily, attribute = "PowerOrigin", 
                           times = 20)
rand.attract <- test_random(marvel_friends, 
                             graph_homophily, attribute = "Attractive", 
                           times = 20)
plot(rand.gender) / 
plot(rand.power) /
plot(rand.attract)


## ----perm-------------------------------
old <- autographr(marvel_friends, 
                  labels = FALSE, node_size = 6, 
                  node_color = "PowerOrigin", 
                  node_shape = "Gender")
new <- autographr(generate_permutation(marvel_friends, with_attr = TRUE),
                   labels = FALSE, node_size = 6,
                  node_color = "PowerOrigin",
                  node_shape = "Gender")
old + new


## ----test_permute-----------------------
perm.gender <- test_permutation(marvel_friends, 
                                graph_homophily, attribute = "Gender",
                                times = 1000)
perm.power <- test_permutation(marvel_friends, 
                               graph_homophily, attribute = "PowerOrigin",
                                times = 1000)


## ----cugqap-----------------------------
(plot(rand.gender) | plot(rand.power)) /
(plot(perm.gender) | plot(perm.power))


## ----intro-eies-------------------------
ison_networkers
autographr(ison_networkers,
           node_color = "Discipline")


## ----qap-max----------------------------
model1 <- network_reg(weight ~ alter(Citations) + sim(Citations) + 
                      alter(Discipline) + same(Discipline), 
                      ison_networkers, times = 200)


## ----qap-interp-------------------------
tidy(model1)
glance(model1)
plot(model1)


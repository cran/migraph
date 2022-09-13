## ----coercion---------------------------
library(migraph)
autographr(ison_brandes)
autographr(ison_brandes2)
(mat <- as_matrix(ison_brandes))


## ----addingnames------------------------
ison_brandes <- to_named(ison_brandes)
ison_brandes2 <- to_named(ison_brandes2)
autographr(ison_brandes)


## ----degreesum--------------------------
(degrees <- rowSums(mat))
rowSums(mat) == colSums(mat)
# Are they all equal? Why?
# You can also just use a built in command in migraph though:
node_degree(ison_brandes, normalized = FALSE)


## ----distrib----------------------------
plot(node_degree(ison_brandes), "h") +
  plot(node_degree(ison_brandes), "d")


## ----micent-----------------------------
node_betweenness(ison_brandes)
node_closeness(ison_brandes)
node_eigenvector(ison_brandes)
# TASK: Can you create degree distributions for each of these?


## ----ggid-------------------------------
ison_brandes %>%
  add_node_attribute("color", node_is_max(node_degree(ison_brandes))) %>%
  autographr(node_color = "color")
ison_brandes %>%
  add_node_attribute("color", node_is_max(node_betweenness(ison_brandes))) %>%
  autographr(node_color = "color")
ison_brandes %>%
  add_node_attribute("color", node_is_min(node_closeness(ison_brandes))) %>%
  autographr(node_color = "color")
ison_brandes %>%
  add_node_attribute("color", node_is_min(node_eigenvector(ison_brandes))) %>%
  autographr(node_color = "color")


## ----centzn-----------------------------
graph_degree(ison_brandes)
graph_betweenness(ison_brandes)
graph_closeness(ison_brandes)
graph_eigenvector(ison_brandes)


## ----multiplot--------------------------
ison_brandes <- ison_brandes %>%
  add_node_attribute("degree", node_is_max(node_degree(ison_brandes))) %>%
  add_node_attribute("betweenness", node_is_max(node_betweenness(ison_brandes))) %>%
  add_node_attribute("closeness", node_is_max(node_closeness(ison_brandes))) %>%
  add_node_attribute("eigenvector", node_is_max(node_eigenvector(ison_brandes)))
gd <- autographr(ison_brandes, node_color = "degree") + 
  ggtitle("Degree", subtitle = round(graph_degree(ison_brandes), 2))
gc <- autographr(ison_brandes, node_color = "closeness") + 
  ggtitle("Closeness", subtitle = round(graph_closeness(ison_brandes), 2))
gb <- autographr(ison_brandes, node_color = "betweenness") + 
  ggtitle("Betweenness", subtitle = round(graph_betweenness(ison_brandes), 2))
ge <- autographr(ison_brandes, node_color = "eigenvector") + 
  ggtitle("Eigenvector", subtitle = round(graph_eigenvector(ison_brandes), 2))
(gd | gb) / (gc | ge)
# ggsave("brandes-centralities.pdf")


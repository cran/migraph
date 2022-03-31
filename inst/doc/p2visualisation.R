## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----migrapheg, echo=TRUE-----------------------------------------------------
library(migraph)
autographr(ison_brandes)

## ----migraphexample2, echo=TRUE, message=FALSE, warning=FALSE-----------------
library(migraph)
autographr(ison_adolescents,
           labels = TRUE,
           node_size = 1.5) + 
  ggplot2::ggtitle("Visualisation")

## ----migrapheg3, echo=TRUE, message=FALSE, warning=FALSE----------------------
library(migraph)
mpn_elite_mex2 <- mpn_elite_mex  %>%
  tidygraph::activate(edges) %>%
  tidygraph::reroute(from = sample.int(11, 44, replace = TRUE),
                     to = sample.int(11, 44, replace = TRUE))
ggevolution(mpn_elite_mex, mpn_elite_mex2)

## ----ggrapheg, echo=TRUE, message=FALSE, warning=FALSE------------------------
library(ggraph)
ggraph(mpn_elite_mex, layout = "fr") + 
  geom_edge_link(edge_colour = "dark grey", 
                  arrow = arrow(angle = 45,
                                length = unit(2, "mm"),
                                type = "closed"),
                  end_cap = circle(3, "mm")) +
  geom_node_point(size = 2.5, shape = 19, colour = "blue") +
  geom_node_text(aes(label=name), family = "serif", size = 2.5) +
  scale_edge_width(range = c(0.3,1.5)) +
  theme_graph() +
  theme(legend.position = "none")


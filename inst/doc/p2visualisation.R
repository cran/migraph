## ---- include = FALSE------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.cap = "",
  fig.path = "teaching/"
)


## ----migrapheg, echo=TRUE--------------------------
library(migraph)
autographr(ison_brandes)


## ----migraphexample2, echo=TRUE, message=FALSE, warning=FALSE----
autographr(ison_adolescents,
           labels = TRUE,
           node_size = 1.5) + 
  ggtitle("Visualisation")


## ----patchwork, echo=TRUE, message=FALSE, warning=FALSE----
autographr(ison_adolescents) + autographr(ison_algebra)
autographr(ison_adolescents) / autographr(ison_algebra)


## ----layoutseg, echo=TRUE, message=FALSE, warning=FALSE----
(autographr(ison_southern_women, layout = "bipartite") + ggtitle("bipartite") |
autographr(ison_southern_women, layout = "hierarchy") + ggtitle("hierarchy")) /
(autographr(ison_southern_women, layout = "concentric") + ggtitle("concentric") |
   autographr(ison_southern_women, layout = "railway") + ggtitle("railway"))


## ----ggrapheg, echo=TRUE, message=FALSE, warning=FALSE----
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


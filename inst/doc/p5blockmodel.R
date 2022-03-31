## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
suppressPackageStartupMessages(library(migraph)) # note that you may need a special version for what follows...
data("ison_algebra", package = "migraph")

## ----addingnames--------------------------------------------------------------
ison_algebra <- to_named(ison_algebra)
autographr(ison_algebra)

## ----separatingnets-----------------------------------------------------------
(m182_friend <- to_uniplex(ison_algebra, "friend_tie"))
gfriend <- autographr(m182_friend) + ggtitle("Friendship")
(m182_social <- to_uniplex(ison_algebra, "social_tie"))
gsocial <- autographr(m182_social) + ggtitle("Social")
(m182_task <- to_uniplex(ison_algebra, "task_tie"))
gtask <- autographr(m182_task) + ggtitle("Task")
library(patchwork)
gfriend + gsocial + gtask

## ----constraint---------------------------------------------------------------
node_constraint(m182_task)

## ----constraintplot-----------------------------------------------------------
ggidentify(m182_task, node_constraint, min)

## ----construct-cor------------------------------------------------------------
dim(node_tie_census(ison_algebra))
head(structural_combo <- node_tie_census(ison_algebra))[,c(1,17,33,49,65,81)]

## ----cluster-str--------------------------------------------------------------
(str_res <- cluster_structural_equivalence(ison_algebra))

## -----------------------------------------------------------------------------
ggtree(str_res)
ggtree(str_res, 2) # for example let's say there are just two main clusters
ggtree(str_res, 4) # or four? what are we seeing here?

## ----idstrclust---------------------------------------------------------------
ggidentify_clusters(str_res, structural_combo)

## ----cutree-------------------------------------------------------------------
(str_clu <- cutree(str_res, 4))

## ----strclu-plots-------------------------------------------------------------
m182_task <- m182_task %>% as_tidygraph() %>% mutate(clu = str_clu)
autographr(m182_task, node_color = "clu") + ggtitle("Task")
m182_social <- m182_social %>% as_tidygraph() %>% mutate(clu = str_clu)
autographr(m182_social, node_color = "clu") + ggtitle("Social")
m182_friend <- m182_friend %>% as_tidygraph() %>% mutate(clu = str_clu)
autographr(m182_friend, node_color = "clu") + ggtitle("Friend")

## ----structblock--------------------------------------------------------------
(task_blockmodel <- blockmodel(m182_task, str_clu))
plot(task_blockmodel)
(social_blockmodel <- blockmodel(m182_social, str_clu))
plot(social_blockmodel)
(friend_blockmodel <- blockmodel(m182_friend, str_clu))
plot(friend_blockmodel)

## ----strredgraph--------------------------------------------------------------
group_labels <- c("Freaks","Squares","Nerds","Geek")
(social_reduced <- reduce_graph(social_blockmodel, group_labels))
autographr(social_reduced)
(task_reduced <- reduce_graph(task_blockmodel, group_labels))
autographr(task_reduced)
(friend_reduced <- reduce_graph(friend_blockmodel, group_labels))
autographr(friend_reduced)

## ----str-group----------------------------------------------------------------
group_tie_census(m182_task, str_clu)

## ----graphtriads--------------------------------------------------------------
(graph_triad_census(m182_task))

## ----nodetriads---------------------------------------------------------------
# (By putting parentheses around this command, it'll assign AND print!)
(task_triads <- node_triad_census(m182_task))

## ----regeq--------------------------------------------------------------------
reg_res <- cluster_regular_equivalence(m182_task)
ggtree(reg_res,4)

## ----regid--------------------------------------------------------------------
ggidentify_clusters(reg_res, task_triads)

## ----cutreereg----------------------------------------------------------------
ggtree(reg_res, 2)
(reg_clu <- cutree(reg_res, 2))
m182_task <- m182_task %>% as_tidygraph() %>% mutate(regclu = reg_clu)
autographr(m182_task, node_color = "regclu") + ggtitle("Task")

## ----regblock-----------------------------------------------------------------
(task_blockmodel <- blockmodel(m182_task, reg_clu))
plot(task_blockmodel)

## ----regredgraph--------------------------------------------------------------
(task_reduced <- reduce_graph(task_blockmodel, c("Regulars","Geek")))
autographr(task_reduced)

## ----clustercensus------------------------------------------------------------
group_triad_census(m182_task, reg_clu)


## ----setup-----------------------------------------
library(migraph)
data("ison_algebra", package = "migraph")
# ?migraph::ison_algebra


## ----separatingnets--------------------------------
(friends <- to_uniplex(ison_algebra, "friends"))
gfriend <- autographr(friends) + ggtitle("Friendship")
(social <- to_uniplex(ison_algebra, "social"))
gsocial <- autographr(social) + ggtitle("Social")
(tasks <- to_uniplex(ison_algebra, "tasks"))
gtask <- autographr(tasks) + ggtitle("Task")
gfriend + gsocial + gtask


## ----constraint------------------------------------
node_constraint(tasks)


## ----constraintplot--------------------------------
tasks <- tasks %>% mutate(low_constraint = node_is_min(node_constraint(tasks)))
autographr(tasks, node_color = "low_constraint")


## ----find-se---------------------------------------
node_structural_equivalence(ison_algebra)
ison_algebra %>% 
  mutate(se = node_structural_equivalence(ison_algebra)) %>% 
  autographr(node_color = "se")


## ----construct-cor---------------------------------
node_tie_census(ison_algebra)
dim(node_tie_census(ison_algebra))


## ----vary-clust------------------------------------
plot(node_structural_equivalence(ison_algebra, cluster = "hier", distance = "euclidean"))
plot(node_structural_equivalence(ison_algebra, cluster = "hier", distance = "manhattan"))
plot(node_structural_equivalence(ison_algebra, cluster = "concor"))


## ----k-discrete------------------------------------
plot(node_structural_equivalence(ison_algebra, k = 2))


## ----elbowsil--------------------------------------
plot(node_structural_equivalence(ison_algebra, k = "elbow"))
plot(node_structural_equivalence(ison_algebra, k = "silhouette"))


## ----strict----------------------------------------
plot(node_structural_equivalence(ison_algebra, k = "strict"))


## ----strplot---------------------------------------
str_clu <- node_structural_equivalence(ison_algebra)
ison_algebra %>% 
  mutate(se = str_clu) %>% 
  autographr(node_color = "se")


## ----summ------------------------------------------
summary(node_tie_census(ison_algebra),
        membership = str_clu)


## ----block-----------------------------------------
plot(as_matrix(ison_algebra),
     membership = str_clu)


## ----structblock-----------------------------------
str_clu <- node_structural_equivalence(ison_algebra)
(bm <- to_blocks(ison_algebra, str_clu))
bm <- bm %>% as_tidygraph %>% mutate(name = c("Freaks", "Squares", "Nerds", "Geek"))
autographr(bm)


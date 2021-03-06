
<!-- README.md is generated from README.Rmd. Please edit that file -->

# migraph <img src="man/figures/logo.png" align="right" width="150"/>

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
![CRAN/METACRAN](https://img.shields.io/cran/v/migraph) ![GitHub release
(latest by
date)](https://img.shields.io/github/v/release/snlab-ch/migraph)
![GitHub Release
Date](https://img.shields.io/github/release-date/snlab-ch/migraph)
[![Codecov test
coverage](https://codecov.io/gh/snlab-ch/migraph/branch/main/graph/badge.svg)](https://app.codecov.io/gh/snlab-ch/migraph?branch=main)
[![CodeFactor](https://www.codefactor.io/repository/github/snlab-ch/migraph/badge)](https://www.codefactor.io/repository/github/snlab-ch/migraph)
[![CII Best
Practices](https://bestpractices.coreinfrastructure.org/projects/4559/badge)](https://bestpractices.coreinfrastructure.org/projects/4559)
<!-- ![GitHub All Releases](https://img.shields.io/github/downloads/snlab-ch/migraph/total) -->
<!-- badges: end -->

## About the package

`{migraph}` works with and extends existing network analysis packages
for analysing multimodal networks. It provides a common, standard syntax
for working with and analysing both one-mode and two-mode networks.

<img style="border:10px solid white;" src="https://jameshollway.com/media/9781108833509pvs01.jpg" align="left" width="125"/>

The package is intended as a software companion to the book:

> David Knoke, Mario Diani, James Hollway, and Dimitris Christopoulos
> (2021) [*Multimodal Political
> Networks*](https://www.cambridge.org/core/books/multimodal-political-networks/43EE8C192A1B0DCD65B4D9B9A7842128).
> Cambridge University Press: Cambridge.

Most datasets used in the book are included in this package, and the
package implements most methods discussed in the book. Since many of
theses datasets and routines are discussed and analysed more there, if
you like the package please check out the book, and vice versa.

## How does migraph help?

### Works with your current network analysis workflow

The package is offered as a complement to existing R packages for
network analysis and thus tries to work well with whatever format
network objects you are already working with. All `{migraph}` measures
and models work with data in base formats:

-   adjacency and incidence *matrices*
-   one-mode and two-mode *data frame* edgelists

as well as with objects constructed from the following packages:

-   [`{igraph}`](https://igraph.org/r/)
-   [`{network}`](https://statnet.org)
-   [`{tidygraph}`](https://tidygraph.data-imaginist.com/index.html)

`{migraph}`???s `as_*()` functions can be used to translate objects from
one of the above classes into any other, and include:

-   `as_edgelist()`, `as_igraph()`, `as_matrix()`, `as_network()`,
    `as_tidygraph()`

These functions are designed to be as intuitive and lossless as
possible, outperforming many other class-coercion packages.

#### Manipulation

Regardless of which class object you are working with, the same syntax
can be used to work with and manipulate your data.

`{migraph}`???s `is_*()` functions offer fast logical tests of network
properties, e.g.:

-   `is_acyclic()`, `is_bipartite()`, `is_complex()`, `is_connected()`,
    `is_directed()`, `is_edgelist()`, `is_graph()`, `is_labelled()`,
    `is_migraph()`, `is_multiplex()`, `is_signed()`, `is_twomode()`,
    `is_uniplex()`, `is_weighted()`

`{migraph}`???s `to_*()` functions can be used on any class object to
transform networks into networks with other properties, e.g.:

-   `to_blocks()`, `to_edges()`, `to_main_component()`, `to_mode1()`,
    `to_mode2()`, `to_multilevel()`, `to_named()`, `to_onemode()`,
    `to_redirected()`, `to_simplex()`, `to_subgraph()`, `to_ties()`,
    `to_undirected()`, `to_uniplex()`, `to_unnamed()`, `to_unsigned()`,
    `to_unweighted()`

#### Making

`{migraph}` includes algorithms for making both one-mode and two-mode
networks with particular properties. The `create_*` group of functions
create networks with a particular structure, e.g.:

-   `create_complete()`, `create_components()`, `create_core()`,
    `create_empty()`, `create_lattice()`, `create_ring()`,
    `create_star()`, `create_tree()`

The `generate_*` group of functions generate networks from particular
generative mechanisms, e.g.:

-   `generate_permutation()`, `generate_random()`,
    `generate_scalefree()`, `generate_smallworld()`

`{migraph}` includes a number of prominent network datasets, especially
multimodal and multiplex examples for demonstrating more advanced
methods.

-   `mpn_bristol`, `mpn_cow_igo`, `mpn_cow_trade`, `mpn_DE_1990`,
    `mpn_DE_2008`, `mpn_DemSxP`, `mpn_elite_mex`,
    `mpn_elite_usa_advice`, `mpn_elite_usa_money`, `mpn_IT_1990`,
    `mpn_IT_2008`, `mpn_OverSxP`, `mpn_RepSxP`, `mpn_ryanair`,
    `mpn_UK_1990`, `mpn_UK_2008`
-   `ison_adolescents`, `ison_algebra`, `ison_bb`, `ison_bm`,
    `ison_brandes`, `ison_brandes2`, `ison_karateka`,
    `ison_marvel_relationships`, `ison_marvel_teams`, `ison_mb`,
    `ison_mm`, `ison_networkers`, `ison_southern_women`

`{migraph}` can also import and export to Excel edgelists and nodelists,
[UCINET](http://www.analytictech.com/archive/ucinet.htm) and
[Pajek](http://mrvar.fdv.uni-lj.si/pajek/) files, e.g.:

-   `read_edgelist()`, `read_nodelist()`, `read_pajek()`,
    `read_ucinet()`
-   `write_edgelist()`, `write_nodelist()`, `write_pajek()`,
    `write_ucinet()`

### Extends your current network analysis workflow

`{migraph}` offers a range of measures and models with sensible
defaults. Many wrap existing functions in common packages for use with
one-mode networks, but extend these to treat and/or normalise for
two-mode (and sometimes three-mode) networks correctly. Functions are
given intuitive and succinct names that avoid conflicts with existing
function names wherever possible.

#### Measures

-   Centrality: `node_degree()`, `node_closeness()`,
    `node_betweenness()`, and `node_eigenvector()`
-   Centralization: `graph_degree()`, `graph_closeness()`,
    `graph_betweenness()`, and `graph_eigenvector()`
-   Cohesion: `graph_density()`, `graph_reciprocity()`,
    `graph_transitivity()`, `graph_equivalency()`, and
    `graph_congruency()`
-   Connectedness: `graph_components()`, `graph_cohesion()`,
    `graph_adhesion()`, `graph_diameter()`, `graph_length()`
-   Diversity: `graph_blau_index()`, `graph_ei_index()`,
    `graph_assortativity()`
-   Structural holes: e.g.??`node_redundancy()`, `node_effsize()`,
    `node_efficiency()`, `node_constraint()`, `node_hierarchy()`
-   Topological features: e.g.??`graph_core()`, `graph_factions()`,
    `graph_modularity()`, `graph_smallworld()`, `graph_balance()`

#### Motifs

-   Censuses: `node_path_census()`, `node_quad_census()`,
    `node_tie_census()`, `node_triad_census()`, `graph_dyad_census()`,
    `graph_mixed_census()`, `graph_triad_census()`

#### Models

-   Blockmodelling: `node_automorphic_equivalence()`,
    `node_equivalence()`, `node_regular_equivalence()`,
    `node_structural_equivalence()`
-   Testing (via CUG/QAP): `test_permutation()`, `test_random()`
-   Linear and logistic regression for networks (via MRQAP):
    `network_reg()`

#### Visualization

-   `autographr()` for plotting graphs with sensible defaults based on
    their properties
-   New layouts: `layout_tbl_graph_frgrid()`,
    `layout_tbl_graph_gogrid()`, `layout_tbl_graph_kkgrid()`,
    `layout_tbl_graph_stressgrid()` for snapping a layout to a grid
-   Class-based plots: e.g.??`plot.matrix()`, `plot.members()`,
    `plot.node_measure()`

Please explore [the list of
functions](https://snlab-ch.github.io/migraph/reference/index.html) to
find out more.

## Installation

### Stable

The easiest way to install the latest stable version of `{migraph}` is
via CRAN. Simply open the R console and enter:

`install.packages('migraph')`

You can then begin to use `{migraph}` by loading the package:

`library(migraph)`

This will load any required packages and make the data contained within
the package available. The version from CRAN also has all the vignettes
built and included. You can check them out with:

`vignettes(package = "migraph")`

### Development

For the latest development version, for slightly earlier access to new
features or for testing, you may wish to download and install the
binaries from Github or install from source locally.

The latest binary releases for all major OSes ??? Windows, Mac, and Linux
??? can be found
[here](https://github.com/snlab-ch/migraph/releases/latest). Download
the appropriate binary for your operating system, and install using an
adapted version of the following commands:

-   For Windows:
    `install.packages("~/Downloads/migraph_winOS.zip", repos = NULL)`
-   For Mac:
    `install.packages("~/Downloads/migraph_macOS.tgz", repos = NULL)`
-   For Unix:
    `install.packages("~/Downloads/migraph_linuxOS.tar.gz", repos = NULL)`

To install from source the latest main version of `{migraph}` from
Github, please install the `{remotes}` or `{devtools}` package from CRAN
and then:

-   For latest stable version:
    `remotes::install_github("snlab-ch/migraph")`
-   For latest development version:
    `remotes::install_github("snlab-ch/migraph@develop")`

## Relationship to other packages

It draws together, updates, and builds upon many functions currently
available in other excellent R packages such as
[`{bipartite}`](https://github.com/biometry/bipartite),
[`{multinet}`](https://CRAN.R-project.org/package=multinet), and
[`{tnet}`](https://toreopsahl.com/tnet/), and implements many additional
features currently only available outside the R ecosystem in packages
such as
[**UCINET**](https://sites.google.com/site/ucinetsoftware/download?authuser=0).

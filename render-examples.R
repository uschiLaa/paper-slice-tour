library(tourr)
library(tidyverse)

# Generate samples on a 3d and 5d hollow sphere using the geozoo package
sphere3 <- geozoo::sphere.hollow(3, 2000)$points
sphere5 <- geozoo::sphere.hollow(5, 5000)$points

# Columns need to be named before launching the tour
colnames(sphere3) <- c("x1", "x2", "x3")
colnames(sphere5) <- c("x1", "x2", "x3", "x4", "x5")

# Animate with the slice display using the default parameters
max_f <- 100 # max frames for rendering the animation
set.seed(2019)
render(sphere3, grand_tour(), display_slice(), 'png', "gifs/png/sphere-3-centered-%03d.png", frames = max_f, rescale = FALSE)

set.seed(2019)
render(sphere5, grand_tour(), display_slice(), 'png', "gifs/png/sphere-5-centered-%03d.png", frames = max_f, rescale = FALSE)


# Animate with off-center anchoring
anchor3 <- rep(0.7, 3)
anchor5 <- rep(0.5, 5)

set.seed(2019)
render(sphere3, grand_tour(), display_slice(anchor = anchor3), 'png', "gifs/png/sphere-3-anchored-%03d.png", frames = max_f, rescale = FALSE)

# Animate with thicker slice to capture more points in each view
set.seed(2019)
render(sphere5, grand_tour(), display_slice(anchor = anchor5), 'png', "gifs/png/sphere-5-anchored-%03d.png", frames = max_f, rescale = FALSE)

#testing out different anchor in 5d with large sample
sphere5 <- geozoo::sphere.hollow(5, 50000)$points
colnames(sphere5) <- c("x1", "x2", "x3", "x4", "x5")
anchor5 <- c(1.1, 0, 0, 0, 0)
animate(sphere5, grand_tour(), display_slice(anchor = anchor5), rescale = FALSE)

### playing with other exampels

ex1 <- geozoo::boy.surface()$points
colnames(ex1) <- c("x1", "x2", "x3")
animate_slice(ex1)

ex2 <- geozoo::cross.cap()$points
colnames(ex2) <- c("x1", "x2", "x3")
animate_slice(ex2)

# nice example, only sometimes do we see "corners and edges"
ex3 <- geozoo::cube.face(6)$points %>%
  center()
colnames(ex3) <- c("x1", "x2", "x3", "x4", "x5", "x6")
animate_slice(ex3)

ex4 <- geozoo::dini.surface()$points %>%
  scale()
colnames(ex4) <- c("x1", "x2", "x3")
animate_slice(ex4)

ex5 <- geozoo::enneper.surface()$points %>%
  scale()
colnames(ex5) <- c("x1", "x2", "x3")
animate_slice(ex5)

# not so nice as example
ex6 <- geozoo::klein.fig.eight()$points %>%
  scale()
colnames(ex6) <- c("x1", "x2", "x3", "x4")
animate_slice(ex6)

ex7 <- geozoo::mobius()$points %>%
  scale()
colnames(ex7) <- c("x1", "x2", "x3")
animate_slice(ex7)

ex8 <- geozoo::roman.surface()$points %>%
  scale()
colnames(ex8) <- c("x1", "x2", "x3")
animate_slice(ex8)

# cant really make sense of the torus
ex9 <- geozoo::torus.flat()$points
colnames(ex9) <- c("x1", "x2", "x3", "x4")
anchorT <- c(0.5, 0.5, 0.5, 0.5)
animate_slice(ex9, anchor=anchorT)

ex10 <- geozoo::torus(p=4)$points %>%
  scale()
colnames(ex10) <- c("x1", "x2", "x3", "x4")
animate_slice(ex10, eps=0.01)

# Classical pollen data: this doesn't work, structure is 2D in 5D so mostly missed
library(animation)
data(pollen)
pollen <- as.matrix(pollen)
animate_slice(pollen, axes = "bottomleft", eps=0.0001, rescale=TRUE)

# Could we look at nonlinear boundaries between classifiers
library(RColorBrewer)
wine_radial <- read_csv("data/wine-svm-radial.csv")
wine_poly <- read_csv("data/wine-svm-poly.csv")
clrs <- brewer.pal(3, "Dark2")
col <- clrs[as.numeric(as.factor(wine_poly$type))]
wine_poly_scaled <- scale(as.matrix(wine_poly[,1:5]))
animate_slice(as.matrix(wine_poly[,1:5]), axes = "bottomleft", 
              eps=0.001, col=col)
animate_slice(wine_poly_scaled, axes = "bottomleft", 
              eps=0.05, col=col)
animate_xy(as.matrix(wine_poly[,1:5]), axes = "bottomleft", col=col)


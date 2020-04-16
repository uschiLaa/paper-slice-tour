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
render(sphere3, grand_tour(), display_slice(axes="off"), 'png', "gifs/png/sphere-3-centered-%03d.png", frames = max_f, rescale = FALSE)

set.seed(2019)
render(sphere5, grand_tour(), display_slice(axes="off"), 'png', "gifs/png/sphere-5-centered-%03d.png", frames = max_f, rescale = FALSE)


# Animate with off-center anchoring
anchor3 <- rep(0.7, 3)

set.seed(2019)
render(sphere3, grand_tour(), display_slice(anchor = anchor3, axes="off"), 'png', "gifs/png/sphere-3-anchored-%03d.png", frames = max_f, rescale = FALSE)

# render 5d sphere with large number of points and off-center anchor
sphere5 <- geozoo::sphere.hollow(5, 20000)$points
colnames(sphere5) <- c("x1", "x2", "x3", "x4", "x5")
anchor5 <- c(1.2, rep(0, 4))
max_f <- 100 # max frames for rendering the animation
set.seed(2019)
render(sphere5, grand_tour(), display_slice(anchor = anchor5, axes="off", eps=0.01), 'png', "gifs/png/sphere-5-anchored-%03d.png", frames = max_f, rescale = FALSE)


torus4 <- geozoo::torus(p=4)$points %>%
  scale()
colnames(torus4) <- c("x1", "x2", "x3", "x4")
set.seed(2019)
render(torus4, grand_tour(), display_slice(eps=0.2, axes="off"), 'png', "gifs/png/torus-4-centered-%03d.png", frames = max_f, rescale = FALSE)

cube6 <- geozoo::cube.face(6)$points %>%
  center()
colnames(cube6) <- c("x1", "x2", "x3", "x4", "x5", "x6")
set.seed(2019)
render(cube6, grand_tour(), display_slice(eps=0.01, axes="off"), 'png', "gifs/png/cube-6-centered-%03d.png", frames = max_f, rescale = FALSE)

cubeAnchor <- c(1, 0, 0, 0, 0, 0)
set.seed(2019)
render(cube6, grand_tour(), display_slice(anchor = cubeAnchor, axes="off"), 'png', "gifs/png/cube-6-anchored-%03d.png", frames = max_f, rescale = FALSE)

rmS <- geozoo::roman.surface()$points %>%
  scale()
colnames(rmS) <- c("x1", "x2", "x3")
set.seed(2019)
render(rmS, grand_tour(), display_slice(axes="off"), 'png', "gifs/png/roman-surface-centered-%03d.png", frames = max_f, rescale = FALSE)


library(animation)
data(pollen)
pollen <- as.matrix(pollen) %>% scale()
set.seed(2019)
render(pollen, grand_tour(), display_slice( half_range=3, eps=0.0005, axes = "bottomleft"), 'png', "gifs/png/pollen-%03d.png", frames = max_f, rescale = FALSE)

set.seed(201909)
render(pollen, grand_tour(), display_slice( half_range=1, eps=0.005, axes = "bottomleft"), 'png', "gifs/png/pollen-zoom-%03d.png", frames = max_f, rescale = FALSE)

library(RColorBrewer)
wine_poly <- read_csv("data/wine-svm-poly.csv")
clrs <- brewer.pal(3, "Dark2")
col <- clrs[as.numeric(as.factor(wine_poly$type))]
wine_poly_scaled <- scale(as.matrix(wine_poly[,1:5]))
set.seed(201909)
render(wine_poly_scaled, grand_tour(), 
       display_slice(axes = "bottomleft", eps=0.15, col=col, cex=4), 
       'png', "gifs/png/wine-poly/wine-poly-%03d.png", frames = max_f, rescale = FALSE)

# render as projections
set.seed(201909)
render(wine_poly_scaled, 
       grand_tour(), display_xy(axes = "bottomleft", col=col), 
       'png', "gifs/png/wine-poly-projected/wine-poly-projected-%03d.png", frames = max_f, rescale = FALSE)

# Radial
wine_radial <- read_csv("data/wine-svm-radial.csv")
wine_radial <- wine_radial %>% 
  group_by(type) %>%
  sample_frac(0.5)

col <- clrs[as.numeric(as.factor(wine_radial$type))]
wine_radial_scaled <- scale(as.matrix(wine_radial[,1:3]))
set.seed(201909)
render(wine_radial_scaled, grand_tour(), 
       display_slice(axes = "bottomleft", eps=0.05, col=col), 
       'png', "gifs/png/wine-radial/wine-radial-%03d.png", frames = max_f, rescale = FALSE)
set.seed(201909)
render(wine_radial_scaled, 
       grand_tour(), display_xy(axes = "bottomleft", col=col), 
       'png', "gifs/png/wine-radial-projected/wine-radial-projected-%03d.png", frames = max_f, rescale = FALSE)


# Render to animated gif
library(gifski)
all_dir <- list.dirs(path = "gifs/png", recursive = FALSE)
for (d in all_dir){
  name <- paste0("gifs/", strsplit(d, "/")[[1]][3], ".gif")
  fls <- list.files(d, full.names = TRUE)
  gifski(fls , name)
}



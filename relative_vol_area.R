

relVol <- function(n, r){
  function(h){
    x <- 1 - (h/r)^2
    a <- (n+1) / 2
    b <- 1/2
    1 - pbeta(x, a, b)
  }
}

#almost right
relVol <- function(n, r){
  Vectorize(
  function(h){
    (((2*h)/r)^(n-2)) * (pi^((4-n)/2)) * (gamma((n/2)+1))
  }
  )
}

relArea <- function(n, r){
  function(h){
    x <- 1 - (h/r)^2
    a <- (n-1) / 2
    b <- 1/2
    1 - pbeta(x, a, b)
  }
}

pbetaX <- function(n, r){
  function(x){
    pbeta(1-x^2, n/2, 1/2)
  }
}

r <- 1

ggplot(data.frame(x=c(0.01, 0.5)), aes(x=x)) +
  stat_function(fun=relVol(3, r), geom="line", color="black") +
  stat_function(fun=relVol(4, r), geom="line", color="purple") +
  stat_function(fun=relVol(6, r), geom="line", color="blue") +
  stat_function(fun=relVol(10, r), geom="line", color="green") +
  stat_function(fun=relVol(20, r), geom="line", color="red") +
  stat_function(fun=relArea(3, r), geom="line", color="black", linetype="dashed") +
  stat_function(fun=relArea(4, r), geom="line", color="purple", linetype="dashed") +
  stat_function(fun=relArea(6, r), geom="line", color="blue", linetype="dashed") +
  stat_function(fun=relArea(10, r), geom="line", color="green", linetype="dashed") +
  stat_function(fun=relArea(20, r), geom="line", color="red", linetype="dashed") +
  xlab("h") +
  ylab("relative volume/area")

ggplot(data.frame(x=c(0.01, 0.5)), aes(x=x)) +
  stat_function(fun=relVol(3, r), geom="line", color="black") +
  stat_function(fun=relVol(4, r), geom="line", color="blue") +
  stat_function(fun=relVol(5, r), geom="line", color="green") +
  stat_function(fun=relVol(6, r), geom="line", color="red") +
  xlab("h") +
  ylab("relative volume/area")

ggplot(data.frame(x=c(0, 0.2)), aes(x=x)) +
  stat_function(fun=pbetaX(3, r), geom="line", color="black") +
  stat_function(fun=pbetaX(6, r), geom="line", color="blue") +
  stat_function(fun=pbetaX(10, r), geom="line", color="green") +
  stat_function(fun=pbetaX(20, r), geom="line", color="red") +
  xlab("h") +
  ylab("pbeta")

library(zipfR)
hPerRelVol <- function(n, r){
    function(vrel){
      x <- 1 - vrel
      a <- (n+1) / 2
      b <- 1/2
      r * sqrt(1 - Rbeta.inv(x, a, b))
    }
}

ggplot(data.frame(x=c(0.01, 0.2)), aes(x=x)) +
  stat_function(fun=hPerRelVol(3, r), geom="line", color="black") +
  stat_function(fun=hPerRelVol(4, r), geom="line", color="blue") +
  stat_function(fun=hPerRelVol(5, r), geom="line", color="green") +
  stat_function(fun=hPerRelVol(6, r), geom="line", color="red") +
  xlab("relative volume") +
  ylab("h")


### as simulation

inSliceFracFull <- function(n, nPt=100000){
  Vectorize(
  function(h){
    d <- geozoo::sphere.solid.random(n, nPt)$points
    anchor <- rep(0, n)
    plane <- tourr::basis_init(n, 2)
    distV <- tourr::anchored_orthogonal_distance(plane, d, anchor)
    sum(distV < h) / nPt
  }
  )
}

inSliceFracHollow <- function(n, nPt=100000){
  Vectorize(
  function(h){
    d <- geozoo::sphere.hollow(n, nPt)$points
    anchor <- rep(0, n)
    plane <- tourr::basis_init(n, 2)
    distV <- tourr::anchored_orthogonal_distance(plane, d, anchor)
    sum(distV < h) / nPt
  }
  )
}

ggplot(data.frame(x=c(0.01, 0.5)), aes(x=x)) +
  stat_function(fun=inSliceFracFull(3), geom="line", color="black") +
  stat_function(fun=inSliceFracFull(4), geom="line", color="blue") +
  stat_function(fun=inSliceFracFull(5), geom="line", color="green") +
  stat_function(fun=inSliceFracFull(6), geom="line", color="red") +
  stat_function(fun=inSliceFracHollow(3), geom="line", color="black", linetype="dashed") +
  stat_function(fun=inSliceFracHollow(4), geom="line", color="blue", linetype="dashed") +
  stat_function(fun=inSliceFracHollow(5), geom="line", color="green", linetype="dashed") +
  stat_function(fun=inSliceFracHollow(6), geom="line", color="red", linetype="dashed") +
  xlab("h") +
  ylab("relative volume/area")


relVolCube <- function(p, r){
  Vectorize(
    function(h){
      (h/(2*r))^(p-2)
    }
  )
}

ggplot(data.frame(x=c(0.01, 0.5)), aes(x=x)) +
  stat_function(fun=relVolCube(3, r), geom="line", color="black") +
  stat_function(fun=relVolCube(4, r), geom="line", color="blue") +
  stat_function(fun=relVolCube(5, r), geom="line", color="green") +
  stat_function(fun=relVolCube(6, r), geom="line", color="red") +
  xlab("h") +
  ylab("relative volume/area")


hrelForVrel <- function(vrel, r){
  Vectorize(
    function(p){
      (2 * r * vrel^(1/(p-2)))/(2*r)
    }
  )
}

ggplot(data.frame(x=c(3, 50)), aes(x=x)) +
  stat_function(fun=hrelForVrel(0.001, r), geom="line", color="black") +
  stat_function(fun=hrelForVrel(0.01, r), geom="line", color="blue") +
  stat_function(fun=hrelForVrel(0.05, r), geom="line", color="green") +
  stat_function(fun=hrelForVrel(0.1, r), geom="line", color="red") +
  xlab("p") +
  ylab("h/r")



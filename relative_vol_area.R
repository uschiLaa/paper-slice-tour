

relVol <- function(n, r){
  function(h){
    x <- 1 - (h/r)^2
    a <- (n+1) / 2
    b <- 1/2
    1 - pbeta(x, a, b)
  }
}

relArea <- function(n, r){
  function(h){
    x <- 1 - (h/r)^2
    a <- (n-1) / 2
    b <- 1/2
    1 - pbeta(x, a, b)
  }
}

r <- 1

ggplot(data.frame(x=c(0.01, 0.2)), aes(x=x)) +
  stat_function(fun=relVol(3, r), geom="line", color="black") +
  stat_function(fun=relVol(6, r), geom="line", color="blue") +
  stat_function(fun=relVol(10, r), geom="line", color="green") +
  stat_function(fun=relVol(20, r), geom="line", color="red") +
  stat_function(fun=relArea(3, r), geom="line", color="black", linetype="dashed") +
  stat_function(fun=relArea(6, r), geom="line", color="blue", linetype="dashed") +
  stat_function(fun=relArea(10, r), geom="line", color="green", linetype="dashed") +
  stat_function(fun=relArea(20, r), geom="line", color="red", linetype="dashed") +
  xlab("h") +
  ylab("relative volume")

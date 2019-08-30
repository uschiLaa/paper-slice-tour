

relVolCube <- function(p){
  Vectorize(
    function(x){
      (x)^(p-2)
    }
  )
}

erf <- function(x) 2 * pnorm(x * sqrt(2)) - 1
erfinv <- function (x) qnorm((1 + x)/2)/sqrt(2)

relVolNormal <- function(p){
  Vectorize(
    function(x){
      pi^((2-p)/2) * (erf(x/sqrt(2)))^(p-2)
    }
  )
}

ggplot(data.frame(x=c(0.01, 0.2)), aes(x=x)) +
  stat_function(fun=relVolCube(3), geom="line", color="black") +
  stat_function(fun=relVolCube(4), geom="line", color="blue") +
  stat_function(fun=relVolCube(5), geom="line", color="green") +
  stat_function(fun=relVolCube(6), geom="line", color="red") +
  stat_function(fun=relVolNormal(3), geom="line", color="black", linetype="dashed") +
  stat_function(fun=relVolNormal(4), geom="line", color="blue", linetype="dashed") +
  stat_function(fun=relVolNormal(5), geom="line", color="green", linetype="dashed") +
  stat_function(fun=relVolNormal(6), geom="line", color="red", linetype="dashed") +
  xlab("h/r") +
  ylab("relative volume/area") +
  scale_y_log10()


hrelForVrel <- function(vrel){
  Vectorize(
    function(p){
      vrel^(1/(p-2))
    }
  )
}

hrelForVolNormal <- function(vrel){
  Vectorize(
    function(p){
      sqrt(2) * erfinv(vrel^(1/(p-2)) * sqrt(pi))
    }
  )
}

ggplot(data.frame(x=c(3, 50)), aes(x=x)) +
  stat_function(fun=hrelForVrel(0.001), geom="line", color="black") +
  stat_function(fun=hrelForVrel(0.01), geom="line", color="blue") +
  stat_function(fun=hrelForVrel(0.05), geom="line", color="green") +
  stat_function(fun=hrelForVrel(0.1), geom="line", color="red") +
  stat_function(fun=hrelForVolNormal(0.001), geom="line", color="black", linetype="dashed") +
  stat_function(fun=hrelForVolNormal(0.01), geom="line", color="blue", linetype="dashed") +
  stat_function(fun=hrelForVolNormal(0.05), geom="line", color="green", linetype="dashed") +
  stat_function(fun=hrelForVolNormal(0.1), geom="line", color="red", linetype="dashed") +
  xlab("p") +
  ylab("h/r")



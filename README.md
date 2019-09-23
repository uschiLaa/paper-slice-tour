# A slice tour for finding hollowness in high-dimensional data

Taking projections of high-dimensional data is a common analytical and visualisa- tion technique in statistics for working with high-dimensional problems. Sectioning, or slicing, through high dimensions is less common, but can be useful for visualising data with concavities, or non-linear structure. It is associated with conditional dis- tributions in statistics, and also linked brushing between plots in interactive data visualisation. This short technical note describes a simple approach for slicing in the orthogonal space of projections obtained when running a tour, thus presenting the viewer with an interpolated sequence of sliced projections. The method has been implemented in R as an extension to the tourr package, and can be used to explore for concave and non-linear structures in multivariate distributions.

Animations
-------------

3D hollow sphere <img src="gifs/sphere-3-centered.gif" width="170"/>

5D hollow sphere <img src="gifs/sphere-5-centered.gif" width="170"/>

3D hollow sphere, off-center <img src="gifs/sphere-3-anchored.gif" width="170"/>

5D hollow sphere, off-center <img src="gifs/sphere-5-anchored.gif" width="170"/>

Roman surface <img src="gifs/roman-surface-centered.gif" width="170"/>

4D torus <img src="gifs/torus-4-centered.gif" width="170"/>

6D hollow cube <img src="gifs/cube-6-centered.gif" width="170"/>

Pollen data <img src="gifs/pollen.gif" width="170"/>

Pollen data zoom <img src="gifs/pollen-zoom.gif" width="170"/>

Wine classifier radial projected <img src="gifs/wine-radial-projected.gif" width="170"/>

Wine classifier polynomial projected <img src="gifs/wine-poly-projected.gif" width="170"/>

Wine classifier radial sliced <img src="gifs/wine-radial.gif" width="170"/>

Wine classifier polynomial sliced <img src="gifs/wine-poly.gif" width="170"/>


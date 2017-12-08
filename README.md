# BIN-score

Contains code for computing the Boundary Intersection Number for quantifying gerrymandering. The measure estimates the expected 
value of the number of times a randomly placed observer inside a polygon
will cross over the polygon boundary in a randomly selected direction using a Monte Carlo method.
The lowest possible score is 1, which occurs precisely when the polygon is convex. 
Increasing numbers measure increasingly distorted polygon boundaries, which are indicative of gerrymandering. A justification for this approach along
with a precise definition and theoretical properties can be found in the original paper: http://scholarworks.sjsu.edu/cgi/viewcontent.cgi?article=8408&context=etd_theses

## Usage

Usage is straghtforward. The `estimate_y` function takes as input a shapefile element, the number of samples and optional key-value pairs for plotting. The following example computes the BIN score for Illinois' 4th district and plots the district with the sample direction vectors. It is recommended to use at least 500 samples to reduce sample variance. 

```
# load data
districts = shaperead('.\districts114.shp')
n_samples = 40;
y = estimate_y(districts(285), n_samples, 'plot_arrows', true, 'plot_shape', true, 'title','Illinois 4th District')
```

![ill4th](https://user-images.githubusercontent.com/26914851/33750725-c1e4d67e-db8a-11e7-981c-0fc64b3906e2.png)

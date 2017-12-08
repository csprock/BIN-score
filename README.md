# BIN-score

Contains code for computing the Boundary Intersection Number for quantifying gerrymandering. The measure estimates the expected 
value of the number of times a randomly placed observer inside a polygon
will cross over the polygon boundary in a randomly selected direction. 
The lowest possible score is 1, which occurs precisely when the polygon is convex. 
Increasing numbers measure increasingly distorted polygon boundaries, which are indicative of gerrymandering. A justification for this approach along
with a precise definition and theoretical properties can be found in the original paper: http://scholarworks.sjsu.edu/cgi/viewcontent.cgi?article=8408&context=etd_theses

For usage details of the Matlab code, check out the github wiki. Shapefiles for US Congressional districts can be found at http://cdmaps.polisci.ucla.edu

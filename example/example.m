
%%%%% boundary intersection number gerrymandering demonstration %%%%%
% Congressional district boundary data citation:
%%% http://cdmaps.polisci.ucla.edu/
%%% Jeffrey B. Lewis, Brandon DeVine, Lincoln Pitcher, and Kenneth C. Martis. (2013) Digital Boundary Definitions of United States Congressional Districts, 1789-2012. [Data file and code book]. Retrieved from http://cdmaps.polisci.ucla.edu on [date of download]

%%% load district shapefiles
districts = shaperead('.\districts114.shp');
%Illinois 4th has index 285

%%% choose random district
%r = randsample(length(districts),1);
r = 285;
plot(districts(r).X, districts(r).Y,'black')
%% %%% randomly sample from district
n = 200; %set number of samples
H = shapesample(districts(r), n, true, 'title','this is a title');
%% %%% Monte Carlo estimation of Y
Y = estimate_y(districts(r), 35, true, true, 'title','hello');
disp(Y)






















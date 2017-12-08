
%%%%% boundary intersection number gerrymandering demonstration %%%%%
% Congressional district boundary data citation:
%%% http://cdmaps.polisci.ucla.edu/
%%% Jeffrey B. Lewis, Brandon DeVine, Lincoln Pitcher, and Kenneth C. Martis. (2013) Digital Boundary Definitions of United States Congressional Districts, 1789-2012. [Data file and code book]. Retrieved from http://cdmaps.polisci.ucla.edu on [date of download]

%%% load district shapefiles
districts = shaperead('.\districts114.shp');

% estimate BIN score of Illinois 4th District using 40 sample points and
% plot district and vectors
y = estimate_y(districts(285), 40, true, true, 'title','Illinois 4th District');























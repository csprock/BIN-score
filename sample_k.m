function [k , rvec]= sample_k(x,y,N,shape)

% Takes a point (x,y), the number of desired number of random vectors per
% point N (set to 1 by default when called by estimate_y), and a shape 
% (in shapefile) and computes k (number  for boundary
% intersections). This is done by translating the shape to be centered on
% the point (x,y) which becomes the origin of a coordinate system whence
% random vector(s) generated and the number of boundary intersections by
% computed by solving a linear system for each edge of the polygon. 

% translates shape to be centered at (x,y)
newShape = translateToOrigin(x,y, shape.X, shape.Y);
% stores X and Y coordinates of new shape as struct array
newShape = struct('X',newShape(:,1)', 'Y', newShape(:,2)');
% apply shapeparts() to newShape
[shape_parts,~] = shapeparts(newShape);
% generate N random unit vectors
rvec = randomUnitVector(N);
% apply comp_k() function to compute boundary intersections of each vector
k = arrayfun(@(x,y) comp_k(x,y, shape_parts),rvec(:,1), rvec(:,2));
% return total number of intersection
k = sum(k);
end

function k = comp_k(x,y, shape_parts)
% applies the edgeIntersect() function to each component of shape_parts

vec = [x,y];
temp = cellfun(@(shapes) edgeIntersect(vec, shapes), shape_parts);
k = sum(temp);
end

function vrand = randomUnitVector(n)

% returns n random unit vectors centered at the origin

theta_rand = 2*pi*rand([n,1]);
vrand = zeros(n,2);
vrand(:,1) = cos(theta_rand);
vrand(:,2) = sin(theta_rand);
end

%% translateToOrigin()

function[newCoords] = translateToOrigin(x0, y0, X,Y)
%translates the coordinates (X,Y) about (x0,y0)
newCoords = [X - x0; Y - y0]';
end

%% edgeIntersect()

function Y = edgeIntersect(vec, shape)

% Checks how many times the vector vec intersects the boundary of shape
% by applying checkEdge() to each pair of vertices that define an edge

n = size(shape,1);
temp = zeros(n,1);

for i=1:(n-1)   
    temp(i) = checkEdge(vec, shape(i:(i+1),:));
end
Y = sum(temp);
end

%% checkEdge()

function k = checkEdge(vec, A)

% Determines if the vector vec is a positive linear combination of the
% rows of the 2x2 matrix A. To save computational time, vectors that lie
% in a quadrant different than either of the rows of A are ignored. 

Qv = checkQuadrant(vec); %get quadrant of input vector

%get quadrants of rows of A
A1=checkQuadrant(A(1,:));
A2=checkQuadrant(A(2,:));

if (A1 == Qv || A2 == Qv)    
    %either row of A lies in the same quadrant as the input vector, check
    %the sign of the coefficients of Av = b 
    b = linsolve(A',vec');    
    if (b(1)>=0 && b(2)>=0)
        k = 1;
    else
        k = 0;
    end
else
    k = 0; 
end
end

%% checkQuadrant()

function quadrant = checkQuadrant(vec)

% Finds the quadrant of a 2D vector

x = vec(1); y = vec(2);

if (x >= 0 && y >= 0)
    quadrant = 1;
elseif (x < 0 && y >= 0)
    quadrant = 2;
elseif (x < 0 && y < 0)
    quadrant = 3;
else
    quadrant = 4;
end
end
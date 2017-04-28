function D_sample = shapesample(N, shape, plt)

% This function computes N uniform samples from inside the polygon in the shapefile
% record with optional plotting. Sampling is done by sampling points from 
% inside the bounding box of the shape using sampleBox(). The function inshape() 
% determines if the point is contained in the polygon. Sample points falling outside the 
% polygon and discarded. This process is repeated until enough samples 
% inside the polygon have been found.


sample_points = sampleBox(N, shape);                                               % sampleBox()
parts = shapeparts(shape);                                                         % shapeparts()
q = arrayfun(@(x,y) inshape(x,y,parts), sample_points(:,1), sample_points(:,2));   % apply inshape()
D_sample = [sample_points(q == 1,1), sample_points(q == 1,2)];

% continue generating samples until N samples is reached. 

k = sum(q);   %while number of samples inside polygon < N, continue sampling
while k < N
    sample_points = sampleBox(N,shape);
    q = arrayfun(@(x,y) inshape(x,y,parts), sample_points(:,1), sample_points(:,2)); 
    k = k + sum(q);
    
    newSample = [sample_points(q == 1,1), sample_points(q == 1,2)];
    if k < N
        D_sample = [D_sample; newSample];
    else
        D_sample = [D_sample; newSample];
        i = randsample(k, N);
        D_sample = D_sample(i,:);
    end
end

% plot shape and sample points
if plt == 1
    figure
    axis([shape.BoundingBox(1,1) shape.BoundingBox(1,2) shape.BoundingBox(2,1) shape.BoundingBox(2,2)])
    scatter(D_sample(:,1),D_sample(:,2),'.', 'r')
    hold on
    plot(shape.X,shape.Y,'black')
    title(strcat(shape.STATENAME, ' ',shape.DISTRICT, ', N=',num2str(N))) 
    axis off
end    
end

%% inshape()

function IN = inshape(x,y, shape_parts)

% Binary indicator variable for whether a given point (x,y) lies in the given
% shape_parts variable. Applies built-in function inpolygon() over polygons
% defined by the parts of shape_parts.

IN = cellfun(@(xv) inpolygon(x,y,xv(:,1),xv(:,2)), shape_parts);
IN = sum(IN);
end

%% sampleBox()

function sample_points = sampleBox(N, shape)

%This function returns N points sampled uniformly at random from inside the
%bounding box of shape.

Xrand = shape.BoundingBox(1,1) + (shape.BoundingBox(2,1) - shape.BoundingBox(1,1))*rand(N,1);
Yrand = shape.BoundingBox(1,2) + (shape.BoundingBox(2,2) - shape.BoundingBox(1,2))*rand(N,1);
sample_points = [Xrand, Yrand];
end



















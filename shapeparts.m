function [coords, indices]  = shapeparts(shape)

% This function creates a coordinate matrix for each disconnected polygon
% in the given shapefile record. The output D_parts is a #components-by-1
% cell where each entry contains the coordinate matrix for that component.

%create coordinate list
D = [shape.X', shape.Y'];

%components separated by NaN in shapefile coordinate list
NaNs = isnan(D(:,1));
separators = find(NaNs == 1);
%add 1 as the first coordinate to the separator index vector
separators = [1 separators']';

%initialize output cells
m = length(separators);
coords = cell(m-1,1);
indices = cell(m-1,1);

%gets coordinates contained between separator indices and stores each
%componant in cell of 'coords' 
for t = 1:(m-1);
    
    %indices of consecutive component separators
    i_min = separators(t);
    i_max = separators(t+1);
    
    %interval in list corresponding to component
    %all values between i_min and i_max
    interval = (i_min+1):1:(i_max-1);
    indices{t,1} = interval;
    coords{t,1} = D(interval,:);
end
end

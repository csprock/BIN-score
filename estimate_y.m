function BIN = estimate_y(shape, N_points, varargin)

% This function estimates BIN using the Monte Carlo method with optional
% plotting. The shapesample() function is called to generate sample points
% from inside the shape. The sample_k() function is then applied over the
% list of sample points, returning the number of intersections of randomly
% choosen direction vectors starting at each sample point. The estimated BIN
% is the mean of these intersections. 

p = inputParser;
addRequired(p, 'shape');
addRequired(p, 'N_points');
addOptional(p, 'plot_arrows', false, @islogical);
addOptional(p, 'plot_shape',false, @islogical);
addParameter(p, 'title', 'BIN Score', @ischar);
parse(p, 'shape','N_points', varargin{:});

% assign title
ttl = p.Results.title;

% get sample points using shapesample()
shape_samples = shapesample(shape, N_points); 
disp('Sampling Complete. Computing BIN...')

% compute boundary intersections k
[k, vec] = arrayfun(@(x,y) sample_k(x,y,1,shape), shape_samples(:,1), shape_samples(:,2),'un',0);

% convert k from cell to array
temp = zeros(length(k),1);
for i = 1:length(k)
    temp(i,1) = k{i};
end
BIN = mean(temp); % compute BIN estimate

msg = strcat('Estimated BIN = ',num2str(BIN));
disp(msg)

% plot shape with direction arrows
if (p.Results.plot_arrows == true && p.Results.plot_shape == true)
    figure
    axis([shape.BoundingBox(1,1) shape.BoundingBox(1,2) shape.BoundingBox(2,1) shape.BoundingBox(2,2)])
    plot(shape.X,shape.Y, 'black')
    hold on
    
    P1 = [shape.BoundingBox(1,1); shape.BoundingBox(1,2)];
    P2 = [shape.BoundingBox(2,1); shape.BoundingBox(1,2)];
    
    d = sqrt(((P1(1) - P2(1))^2 + (P1(2) - P2(2))^2));
    
    s = 0.1*d; %set direction arrow magnitude

    % plot direction arrows
    for i=1:N_points
          p0 = [shape_samples(i,1), shape_samples(i,2)]'; p1 = [s*vec{i}(1)+shape_samples(i,1), s*vec{i}(2)+shape_samples(i,2)]';
          x0 = p0(1);
          y0 = p0(2);
          x1 = p1(1);
          y1 = p1(2);
          plot([x0;x1],[y0;y1]);   % Draw a line between p0 and p1
          
          p = p1-p0;
          
          alpha = 0.3;  % Size of arrow head relative to the length of the vector
          beta = 0.2;   % Width of the base of the arrow head relative to the length
          
          hu = [x1-alpha*(p(1)+beta*(p(2)+eps)); x1; x1-alpha*(p(1)-beta*(p(2)+eps))];
          hv = [y1-alpha*(p(2)-beta*(p(1)+eps)); y1; y1-alpha*(p(2)+beta*(p(1)+eps))];
          hold on
          plot(hu(:)',hv(:)')
          hold on
    end
    title(strcat(ttl, ', N = ', num2str(N_points), ', BIN = ',num2str(BIN)), 'FontSize',12)
    axis off
    
    % plot shape shape only
elseif (p.Results.plot_arrows == false && p.Results.plot_shape == true)
    figure
    axis([shape.BoundingBox(1,1) shape.BoundingBox(1,2) shape.BoundingBox(2,1) shape.BoundingBox(2,2)])
    plot(shape.X,shape.Y, 'black')
    axis off
    title(strcat(ttl, ', BIN = ',num2str(BIN)), 'FontSize',12)
else
    %%%%%%%%
end
end



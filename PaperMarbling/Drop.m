classdef Drop < handle
    % Drop of ink for paper marbling simulation

    properties
        x {mustBeNumeric}
        y {mustBeNumeric}
        r {mustBeNonnegative}
        c
        vertices
    end

    methods
        function obj = Drop(x_in,y_in,r_in,c_in)
            %Drop Constructor
            %   assign the x and y values of the location and radius r of a
            %   drop
            obj.x = x_in;
            obj.y = y_in;
            obj.r = r_in;
            obj.c = c_in;
            
            n_vertices = 100*r_in;
            theta = tau/n_vertices; 
            angles = (0:n_vertices-1)*theta;
            
            obj.vertices = [arrayfun(@(t) cos(t), angles); arrayfun(@(t) sin(t), angles)]*obj.r + [obj.x;obj.y];
        end

        function place(obj)
            %place a drop of ink into the plot
            fill(obj.vertices(1,:),obj.vertices(2,:),obj.c,EdgeColor='white')
            drawnow
        end

        function marble(obj,otherDrop)
            %marbles existing drop when another drop is added
            otherCenter = [otherDrop.x; otherDrop.y];
            dist = obj.vertices-otherCenter;
            mags = arrayfun(@(x,y) sqrt(x^2 + y^2), dist(1,:), dist(2,:));
            obj.vertices = otherCenter + (dist) .* sqrt(1 + (otherDrop.r^2) ./ (mags.^2));
        end
    end
end
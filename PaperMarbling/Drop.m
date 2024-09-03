classdef Drop < handle
    % Drop of ink for paper marbling simulation

    properties
        x {mustBeReal} % x coordinate of center of drop
        y {mustBeReal} % y coordinate of center of drop
        r {mustBeNonnegative}  % radius of the drop
        c {mustBeReal} % color of the drop
        vertices % points on the circumferance of the drop
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
            
            n_vertices = 500*r_in;
            theta = tau/n_vertices; 
            angles = (0:n_vertices-1)*theta;
            
            obj.vertices = [arrayfun(@(t) cos(t), angles); arrayfun(@(t) sin(t), angles)]*obj.r + [obj.x;obj.y];
        end

        function marble(obj,otherDrop)
            %marbles existing drop when another drop is added
            C = [otherDrop.x; otherDrop.y];
            PminusC = obj.vertices-C;
            magnitudes = arrayfun(@(x,y) norm([x y]), PminusC(1,:), PminusC(2,:));
            i_moved = magnitudes>otherDrop.r;
            i_contained = magnitudes<=otherDrop.r;
            obj.vertices = C + PminusC .* sqrt(1 + otherDrop.r^2 * magnitudes.^-2);
        end
    end
end
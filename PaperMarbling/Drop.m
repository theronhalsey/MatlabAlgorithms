classdef Drop < handle
    % Drop of ink for paper marbling simulation

    properties
        x {mustBeNumeric}
        y {mustBeNumeric}
        r {mustBeNonnegative}
        d
        n_vertices
        theta
        angles
        vertices
    end

    methods
        function obj = Drop(x_in,y_in,r_in)
            %Drop Constructor
            %   assign the x and y values of the location and radius r of a
            %   drop
            obj.x = x_in;
            obj.y = y_in;
            obj.r = r_in;
            obj.d = 2*r_in;
            obj.n_vertices = 100*r_in;
            obj.theta = tau/obj.n_vertices; 
            obj.angles = (0:obj.n_vertices-1)*obj.theta;
            obj.vertices = [arrayfun(@(t) cos(t), obj.angles); arrayfun(@(t) sin(t), obj.angles)]*obj.r + [obj.x;obj.y];
        end

        function vertices = place(obj)
            %place a drop of ink into the plot
            vertices = obj.vertices;
            fill(obj.vertices(1,:),obj.vertices(2,:),'r',LineStyle='none')
            drawnow
        end
    end
end
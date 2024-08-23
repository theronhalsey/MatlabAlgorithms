classdef Drop
    % Drop of ink for paper marbling simulation

    properties
        x {mustBeNumeric}
        y {mustBeNumeric}
        r {mustBeNonnegative}
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
        end

        function drip = place(obj,inputArg)
            %place a drop of ink into the plot
            drip = obj.Property1 + inputArg;
        end
    end
end
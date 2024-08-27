plot([-10 10],[-10 10]);
hold on

while 1
    [c_x,c_y] = ginput(1)
    [e_x,e_y] = ginput(1)
    r = sqrt((e_x - c_x)^2 + (e_y - c_y)^2)
    D = Drop(c_x,c_y,r);
    D.place;
end
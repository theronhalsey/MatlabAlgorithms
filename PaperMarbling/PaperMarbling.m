x0 = 20;
y0 = 60;
xmax = 1400;
ymax = 700;
set(gcf,'position',[x0,y0,xmax,ymax])
axis([0,xmax,0,ymax])
hold on

n_drops = 3;

[c_x,c_y] = ginput(1);
[e_x,e_y] = ginput(1);
r = sqrt((e_x - c_x)^2 + (e_y - c_y)^2);
Drops = Drop(c_x,c_y,r);
Drops.place;

for i=2:n_drops
    [c_x,c_y] = ginput(1);
    [e_x,e_y] = ginput(1);
    r = sqrt((e_x - c_x)^2 + (e_y - c_y)^2);
    nextDrop = Drop(c_x,c_y,r);
    nextDrop.place;
    Drops(1,i) = nextDrop;
end
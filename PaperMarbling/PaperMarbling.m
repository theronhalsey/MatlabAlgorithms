x0 = 20;
y0 = 60;
xmax = 1400;
ymax = 700;
set(gcf,'position',[x0,y0,xmax,ymax])
axis([0,xmax,0,ymax])
hold on

n_drops = 3;
colors = ['r','g','b'];

[c_x,c_y] = ginput(1);
[e_x,e_y] = ginput(1);
r = sqrt((e_x - c_x)^2 + (e_y - c_y)^2);
Drops = Drop(c_x,c_y,r,colors(1));
Drops.place;

for i=2:n_drops
    % get new drop
    [c_x,c_y] = ginput(1);
    [e_x,e_y] = ginput(1);
    r = sqrt((e_x - c_x)^2 + (e_y - c_y)^2);
    newDrop = Drop(c_x,c_y,r,colors(i));
    
    % marble old drops from influence of new
    l = length(Drops);
    for j=1:l
        Drops(j).marble(newDrop)
        Drops(j).place
    end
    newDrop.place;

    % add new drop to Drops array
    Drops(1,i) = newDrop;
end
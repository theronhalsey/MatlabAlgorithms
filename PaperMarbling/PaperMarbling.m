x0 = 20;
y0 = 60;
xmax = 1400;
ymax = 700;
set(gcf,'position',[x0,y0,xmax,ymax])
axis([0,xmax,0,ymax])
hold on

manual = 0;

n_drops = 150;
r_min = 25;
r_max = 4*r_min;

if manual
    [c_x,c_y] = ginput(1);
    [e_x,e_y] = ginput(1);
    r = sqrt((e_x - c_x)^2 + (e_y - c_y)^2);
    r = max(r_min,r);
    r = min(r_max,r);
else
    c_x = xmax*rand();
    c_y = ymax*rand();
    r = r_max + (r_min-r_max).*rand();
end

Drops = Drop(c_x,c_y,r,rand(1,3));
Areas = Drops.place;
drawnow

for i=2:n_drops
    % get new drop

    if manual
        [c_x,c_y] = ginput(1);
        [e_x,e_y] = ginput(1);
        r = sqrt((e_x - c_x)^2 + (e_y - c_y)^2);
        r = max(r_min,r);
        r = min(r_max,r);
    else
        c_x = xmax*rand();
        c_y = ymax*rand();
        r = r_max + (r_min-r_max).*rand();
    end

    Drops(1,i) = Drop(c_x,c_y,r,rand(1,3));
    Areas(1,i) = Drops(1,i).place;

    % marble old drops from influence of new
    l = length(Drops);
    for j=1:l
        Drops(j).marble(Drops(1,i));
        delete(Areas(j));
        Areas(j) = Drops(j).place;
    end
    drawnow
end
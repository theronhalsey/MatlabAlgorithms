function fig = DropInk(n_drops,manual,show)
%DROPINK Summary of this function goes here
%   Detailed explanation goes here
fig = figure;
fig_x0 = 20;
fig_y0 = 60;
fig_xmax = 1400;
fig_ymax = 700;
set(gcf,'position',[fig_x0,fig_y0,fig_xmax,fig_ymax])

drop_xmin = 0;
drop_ymin = 0;
drop_xmax = 40;
drop_ymax = 20;
r_min = 1;
r_max = 2*r_min;
axis([drop_xmin,drop_xmax,drop_ymin,drop_ymax])
hold on

if manual
    [c_x,c_y] = ginput(1);
    [e_x,e_y] = ginput(1);
    r = sqrt((e_x - c_x)^2 + (e_y - c_y)^2);
    r = max(r_min,r);
    r = min(r_max,r);
else
    c_x = drop_xmax*rand();
    c_y = drop_ymax*rand();
    r = r_max + (r_min-r_max).*rand();
end

Drops = Drop(c_x,c_y,r,rand(1,3));
Areas = fill(Drops.vertices(1,:),Drops.vertices(2,:),Drops.c,EdgeColor=Drops.c,FaceAlpha=0.25,LineStyle="none",Marker=".", MarkerEdgeColor=Drops.c);

if show
    drawnow
end

for i=2:n_drops
    % get new drop

    if manual
        [c_x,c_y] = ginput(1);
        [e_x,e_y] = ginput(1);
        r = sqrt((e_x - c_x)^2 + (e_y - c_y)^2);
        r = max(r_min,r);
        r = min(r_max,r);
    else
        c_x = drop_xmax*rand();
        c_y = drop_ymax*rand();
        % inAnotherDrop = 1;
        % while inAnotherDrop
        %     c_x = drop_xmax*rand();
        %     c_y = drop_ymax*rand();
        %     for j=1:length(Drops)
        %         inAnotherDrop = inpolygon(c_x,c_y,Drops(j).vertices(1,:),Drops(j).vertices(2,:));
        %         if inAnotherDrop
        %             break
        %         end
        %     end
        % end

        r = r_max + (r_min-r_max).*rand();
    end

    Drops(i) = Drop(c_x,c_y,r,rand(1,3));
    Areas(i) = fill(Drops(i).vertices(1,:),Drops(i).vertices(2,:),Drops(i).c,EdgeColor=Drops(i).c,FaceAlpha=0.25,LineStyle="none",Marker=".", MarkerEdgeColor=Drops(i).c);

    % marble old drops from influence of new
    for j=1:length(Drops)
        before = polyarea(Drops(j).vertices(1,:),Drops(j).vertices(2,:));
        Drops(j).marble(Drops(i));
        Areas(j).Vertices(:,1) = Drops(j).vertices(1,:)';
        Areas(j).Vertices(:,2) = Drops(j).vertices(2,:)';
        after = polyarea(Drops(j).vertices(1,:),Drops(j).vertices(2,:));
        abs(before-after)
    end
    if show
        drawnow
        pause(.2)
    end
end

%in = inpolygon(otherDrop.x,otherDrop.y,obj.vertices(1,:),obj.vertices(2,:));
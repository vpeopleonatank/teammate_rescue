function [J,tmpDist]=findTargetForXRange(Boid,OBJNum,OBJs, range)
tmpDist=100000;J=0;
for i=1:OBJNum
    distance = dist(Boid,OBJs(i,:));
    if (distance<tmpDist && distance < range && ( OBJs(i,15)>0))
        tmpDist=dist(Boid,OBJs(i,:));
        J=i;
    end
end
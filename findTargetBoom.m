function [n]=findTargetBoom(Booms)
tmpDist=50;
index=1;
global Targets;
global Reds;
global RedsNum;
for i=1:RedsNum
    if (dist(Booms,Reds(i,1:4))<50 ) && ( Reds(i,15)>0)
        Targets(index)=i;
        index=index+1;
    end
end
if(index >1) 
    n=index-1;
else
    n=0;
end

function [BoidsNum,Boids,blueStatus]=UpdateBoidBlueHP(Attack,BoidsNum,Boids, blueStatus, ...
    dangCuuBoid, dangDuocBoidCuu, trangThai, thresholdHP)

for i=1:BoidsNum
    if(Boids(i, 15) > thresholdHP && (Boids(i, 15) - Attack(1, i)) <= thresholdHP)
        blueStatus(trangThai, i) = 0;
        if(blueStatus(dangCuuBoid, i) ~= 0)
            blueStatus(trangThai, blueStatus(dangCuuBoid, i)) = 0;
        end
    elseif(Boids(i, 15) <= thresholdHP && Boids(i, 15) > 0 && (Boids(i, 15) - Attack(1, i)) <= 0)
        blueStatus(trangThai, i) = 0;
        if(blueStatus(dangDuocBoidCuu, i) ~= 0)
            blueStatus(trangThai, blueStatus(dangDuocBoidCuu, i)) = 0;
        end
        blueStatus(dangDuocBoidCuu, i) = 0;
    end
    if(Boids(i,15)>0)
        Boids(i,15)=Boids(i,15)-Attack(1,i);
    end
end

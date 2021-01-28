function [BoidsNum,Boids]=UpdateBoidHP(Attack,BoidsNum,Boids)

for i=1:BoidsNum
    if(Boids(i,15)>0)    
        Boids(i,15)=Boids(i,15)-Attack(1,i); 
    end
end

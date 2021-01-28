function Behaviour__SeekBlue()
global TimeSteps;
global Reds RedsNum MaxRedNum RedsHP DieRNum;
global Blues BluesNum MaxBlueNum BluesHP DieBNum;
global Fights FightsNum MaxFightNum ObstaclesF ;
global Booms BoomsNum Targets TargetsNum;
global SaveMousePosition;
global ImageWidth;
global ObstaclesB ObstaclesNumB;
global ObstaclesR ObstaclesNumR;
global Obstacles ObstaclesNum;
global ShootDistanceB ShootDistanceR;
global kB kR Target1 Target2;
global deviationXB deviationYB deviationXR deviationYR ;
global AccuracyB AccuracyR;
global goToAttack;
global D_Behind D_Beside NumberBoidsOnTop NumberBoidsOnBranch;
goToAttack = 0;
global makeInformation;
makeInformation = zeros(1,RedsNum);
global Ambu;
global RecoveringPos;
global v_ImageE v_AlphaE;
global MaxBlueHP MaxRedHP;
%% first draw
% load image
[v_ImageR,v_AlphaR,v_ImageB,v_AlphaB,v_ImageE,v_AlphaE, imageB_bithuong, ...
    alphaB_bithuong, imageR_bithuong, alphaR_bithuong]=LoadImageBoids();
[v_ImageS1,v_AlphaS1,v_ImageS2,v_AlphaS2,v_ImageS3,v_AlphaS3,v_ImageS4,v_AlphaS4,v_ImageS5,v_AlphaS5,v_ImageS6,v_AlphaS6]=LoadImageOther1();
[v_ImageBB,v_AlphaBB,v_ImageBR,v_AlphaBR,v_ImageBF,v_AlphaBF,v_ImageF,v_AlphaF]=LoadImageBase();
[v_ImageBoom,v_AlphaBoom,v_ImageN,v_AlphaN,v_ImageEmpty,v_AlphaEmpty]=LoadImageBoom();
[v_ImageFR,v_AlphaFR,v_ImageFB,v_AlphaFB]=LoadImageFlag();
[v_ImageAmbu,v_AlphaAmbu] = LoadAmbulance();
% draw graphic
[fHandler]=InitializeGraphicN();

% draw base

[~]=InitializeBase(v_ImageBB,v_AlphaBB,v_ImageBR,v_AlphaBR,v_ImageBF,v_AlphaBF);
% [BoomsPlot]=InitializeBoom(v_ImageBoom,v_AlphaBoom,v_ImageEmpty,v_AlphaEmpty,Booms,BoomsNum);
[FightsPlot]=InitializeFight(v_ImageF,v_AlphaF);

% draw obstacles
InitializeObstacles(v_ImageS1,v_AlphaS1,v_ImageS2,v_AlphaS2,v_ImageS3,v_AlphaS3,v_ImageS4,v_AlphaS4,v_ImageS5,v_AlphaS5,v_ImageS6,v_AlphaS6)
[AmbuPlot] = initAmbulance(v_ImageAmbu,v_AlphaAmbu);
[RedsPlot]=InitializeBoid(v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsNum,Reds);
[RedsHP]=InitializeHP(RedsNum,MaxRedNum,Reds);

[BluesPlot]=InitializeBoid(v_ImageB,v_AlphaB,v_ImageE,v_AlphaE,BluesNum,Blues);
[BluesHP]=InitializeHP(BluesNum,MaxBlueNum,Blues);

%%load sound
[bomb,gun,fight,bombFs,gunFs,fightFs]=loadSound();
% [back_sound,back_soundFs] = audioread('victory.mp3');
% back_sound=back_sound(1:300*back_soundFs);
% sound(back_sound, back_soundFs);
%%
titleStr = 'Mo phong: Chien dau, dua nguoi bi thuong ve can cu';
% titleStr = [titleStr newline '(click de chon diem xep doi hinh tan cong,phong thu)'];
title(titleStr);
set(fHandler, 'WindowButtonDownFcn',@cursorClickCallback);


%% calculate agents' positions to move to each iteration
timeTick = 1;
% sound(fight,fightFs);
Blues = InitArcFormationForFlock(Blues, BluesNum, [-200, -200, 0], v_ImageB, v_AlphaB, BluesPlot);
Reds = InitArcFormationForFlock(Reds, RedsNum, [300, 300, 0], v_ImageR, v_AlphaR, RedsPlot);

%%
stage = 1;
middleBlueTarget = [0 0 0 0 0 0];
middleRedTarget = [50 50 0 0 0 0];
thresholdBiThuong = 0.4;
recoveryBluePos = [-200 -200 0]; recoveryRedPos = [400 400 0];
biThuongBlueNum = 0;
conKhoeBlueNum = 0;
biThuongBlues = zeros(50, 15);
conKhoeBlues = zeros(50, 15);
daDuocDuaVeBlues = zeros(1, 30);
bluesDaDenMiddle = 0; redsDaDenMiddle = 0;
targetAmbuVeCanCu = [-750 -300 0];
blueStatus = zeros(4, BluesNum);    dangDiCuu = 1;  dangCuuBoid = 2; trangThai = 3; dangDuocBoidCuu = 4;
while (timeTick < TimeSteps)
    tempBlues = Blues;
    tempReds = Reds;
    switch stage
        case 1
            %% Blues
            % Moving the 1-st Boid (as a leader)
            %             [Blues] = UpdateCenterLeader(Blues, BluesNum);
            if (bluesDaDenMiddle == 0)
                force = steer_arrival(Blues(1,:), middleBlueTarget);
                Blues(1,:) = applyForce(Blues(1,:), force);
                BlueLeader = Blues(1, :);
                Alpha_Horizontal = CalculationHorizontalAngle(BlueLeader);
                [Blues, BluesIndex] = steer_Arrival_Formation_Arc(middleBlueTarget, Blues, BluesNum, BlueLeader, D_Behind, D_Beside,...
                    Alpha_Horizontal, NumberBoidsOnTop, NumberBoidsOnBranch);
                if(dist(Blues(1, 1:3), middleBlueTarget(1:3)) < 30)
                    bluesDaDenMiddle = 1;
                end
            end
            
            AttackRed=zeros(1,RedsNum);
            for i=1:BluesNum
                if(Blues(i,15)> (thresholdBiThuong * MaxBlueHP))
                    %                     Blues = updateAtBoundary(Blues,i);
                    [J,~]=findTarget(Blues(i,:),RedsNum,Reds);
                    
                    if (J>0 && dist(Blues(i,:),Reds(J,:))<ShootDistanceB)
                        % Shoot
                        c2=line([Reds(J,1), Blues(i,1)-2],[Reds(J,2), Blues(i,2)],'Color','blue','LineStyle','-.');
                        pause(0.02);
%                                                 sound(gun,gunFs);
                        delete(c2);
                        AttackRed(1,J)=AttackRed(1,J)+1;
                    end
                    if(blueStatus(trangThai, i) == 0)
                        if(bluesDaDenMiddle == 1 && dist(Blues(i,:), Reds(J,:)) > ShootDistanceB)
                            
                            arrival_force = steer_arrival(Blues(i,:), Reds(J, 1:3));
                            Blues(i,:) = applyForce(Blues(i,:), arrival_force);
                            
                        end
                    elseif(blueStatus(trangThai, i) == 1)
                        arrival_force = steer_arrival(Blues(i,:), ...
                            Blues(blueStatus(dangCuuBoid, i), 1:3));
                        Blues(i,:) = applyForce(Blues(i,:), 1.5 * arrival_force);
                        if(dist(Blues(i,1:3), Blues(blueStatus(dangCuuBoid, i), 1:3)) < 30)
                            blueStatus(trangThai, blueStatus(dangCuuBoid, i)) = 2;
                            blueStatus(trangThai, i) = 2;
                        end
                    elseif(blueStatus(trangThai, i) == 2)
                        arrival_force = steer_arrival(Blues(i,:), recoveryBluePos);
                        Blues(i,:) = applyForce(Blues(i,:), 1.5 * arrival_force);
                        if(dist(Blues(i,1:3), recoveryBluePos) < 80)
                            blueStatus(trangThai, i) = 0;
                            blueStatus(dangCuuBoid, i) = 0;
                        end
                    end
                    
                elseif(Blues(i,15) < (thresholdBiThuong * MaxBlueHP) && Blues(i,15) > 0)
                    if(blueStatus(trangThai, i) ~= 3)
                        arrival_force = 1.0 * steer_arrival(Blues(i,:), recoveryBluePos);
                        if(blueStatus(trangThai, i) == 0)
                            Blues(i,:) =applyForce(Blues(i,:),  0.3 * arrival_force);
                            [nearestRecoveryBluePos] = FindNearestRecoveryBoid(Blues(i, :),Blues, blueStatus, ...
                            trangThai, BluesNum, thresholdBiThuong * MaxBlueHP);
                            if (nearestRecoveryBluePos ~= 0)
                                blueStatus(trangThai, i) = 1;
                                blueStatus(trangThai, nearestRecoveryBluePos) = 1;
                                blueStatus(dangCuuBoid, nearestRecoveryBluePos) = i;
                                blueStatus(dangDuocBoidCuu, i) = nearestRecoveryBluePos;
                            end
                        elseif(blueStatus(trangThai, i) == 1)
                            Blues(i,:) = applyForce(Blues(i,:), 0.3 * arrival_force);
                        elseif(blueStatus(trangThai, i) == 2)
                            Blues(i,:) = applyForce(Blues(i,:), arrival_force);
                        end      
                        
                        if(dist(Blues(i, 1:3), recoveryBluePos) < 30)
                            blueStatus(trangThai, i) = 3;
                        end
                    end
                end
            end
            [RedsNum,Reds] = UpdateBoidHP(AttackRed,RedsNum,Reds);
            %% Reds
            %             Reds = UpdateCenterLeader(Reds, RedsNum);
            if(redsDaDenMiddle == 0)
                force = steer_arrival(Reds(1,:), middleRedTarget);
                Reds(1,:) = applyForce(Reds(1,:), force);
                RedLeader = Reds(1, :);
                Alpha_Horizontal = CalculationHorizontalAngle(RedLeader);
                [Reds, RedsIndex] = steer_Arrival_Formation_Arc(middleRedTarget, Reds, RedsNum, RedLeader, D_Behind, D_Beside,...
                    Alpha_Horizontal, NumberBoidsOnTop, NumberBoidsOnBranch);
                if(dist(Reds(1, 1:3), middleRedTarget(1:3)) < 30)
                    redsDaDenMiddle = 1;
                end
            end
            
            AttackBlue = zeros(1,BluesNum);
            for i=1:RedsNum
                if(Reds(i,15)> (thresholdBiThuong * MaxRedHP))
                    %                     Reds = updateAtBoundary(Reds,i);
                    [J,~]=findTarget(Reds(i,:),BluesNum,Blues);
                    if (J>0 && dist(Reds(i,:),Blues(J,:))<ShootDistanceB)
                        c1=line([Reds(i,1), Blues(J,1)],[Reds(i,2), Blues(J,2)],'Color','red','LineStyle','-.');
%                                                 sound(gun,gunFs);
                        pause(0.02);
                        delete(c1);
                        AttackBlue(1,J)=AttackBlue(1,J)+1;
                    end
                    
                    if(redsDaDenMiddle == 1 && dist(Reds(i,:),Blues(J,:)) > ShootDistanceB)
                        arrival_force = steer_arrival(Reds(i,:), Blues(J, 1:3));
                        Reds(i,:) = applyForce(Reds(i,:), arrival_force);
                    end
                elseif(Reds(i,15) < (thresholdBiThuong * MaxRedHP) && Reds(i,15) > 0)
                    arrival_force = 0.5 * steer_arrival(Reds(i,:), recoveryRedPos);
                    Reds(i,:) = applyForce(Reds(i,:), arrival_force);
                end
            end
            [BluesNum,Blues, blueStatus] = UpdateBoidBlueHP(AttackBlue,BluesNum,Blues, blueStatus, dangCuuBoid,...
                dangDuocBoidCuu, trangThai, thresholdBiThuong * MaxBlueHP);
            deadRedCount = 0;
            for i = 1:RedsNum
                if(Reds(i,15) <= 0)
                    deadRedCount = deadRedCount + 1;
                end
            end
            if (deadRedCount == RedsNum)
                for i = 1:BluesNum
                    if(Blues(i, 15) > 0 && Blues(i, 15) < (0.4 * MaxBlueHP))
                        biThuongBlueNum = biThuongBlueNum + 1;
                        biThuongBlues(biThuongBlueNum, :) = Blues(i, :);
                    elseif(Blues(i, 15) > (0.4 * MaxBlueHP))
                        conKhoeBlueNum = conKhoeBlueNum + 1;
                        conKhoeBlues(conKhoeBlueNum, :) = Blues(i, :);
                    end
                end
                
                stage = 2;
                if(biThuongBlueNum <= 0)
                   stage = 5; 
                end
            end
            deadBlueCount = 0;
            for i = 1:BluesNum
                if(Blues(i,15) <= 0)
                    deadBlueCount = deadBlueCount + 1;
                end
            end
            if (deadBlueCount == BluesNum)
                stage = 3;
            end
            %% Graphic
            RedrawRedsHP();
            RedrawBlueHP();
            RedrawBoidBlue(Blues, BluesNum, v_ImageB, v_AlphaB, v_ImageE, v_AlphaE, BluesPlot...
                ,imageB_bithuong, alphaB_bithuong, (thresholdBiThuong * MaxBlueHP));
            RedrawBoidBlue(Reds, RedsNum, v_ImageR, v_AlphaR, v_ImageE, v_AlphaE, RedsPlot...
                ,imageR_bithuong, alphaR_bithuong, (thresholdBiThuong * MaxRedHP));
%             RedrawBoid(Reds, RedsNum, v_ImageR, v_AlphaR, v_ImageE, v_AlphaE, RedsPlot);
            %             if(dist(Blues(1,1:3), [0 0 0]) < 20 )
            %                 stage = 2;
            %             end
            
        case 2
            % xe cuu thuong den don blue bi thuong
            if(dist([Ambu(1) Ambu(2) 0], recoveryBluePos) > 60)
                force_arrival_ambu = steer_arrival(Ambu, recoveryBluePos);
                Ambu = applyForce(Ambu, force_arrival_ambu);
                AmbuPlot.XData = Ambu(1);
                AmbuPlot.YData = Ambu(2);
            else
                stage = 4;
                img_i = AmbuPlot.CData;
                alpha_i = AmbuPlot.AlphaData;
                img_i = flipdim(img_i, 2);
                alpha_i = flipdim(alpha_i, 2);
                AmbuPlot.CData = img_i;
                AmbuPlot.AlphaData = alpha_i;
                for i = 1:BluesNum
                    if(Blues(i, 15) > 0 && Blues(i, 15) < thresholdBiThuong * MaxBlueHP)
                    delete(BluesPlot(i));
                    end
                end
            end
            drawnow;
            
        case 3
            % quan xanh bi die het
            InitializeFlag(v_ImageFR,v_AlphaFR);
            break;
        case 4 
            % xe cuu thuong quay dau di ve
            if(dist(Ambu(1:3), targetAmbuVeCanCu) > 80)
               force_arrival_ambu = steer_arrival(Ambu, targetAmbuVeCanCu);
                Ambu = applyForce(Ambu, force_arrival_ambu);
                AmbuPlot.XData = Ambu(1);
                AmbuPlot.YData = Ambu(2);
            else
                stage = 5;
            end
            drawnow;
        case 5
            InitializeFlag(v_ImageFB,v_AlphaFB);
            break;
    end
end
end
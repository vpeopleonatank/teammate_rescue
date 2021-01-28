function [fHandler]=InitializeGraphicN()
global EnvironmentWidth Target1 Target2;
fHandler = figure;
fHandler.Color = 'white';
fHandler.MenuBar =  'none';
fHandler.ToolBar = 'none';
fHandler.Name = 'Chien dau, dua nguoi bi thuong ve can cu';
fHandler.NumberTitle = 'off';
rectangle('position',[-EnvironmentWidth -EnvironmentWidth 2*EnvironmentWidth 2*EnvironmentWidth],'EdgeColor','b','LineWidth',1);
% rectangle('position',[-EnvironmentWidth -EnvironmentWidth 200 200]);
hold on
xlabel('X axis')
ylabel('Y axis')
axis manual;
axis([-EnvironmentWidth EnvironmentWidth -EnvironmentWidth EnvironmentWidth]);

plot(Target1(1),Target1(2),'o','MarkerSize',5,'MarkerFaceColor','b','Color','b');
plot(Target2(1),Target2(2),'o','MarkerSize',5,'MarkerFaceColor','r','Color','r');
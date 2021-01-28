function [bomb,gun,fight,bombFs,gunFs,fightFs]=loadSound()
[bomb,bombFs] = audioread('soundbomb.wav');
bomb=bomb(1:6*bombFs);

[gun,gunFs] = audioread('soundgun.mp3');
gun=gun(1:1*gunFs);

[fight,fightFs] = audioread('soundfight.wav');
fight=fight(1:20*fightFs);

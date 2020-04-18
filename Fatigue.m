clear
clc
close all

Al = readmatrix('FatigueData.xlsx','Sheet','Al');
Br = readmatrix('FatigueData.xlsx','Sheet','Brass');

%% Calculations

d = 0.375;
r = d/2;
fillet = 0.031;
eff_d = (d-2*fillet);
arm = 1.5;
c = (d-2*fillet)/2;
I = pi*eff_d^4/64
sig = Al(:,1).*(arm*c/I)
y = 0;
Q = 2/3*(r^2-y^2)^(3/2)
t = r
tau = Al(:,1).*(Q/I*t);

sig_rev = sqrt(sig.^2+3.*tau.^2);

%ka
%kb
%kc
%kd
%ke
%kf


scatter(sig_rev,Al(:,2))
clear
clc
close all

Al = readmatrix('FatigueData.xlsx','Sheet','Al');
Br = readmatrix('FatigueData.xlsx','Sheet','Brass');
Al = sortrows(Al);
Br = sortrows(Br);
Al = rmoutliers(Al);
Br = rmoutliers(Br);

%% Al Calculations
Sut = 35000;
d = 0.375;
r = d/2;
fillet = 0.031;
eff_d = (d-2*fillet);
arm = 1.5;
c = (d-2*fillet)/2;
I = pi*eff_d^4/64;
sig = Al(:,1).*(arm*c/I);
y = 0;
Q = 2/3*(r^2-y^2)^(3/2);
t = r;
tau = Al(:,1).*(Q/I*t);

sig_rev = sqrt(sig.^2+3.*tau.^2);

x = Al(:,2);
p = polyfit(log(x),log(sig_rev),1);
m = p(1) %Aluminum b value
b = exp(p(2)) %Aluminum a value


figure
hold on
scatter(x,sig_rev)
set(gca,'xscale','log','yscale','log')
xreg = min(x):10:max(x);
func = b*xreg.^m;
funccomp = b*x.^m;
R = corrcoef(sig_rev,funccomp);
Rsq = R(1,2).^2
plot(xreg,func)
xlabel('Number of Cycles (N)')
ylabel('Fatigue Strength (Sf) [psi]')
title('Experimental Aluminum Fatigue Strength')

%% Br Calculations

d = 0.375;
r = d/2;
fillet = 0.031;
eff_d = (d-2*fillet);
arm = 1.5;
c = (d-2*fillet)/2;
I = pi*eff_d^4/64;
sig = Br(:,1).*(arm*c/I);
y = 0;
Q = 2/3*(r^2-y^2)^(3/2);
t = r;
tau = Br(:,1).*(Q/I*t);

sig_rev = sqrt(sig.^2+3.*tau.^2);

x = Br(:,2);
p = polyfit(log(x),log(sig_rev),1);
m = p(1) %Brass b value
b = exp(p(2)) %Brass a value

figure
hold on
scatter(x,sig_rev)
set(gca,'xscale','log','yscale','log')
xreg = min(x):10:max(x);
func = b*xreg.^m;
funccomp = b*x.^m;
R = corrcoef(sig_rev,funccomp);
Rsq = R(1,2).^2
plot(xreg,func)
xlabel('Number of Cycles (N)')
ylabel('Fatigue Strength (Sf) [psi]')
title('Experimental Brass Fatigue Strength')

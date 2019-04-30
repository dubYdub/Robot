function probilblity()
%Algolrithm motion_model_odometry with Normal Distribution Noise

clc
close all

%Initial setting of mobile robot
x = 100;
y =100;
theta = pi/4;

a1 = 0.000005;
a2 = 0.000005;
a3 = 0.000005;
a4 = 0.000005;

trajectory_data = zeros(3,500,20);
odom = zeros(3,20);
odom(:,:) = NaN;
odom(:,1:3)= 0;

trajectory_data(:,:,:) = NaN;
trajectory_data(:,:,1) = 0;

n = 1;
t = 2;

while (t <= 20 )
    

if t < 5
    delta_rot1 = 0;

    delta_trans =50;

    delta_rot2 = 0;
 

elseif (t >= 5)&&(t < 8)
    delta_rot1 = 0;

    delta_trans = 50;

    delta_rot2 = pi/6;
    
 
    
    
elseif (t >= 8)&&(t < 12)
    delta_rot1 = 0;

    delta_trans = 50;

    delta_rot2 = 0;

 

    
elseif (t >= 12)&&(t < 15)
    delta_rot1 = 0;

    delta_trans = 50;

    delta_rot2 = pi/6;
    
    
elseif (t >= 15)&&(t <= 20)
    delta_rot1 = 0;

    delta_trans = 50;

    delta_rot2 = 0;
    
 
end


for n = 1: 500
    
delta_rot1_noise = delta_rot1 - normrnd(0,(a1*delta_rot1^2 + a2*delta_trans^2));

delta_trans_noise = delta_trans - normrnd(0,(a3*delta_trans^2 + a4*delta_rot1^2 + a4*delta_rot2^2));

delta_rot2_noise = delta_rot2 - normrnd(0,(a1*delta_rot2^2 + a2*delta_trans^2));


x = trajectory_data(1,n,t-1) + delta_trans_noise * cos(theta + delta_rot1_noise);

y = trajectory_data(2,n,t-1) + delta_trans_noise * sin(theta + delta_rot1_noise);

theta = trajectory_data(3,n,t-1) + delta_rot1_noise + delta_rot2_noise;


trajectory_data(1,n,t) = x;

trajectory_data(2,n,t) = y;

trajectory_data(3,n,t) = theta;


n = n + 1;

end



t = t + 1;


if t < 5
    
    delta_rot1 = 0;

    delta_trans =50;

    delta_rot2 = 0;
    
    odom(1,t) = odom(1,t-1) + delta_trans;
    
    odom(2,t) = odom(2,t-1);
    
    odom(3,t) = odom(3,t-1) + delta_rot1 + delta_rot2;

elseif (t >= 5)&&(t < 8)
    delta_rot1 = 0;

    delta_trans = 50;

    delta_rot2 = deg2rad(30);
    
    odom(1,t) = odom(1,t-1) + delta_trans * cos(theta + delta_rot1);

    odom(2,t) = odom(2,t-1) + delta_trans * sin(theta + delta_rot1);
    
    odom(3,t) = odom(3,t-1) + delta_rot1 + delta_rot2;
    
    
elseif (t >= 8)&&(t < 12)
    delta_rot1 = 0;

    delta_trans = 50;

    delta_rot2 = 0;

    odom(1,t) = odom(1,t-1);

    odom(2,t) = odom(2,t-1) + delta_trans;
    
    odom(3,t) = odom(3,t-1) + delta_rot1 + delta_rot2;

    
elseif (t >= 12)&&(t < 15)
    delta_rot1 = 0;

    delta_trans = 50;

    delta_rot2 = deg2rad(30);
        
    odom(1,t) = odom(1,t-1) + delta_trans * cos(theta + delta_rot1);

    odom(2,t) = odom(2,t-1) + delta_trans * sin(theta + delta_rot1);
    
    odom(3,t) = odom(3,t-1) + delta_rot1 + delta_rot2;
    
    
elseif (t >= 15)&&(t <= 21)
    delta_rot1 = 0;

    delta_trans = 50;

    delta_rot2 = 0;
    
    odom(1,t) = odom(1,t-1) + delta_trans * cos(-pi);

    odom(2,t) = odom(2,t-1);
    
    odom(3,t) = odom(3,t-1) + delta_rot1 + delta_rot2;
end
end

plot(odom(1,:),odom(2,:),'r','LineWidth',1.5);
pause(3);
hold on 

for m = 1:20
  scatter(trajectory_data(1,5:500,m),trajectory_data(2,5:500,m),'.');
  pause(1);
  hold on
end

end
%  pause(0.);
% 
% hold on
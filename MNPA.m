% ELEC4700
% Student Name: Shannon Jarvis  
% Student num.: 101007669
% 
%--------------------------------------------------------------------------
clc; close all;  clear all;  %initialization of the matlab environment
global G C b; %define global variables

%--------------------------------------------------------------------------
%Find the MNA
%--------------------------------------------------------------------------
OutputNode = 5;
%Construct the Martix using the netlist 
G = zeros(5,5); % Define G, 4 node circuit 
C = zeros(5,5); % Define C, 4 node circuit 
b = zeros(5,1); % Define b, 4 node circuit 

%--------------------------------------------------------------------------
% List of the components (netlist):
%--------------------------------------------------------------------------
Vin = linspace(-10, 10, 20);

vol(1,0,Vin(1));
res(1,2,1);
cap(1,2,0.25);
res(2,0,2);
ind(2,3,0.2);
res(3,0,10);
vcvs(4,0,3,0,100/10);
res(4,5,0.1);
res(5,0,1000);


for n=1:20
    b(6) = Vin(n);
    X = G\b;
    Vout(n) = X(OutputNode);  % Here, you are collecting the response ...
                              % at the output node for different input ... 
                              % in an array named (Vout)!
    V3(n) = X(3); 

end


%-------------------------------------------------------------------------- 
% To plot the magnitude of the output voltage:
%-------------------------------------------------------------------------- 
figure('Name','Input Response');  %Optional
plot(Vin, Vout,'LineWidth',3);
hold on;
plot(Vin, V3,'LineWidth',3);
grid;
legend('Output voltage', 'Node 3 voltage');
title('Input Response', 'FontSize',14);
xlabel('Input Voltage (V)','FontSize',20);
ylabel('Voltage  (Volts)','FontSize',20);


%-------------------------------------------------------------------------- 
% PArt C
%-------------------------------------------------------------------------- 

b(6) = 10;

fmin = 0;  %Hz
fmax = 9;  %MHz
Nrpt = 5000;  %Number of frequency points

F = logspace(fmin, fmax, Nrpt);

for n=1:Nrpt
    w = 2*pi* F(n);
    s = i*w;
    
    A = (G+s*C);
 
    X = A\b;
    Vout(n) = X(OutputNode);  % Here, you are collecting the response ...
                              % at the output node for different frequency ... 
                              % in an array named (Vout)!
    
end

gain = 20*log(abs(Vout/b(6)));

%-------------------------------------------------------------------------- 
% To plot the magnitude of the output voltage:
%-------------------------------------------------------------------------- 
figure('Name','Frequency Response');  %Optional
semilogx(F, abs(Vout),'LineWidth',3);
grid;
title('Frequency Response of |V_{out}|  ', 'FontSize',14);
xlabel('w  (rad/s)','FontSize',20);
ylabel('|V_{out}|  (Volts)','FontSize',20);


figure('Name','Frequency Response - Gain');  %Optional
semilogx(F, gain,'LineWidth',3);
grid;
title('Frequency Response of |V_{out}/V_{in}| ', 'FontSize',14);
xlabel('w  (rad/s)','FontSize',20);
ylabel('Gain (dB)','FontSize',20);


%-------------------------------------------------------------------------- 
% PArt D
%-------------------------------------------------------------------------- 

%Capicator C is between node 1 and 2 

b(6) = 10;
w = pi;
s = i*w;

for n=1:Nrpt

    pertub = 0.05*randn; 
    
    %Only adding pertibation to C (col, row 1 and 2 in C matrix)
    C(1,1) = C(1,1) + pertub;
    C(1,2) = C(1,2) - pertub;
    C(2,1) = C(2,1) + pertub;
    C(2,2) = C(2,2) - pertub; 
    
    A = (G+s*C);
 
    X = A\b;
    Vout(n) = X(OutputNode);  % Here, you are collecting the response ...
                              % at the output node for different frequency ... 
                              % in an array named (Vout)!
    pretubation(n) = pertub;
end

gain = 20*log(abs(Vout/b(6)));

figure('Name','Pertubation Response');  %Optional
plot(pretubation, gain,'*');
grid;
title('Gain as a function of random pertubation', 'FontSize',14);
xlabel('Pretubation','FontSize',20);
ylabel('Gain (dB)','FontSize',20);


figure('Name','Frequency Response - Gain Pertubation');  %Optional
histogram(gain);
grid;
title('Frequency Response of |V_{out}/V_{in}| ', 'FontSize',14);
xlabel('Gain (dB)','FontSize',20);
ylabel('Frequency','FontSize',20);



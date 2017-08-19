
% Purpose: test TIE solution
%% Debug version for developer


clear;
close all;
clc;

% load two intensity images

Iz=double(imread('Iz.bmp'));
I0=double(imread(('I0.bmp')));

% Iz=double(imread('80.bmp'));
% I0=double(imread(('0.bmp')));

% figure
% imshow([I0,Iz],[],'border','tight');

det=10e-3; % Distance between the two intensity images

dIdz=(Iz-I0)/det;
% figure
% imshow(dIdz,[]);

h=632e-6; % Wavelength
k=2*pi/h; % Wave number
Mag=10;   % Magnification 
pixelszie=4*2.2e-3;% Pixelszie 
r=eps;%100000000;%eps;% Regularization parameter(to reduce low spatial frequency noise.  

phi=FFT_Poisson_Solver_TIE(dIdz,I0,pixelszie/Mag,k,0.000002); % Solve TIE for phase


% Show phase
figure
imshow((phi),[]);
colorbar

FT_phi=fftshift(fft2(phi));
imshow(log(abs(FT_phi)+1),[]);



% Show 3D image
Ncell=1.37; % Refractive index of the cell
Nmedium=1.34; % Refractive index of the Medium
Height=phi*h/(Ncell-Nmedium)/2/pi/1e-3;

figure 
surf(Height);
axis on
colorbar
axis tight;
shading interp;
light('Color',[0.5 0.5 0.5],'Style','infinite','Position',[-4,-4,10]);
zlabel('Height (\mum)','FontSize',14);
view([-40 80])

figure;
plot(Height(68,:));

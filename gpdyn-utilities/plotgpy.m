function [i] = plotgpy(i, t, sys, y, std)
% Function plots results of simulation or one-step-ahead
% prediction: target and output together with 95 % confidence band.
%
%% Syntax
%  function [i] = plotgpy(i, t, sys, y, std)
%  function [i] = plotgpy(i, t, y, std)
%
% Input: 
% * i   ... the figure handle, if i==0 function plots in current figure 
% * t   ... the time vector (x-axis) 
% * sys ... the target output 
% * y   ... the predicted output 
% * std ... the predicted standard deviation 
% 
% Output: 
% i ... the figure handle 
%
% See Also:
% plotg, plotgpe
%
% Examples:
% demo_example_gp_simulation.m
%
%%
% * Written by Dejan Petelin

sz = size(t);

if(nargin == 5)
% check sizes of vectors 
	if((size(t,1)~=sz(1) | size(sys,1)~=sz(1) |size(y,1)~=sz(1) | size(std,1)~=sz(1))...
		| (size(t,2)~=sz(2) | size(sys,2)~=sz(2) |size(y,2)~=sz(2) | size(std,2)~=sz(2)))
	    warning(['figure ', num2str(i), ': vectors: t, tt, y, std must be same size']);
	    disp(strcat(['t: ', num2str(size(t))])); 
	    disp(strcat(['sys: ', num2str(size(sys))])); 
	    disp(strcat(['y: ', num2str(size(y))])); 
	    disp(strcat(['std: ', num2str(size(std))])); 
	    out = -1; 
	    return; 
	end
else
	std = y;
	y = sys;
	if((size(t,1)~=sz(1) |size(y,1)~=sz(1) | size(std,1)~=sz(1))...
		| (size(t,2)~=sz(2) | size(y,2)~=sz(2) | size(std,2)~=sz(2)))
	    warning(['figure ', num2str(i), ': vectors: t, tt, y, std must be same size']);
	    disp(strcat(['t: ', num2str(size(t))])); 
	    disp(strcat(['y: ', num2str(size(y))])); 
	    disp(strcat(['std: ', num2str(size(std))])); 
	    out = -1; 
	    return; 
	end
end

ix_plot = 1:length(t);   
% reduce vector if borders are wanted in figure, 
% e.g. ixplot = 2:length(t)-1;

xfill = [t(ix_plot); flipdim(t(ix_plot),1)]; 
yfill = [y(ix_plot)+2*std(ix_plot);flipdim(y(ix_plot)-2*std(ix_plot),1)]; 


% if i==0 use current axis (figure) 
if (i~=0)
figure(i);
end 

fill(xfill, yfill, [7 7 7]/8, 'EdgeColor', [0 0 0]/8);
hold on 
if(nargin == 5)
	plot(t,y, 'k-', 'LineWidth',1); 
	plot(t,sys, 'k--', 'LineWidth',2); 
else
	plot(t,y, 'k-', 'LineWidth',2); 
end

hold off
grid on 
xlabel('x'); 
ylabel('f(x)'); 
%title('GP model simulation')
legend('\mu \pm 2\sigma', '\mu', 'system','Location','NorthEast'); 
AX=axis; 
AX(1:2)=[t(1) t(end)];  
axis(AX); 





return 







clc;
clear all;

load('ARN4S_S');

if wave_type == 'P'
    k_arr = kpef;
    c_arr = cpef;
    first_plot_label = 'c_{P}/c^{S}_{P}, \alpha_{P}a, ka';
elseif wave_type == 'S'
    k_arr = ksef;
    c_arr = csef;
    first_plot_label = 'c_{S}/c^{S}_{P}, \alpha_{S}a, ka';
else
    k_arr = 0;
    c_arr = 0;
    first_plot_label = '';
end

colores=[[0,0,0];[0,0,1];[0,1,0];[0,1,1];[1,0,0];[1,0,1];[1,1,0]];

num_color = 0;
num_fig = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% First: Phase Velocity, Attenuation and Wave number

    title_str = "";
    leg1 = ['Normalized phase velocity'];
    leg2 = ['Attenuation'];
    leg3 = ['Wave number'];
    
    num_fig = num_fig + 1;
    figure(num_fig)
        hold on
        plot(real(c_arr)/cpM,frequency_array,'-','Color','blue','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)        
        plot(imag(k_arr),frequency_array,'-','Color','red','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        plot(real(k_arr),frequency_array,'-','Color','magenta','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        hold off
        legend(leg1,leg2,leg3,'Location','northeast')
        % Limits P wave
        % xlim([0,4])
        xlabel(first_plot_label)
        ylabel('\Omega')
        grid off 
        title(title_str)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Second: Rho

    title_str = "";
    leg1 = ['Re(\rho)'];
    leg2 = ['Im(\rho)'];
    
    num_fig = num_fig + 1;
    figure(num_fig)
        hold on
        plot(real(roef),frequency_array,'-','Color','blue','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)        
        plot(imag(roef)*10^1,frequency_array,'-','Color','red','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        hold off
        legend(leg1,leg2,'Location','northeast')
        %xlim([0,2.7])
        xlabel('Re(\rho), Im (10^{-1} \rho), (10^{3}kg/m\^3)')
        ylabel('\Omega')
        grid off
        title('')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Third: Kappa and Mu

    title_str = "";
    leg1 = ['10^{-1} Re(\kappa)'];
    leg2 = ['10^{-2} Im(\kappa)'];
    leg3 = ['10^{-1} Re(\mu)'];
    leg4 = ['10^{-2} Im(\mu)'];

    num_fig = num_fig + 1;
    figure(num_fig)

        hold on
        plot(real(kaef)*(10^(1)),frequency_array,'-','Color','blue','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)        
        plot(imag(kaef)*(10^(2)),frequency_array,'-','Color','red','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        plot(real(muef)*(10^1),frequency_array,'-','Color','black','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)        
        plot(imag(muef)*(10^2),frequency_array,'-','Color','magenta','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        hold off
        legend(leg1,leg2,leg3,leg4,'Location','northeast')
        % General
        %xlim([-5.3,0])
        % Specific 
        %xlim([-.2,.05])
        ylim([0,10])
        xlabel('\kappa, \mu, (GPa)')
        ylabel('\Omega')
        grid off
        title('')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fourth: Nu

    title_str = "";
    leg1 = ['Re(\nu)'];
    leg2 = ['Im(\nu)'];
    
    num_fig = num_fig + 1;
    figure(num_fig)
        hold on
        plot(real(nu)*10^1,frequency_array,'-','Color','blue','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)        
        plot(imag(nu)*10^1,frequency_array,'-','Color','red','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        hold off
        legend(leg1,leg2,'Location','northeast')
        % Limits P wave
        % xlim([-1.5,4])
        xlabel('10^{-1}\nu')
        ylabel('\Omega')
        grid off
        title('')

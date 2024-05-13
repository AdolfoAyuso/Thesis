clc;
clear all;

load('ARN4S_S');

if wave_type == 'P'
    k_arr = kpef;
    c_arr = cpef;
elseif wave_type == 'S'
    k_arr = ksef;
    c_arr = csef;
else
    k_arr = 0;
    c_arr = 0;
end

colores=[[0,0,0];[0,0,1];[0,1,0];[0,1,1];[1,0,0];[1,0,1];[1,1,0]];

num_color = 0;
num_fig = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Real(k)

    title_str = "Re(k)";

    num_fig = num_fig + 1;
    figure(num_fig)
        plot(real(k_arr),frequency_array,'-','Color','black','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)      
        xlabel('');
        ylabel('Frequency')
        grid on
        title(title_str)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Phase Velocity and Attenuation

    attenuation = imag(k_arr);

    y_re = real(c_arr)/cpM;
    y_im = imag(k_arr);

    max_re = max(abs(y_re));
    exp_1 = 0;
    while max_re * (10^exp_1) < 1
        exp_1 = exp_1 + 1;
    end
    while max_re * (10^exp_1) >= 10
        exp_1 = exp_1 - 1;
    end
    disp(max_re);
    disp(exp_1);

    max_im = max(abs(y_im));
    exp_2 = 0;
    while max_im * (10^exp_2) < 1
        exp_2 = exp_2 + 1;
    end
    while max_im * (10^exp_2) >= 10
        exp_2 = exp_2 - 1;
    end
    disp(max_im);
    disp(exp_2);

    new_y_re = (y_re)*10^(exp_1);
    new_y_im = (y_im)*10^(exp_2);

    exp_1 = -1*exp_1;
    exp_2 = -1*exp_2;

    title_str = "Phase Velocity and Attenuation";
    leg1 = ['Phase Velocity x 10\^(',num2str(exp_1+3),')'];
    leg2 = ['Attenuation x 10\^(',num2str(exp_2+3),')'];
    
    num_fig = num_fig + 1;
    figure(num_fig)
        hold on
        plot(new_y_re,frequency_array,'-','Color','black','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)        
        plot(new_y_im,frequency_array,'-','Color','red','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        hold off
        legend(leg1,leg2,'Location','northwest')
        xlabel('')
        ylabel('Frequency')
        grid on 
        title(title_str)

     if false 

    % First version
        num = w; 
        den = real(kpef);
        
        phase_velocity = num./den;
        phase_velocity_aux = num./den;
    
        for i = 1:length(phase_velocity)
            if abs(phase_velocity(i)) > 100
                phase_velocity(i) = Inf;
                phase_velocity_aux(i) = 0;
            end
        end
    
    
        y_re = phase_velocity_aux;
        y_im = attenuation;
    
        max_re = max(abs(y_re));
        disp(max_re);
        exp_1 = 0;
        while max_re * (10^exp_1) < 1
            exp_1 = exp_1 + 1;
        end
        while max_re * (10^exp_1) >= 10
            exp_1 = exp_1 - 1;
        end
        disp(exp_1);
    
        max_im = max(abs(y_im));
        disp(max_im);
        exp_2 = 0;
        while max_im * (10^exp_2) < 1
            exp_2 = exp_2 + 1;
        end
        while max_im * (10^exp_2) >= 10
            exp_2 = exp_2 - 1;
        end
        disp(exp_2);
    
        new_y_re = (phase_velocity)*10^(exp_1);
        new_y_im = (y_im)*10^(exp_2);
    
        exp_1 = -1*exp_1;
        exp_2 = -1*exp_2;
    
        title_str = "Phase Velocity and Attenuation";
        leg1 = ['Phase Velocity x 10\^(',num2str(exp_1+3),') m/s'];
        leg2 = ['Attenuation x 10\^(',num2str(exp_2+3),')'];
        
        num_fig = num_fig + 1;
        figure(num_fig)
            hold on
            plot(new_y_re,frequency_array,'-','Color','black','LineWidth',2,...
                           'MarkerEdgeColor','k',...
                           'MarkerFaceColor','w',...
                           'MarkerSize',4)        
            plot(new_y_im,frequency_array,'-','Color','red','LineWidth',2,...
                           'MarkerEdgeColor','k',...
                           'MarkerFaceColor','w',...
                           'MarkerSize',4)
            hold off
            legend(leg1,leg2)
            xlabel('')
            ylabel('Frequency')
            grid on
            title(title_str)

     end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rho

    y_re = real(roef);
    y_im = imag(roef);

    max_re = max(abs(y_re));
    exp_1 = 0;
    while max_re * (10^exp_1) < 1
        exp_1 = exp_1 + 1;
    end
    while max_re * (10^exp_1) >= 10
        exp_1 = exp_1 - 1;
    end
    disp(max_re);
    disp(exp_1);

    max_im = max(abs(y_im));
    exp_2 = 0;
    while max_im * (10^exp_2) < 1
        exp_2 = exp_2 + 1;
    end
    while max_im * (10^exp_2) >= 10
        exp_2 = exp_2 - 1;
    end
    disp(max_im);
    disp(exp_2);

    new_y_re = (y_re)*10^(exp_1);
    new_y_im = (y_im)*10^(exp_2);

    exp_1 = -1*exp_1;
    exp_2 = -1*exp_2;

    title_str = "\rho";
    leg1 = ['Re(\rho) x 10\^(',num2str(exp_1+3),') kg/m\^3'];
    leg2 = ['Im(\rho) x 10\^(',num2str(exp_2+3),') kg/m\^3'];
    
    num_fig = num_fig + 1;
    figure(num_fig)
        hold on
        plot(new_y_re,frequency_array,'-','Color','black','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)        
        plot(new_y_im,frequency_array,'-','Color','red','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        hold off
        legend(leg1,leg2,'Location','northwest')
        xlabel('')
        ylabel('Frequency')
        grid on 
        title('\rho')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Kappa

    y_re = real(kaef);
    y_im = imag(kaef);

    max_re = max(abs(y_re));
    exp_1 = 0;
    while max_re * (10^exp_1) < 1
        exp_1 = exp_1 + 1;
    end
    while max_re * (10^exp_1) >= 10
        exp_1 = exp_1 - 1;
    end
    disp(max_re);
    disp(exp_1);

    max_im = max(abs(y_im));
    exp_2 = 0;
    while max_im * (10^exp_2) < 1
        exp_2 = exp_2 + 1;
    end
    while max_im * (10^exp_2) >= 10
        exp_2 = exp_2 - 1;
    end
    disp(max_im);
    disp(exp_2);

    new_y_re = (y_re)*10^(exp_1);
    new_y_im = (y_im)*10^(exp_2);

    exp_1 = -1*exp_1;
    exp_2 = -1*exp_2;

    re_kappa = new_y_re;
    im_kappa = new_y_im;

    leg_re_kappa = ['Re(\kappa) x 10\^(',num2str(exp_1+9),') Pa'];
    leg_im_kappa = ['Im(\kappa) x 10\^(',num2str(exp_2+9),') Pa'];

    num_fig = num_fig + 1;
    figure(num_fig)
        hold on
        plot(re_kappa,frequency_array,'-','Color','black','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)        
        plot(im_kappa,frequency_array,'-','Color','red','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        hold off
        legend(leg_re_kappa,leg_im_kappa,'Location','northwest')
        xlabel('')
        ylabel('Frequency')
        grid on 
        title('\kappa')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Mu

    y_re = real(muef);
    y_im = imag(muef);

    max_re = max(abs(y_re));
    exp_1 = 0;
    while max_re * (10^exp_1) < 1
        exp_1 = exp_1 + 1;
    end
    while max_re * (10^exp_1) >= 10
        exp_1 = exp_1 - 1;
    end
    disp(max_re);
    disp(exp_1);

    max_im = max(abs(y_im));
    exp_2 = 0;
    while max_im * (10^exp_2) < 1
        exp_2 = exp_2 + 1;
    end
    while max_im * (10^exp_2) >= 10
        exp_2 = exp_2 - 1;
    end
    disp(max_im);
    disp(exp_2);

    new_y_re = (y_re)*10^(exp_1);
    new_y_im = (y_im)*10^(exp_2);

    exp_1 = -1*exp_1;
    exp_2 = -1*exp_2;

    re_mu = new_y_re;
    im_mu = new_y_im;

    leg_re_mu = ['Re(\mu) x 10\^(',num2str(exp_1+9),') Pa'];
    leg_im_mu = ['Im(\mu) x 10\^(',num2str(exp_2+9),') Pa'];

    num_fig = num_fig + 1;
    figure(num_fig)
        hold on
        plot(re_mu,frequency_array,'-','Color','black','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)        
        plot(im_mu,frequency_array,'-','Color','red','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        hold off
        legend(leg_re_mu,leg_im_mu,'Location','northwest')
        xlabel('')
        ylabel('Frequency')
        grid on 
        title('\mu')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% E

    y_re = real(E);
    y_im = imag(E);

    max_re = max(abs(y_re));
    exp_1 = 0;
    while max_re * (10^exp_1) < 1
        exp_1 = exp_1 + 1;
    end
    while max_re * (10^exp_1) >= 10
        exp_1 = exp_1 - 1;
    end
    disp(max_re);
    disp(exp_1);

    max_im = max(abs(y_im));
    exp_2 = 0;
    while max_im * (10^exp_2) < 1
        exp_2 = exp_2 + 1;
    end
    while max_im * (10^exp_2) >= 10
        exp_2 = exp_2 - 1;
    end
    disp(max_im);
    disp(exp_2);

    new_y_re = (y_re)*10^(exp_1);
    new_y_im = (y_im)*10^(exp_2);

    exp_1 = -1*exp_1;
    exp_2 = -1*exp_2;

    re_E = new_y_re;
    im_E = new_y_im;

    leg_re_E = ['Re(E) x 10\^(',num2str(exp_1+9),') Pa'];
    leg_im_E = ['Im(E) x 10\^(',num2str(exp_2+9),') Pa'];

    num_fig = num_fig + 1;
    figure(num_fig)
        hold on
        plot(re_E,frequency_array,'-','Color','black','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)        
        plot(im_E,frequency_array,'-','Color','red','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        hold off
        legend(leg_re_E,leg_im_E,'Location','northwest')
        xlabel('')
        ylabel('Frequency')
        grid on 
        title('E')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nu

    y_re = real(nu);
    y_im = imag(nu);

    max_re = max(abs(y_re));
    exp_1 = 0;
    while max_re * (10^exp_1) < 1
        exp_1 = exp_1 + 1;
    end
    while max_re * (10^exp_1) >= 10
        exp_1 = exp_1 - 1;
    end
    disp(max_re);
    disp(exp_1);

    max_im = max(abs(y_im));
    exp_2 = 0;
    while max_im * (10^exp_2) < 1
        exp_2 = exp_2 + 1;
    end
    while max_im * (10^exp_2) >= 10
        exp_2 = exp_2 - 1;
    end
    disp(max_im);
    disp(exp_2);

    new_y_re = (y_re)*10^(exp_1);
    new_y_im = (y_im)*10^(exp_2);

    exp_1 = -1*exp_1;
    exp_2 = -1*exp_2;

    title_str = "\nu";
    leg1 = ['Re(\nu) x 10\^(',num2str(exp_1),')'];
    leg2 = ['Im(\nu) x 10\^(',num2str(exp_2),')'];
    
    num_fig = num_fig + 1;
    figure(num_fig)
        hold on
        plot(new_y_re,frequency_array,'-','Color','black','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)        
        plot(new_y_im,frequency_array,'-','Color','red','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','w',...
                       'MarkerSize',4)
        hold off
        legend(leg1,leg2,'Location','northwest')
        xlabel('')
        ylabel('Frequency')
        grid on
        title(title_str)

function r = MI_BODY(prog,wave_type,procedure,MAT,a,c,frequency_array,file_name)
    
    num_inclusions=length(c);
    disp(num_inclusions);

    % The first subset of inclusion/matrix properties is retrieved; 
    % this is cp and cs if procedure = 1, 
    % or kappa, mu, and rho if procedure = 2.
    [k,m,r,cp,cs,kM,mM,rM,cpM,csM] = MI_READ_PROPERTIES(procedure, MAT, num_inclusions);
    
    % The remaining properties are computed using the available ones 
    if procedure==2
        for inc=1:num_inclusions
            [cp(inc), cs(inc)] = MI_PROPIEDADES_INV(prog,k(inc),m(inc),r(inc));
        end
        [cpM,csM] = MI_PROPIEDADES_INV(prog,kM,mM,rM);
    elseif procedure == 1
        for inc=1:num_inclusions
            [k(inc), m(inc)] = MI_PROPIEDADES(prog,cp(inc),cs(inc),r(inc));
        end
        [kM, mM] = MI_PROPIEDADES(prog,cpM,csM,rM);
    end
    
    disp([k,m,r,cp,cs,kM,mM,rM,cpM,csM]);

    % The Adimensional Frequency is computed.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %if wave_type == 'P'
    %    w=frequency_array*cpM/max(a);

    %elseif wave_type == 'S'
    %    w=frequency_array*csM/max(a);
    %end

    
    %disp(w);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    w=frequency_array*cpM/max(a);

    % Variables for the velocity of the p-s waves.
    cpef=[];
    csef=[];

    % Variables for effective kappa, mu and rho, instantiated with the
    % matrix properties.
    ktemp=kM;
    mtemp=mM;
    rtemp=rM;

    for p=1:length(w)
        
        % Arrays for effective kappa, mu and rho.
        [roef(p), kaef(p), muef(p)] = MI_EFFECTIVE_PROPERTIES(prog,wave_type,k,m,r,c,a,w(p),ktemp,mtemp,rtemp,kM,mM,rM);
        ktemp=kaef(p);
        mtemp=muef(p);
        rtemp=roef(p);
        
        if prog == 'C'
           cpef=[cpef,sqrt((kaef(p)+muef(p))/roef(p))];
           
        elseif prog == 'S'
           cpef=[cpef,sqrt((3*kaef(p)+4*muef(p))/(3*roef(p)))];
        
        end
        
        csef=[csef,sqrt(muef(p)/roef(p))];
        disp(p);
        %disp([ktemp,mtemp,rtemp,cpef,csef]);

    end

    E = 9*kaef.*muef./(3*kaef+muef);
    nu = (3*kaef-2*muef)./(2*(3*kaef+muef));

    kpef = w./cpef;
    ksef = w./csef;

    save(file_name)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if false

        %Tests only
        
            if wave_type == 'P'
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Esto es correcto
                % y1 = (1/cpM)*(1./real(1./cpef));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                y1 = 1./real(1./cpef);
                y2 = imag(kpef);
                y3 = real(kpef);
        
            elseif wave_type == 'S'
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Esto es correcto
                % y1 = (1/cpM)*(1./real(1./csef));
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                y1 = 1./real(1./csef);
                y2 = imag(ksef);
                y3 = real(ksef);
        
            end
        
            subplot(1,2,1)
                plot(frequency_array,y1);
                xlabel('Frequency')
                title('Phase Velocity (km/s)')
                grid;
        
            subplot(1,2,2)
                plot(frequency_array,y2);
                xlabel('Frequency')
                title('Attenuation')
                grid;
        
            if false
        
                figure(1)
                    plot(frequency_array,y1);
                    xlabel('Frequency')
                    title('Phase Velocity')
                    grid;
                
                figure(2)
                    plot(frequency_array,y2);
                    xlabel('Frequency')
                    title('Attenuation')
                    grid;
                
                figure(3)
                    plot(frequency_array,y3);
                    xlabel('Frequency')
                    title('Wave Number')
                    grid;
            
                figure(4)
                    plot(frequency_array,real(roef));
                    xlabel('Frequency')
                    title('Real \rho')
                    grid;
            
                figure(5)
                    plot(frequency_array,imag(roef));
                    xlabel('Frequency')
                    title('Imag \rho')
                    grid;
            
                figure(6)
                    plot(frequency_array,real(kaef));
                    xlabel('Frequency')
                    title('Real \kappa')
                    grid;
            
                figure(7)
                    plot(frequency_array,imag(kaef));
                    xlabel('Frequency')
                    title('Imag \kappa')
                    grid;
            
                figure(8)
                    plot(frequency_array,real(muef));
                    xlabel('Frequency')
                    title('Real \mu')
                    grid;
            
                figure(9)
                    plot(frequency_array,imag(muef));
                    xlabel('Frequency')
                    title('Imag \mu')
                    grid;
            
                figure(10)
                    plot(frequency_array,real(E));
                    xlabel('Frequency')
                    title('Real E')
                    grid;
            
                figure(11)
                    plot(frequency_array,imag(E));
                    xlabel('Frequency')
                    title('Imag E')
                    grid;
            
                figure(12)
                    plot(frequency_array,real(nu));
                    xlabel('Frequency')
                    title('Real \nu')
                    grid;
            
                figure(13)
                    plot(frequency_array,imag(nu));
                    xlabel('Frequency')
                    title('Imag \nu')
                    grid;
        
            end
    end
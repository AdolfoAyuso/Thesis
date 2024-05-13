function [k,m,r,cp,cs,kM,mM,rM,cpM,csM] = MI_READ_PROPERTIES(procedure, MAT, num_inclusions)

    k=0;
    m=0;
    r=0;
    cp=0;
    cs=0;
    kM=0;
    mM=0;
    rM=0;
    cpM=0;
    csM=0;

    MI_MATERIALS_LIST;

    % Inclusions
    for inc=1:num_inclusions
        i = MAT(inc);
        if procedure==2
            k(inc) = materiales2(i,1);
            m(inc) = materiales2(i,2);
            r(inc) = materiales2(i,3);
        elseif procedure==1
            cp(inc) = materiales(i,1);
            cs(inc) = materiales(i,2);
            r(inc) = materiales(i,3);
        end
    end    
    
    % Matrix
    j = MAT(num_inclusions+1);
    if procedure==2
        kM = materiales2(j,1);
        mM = materiales2(j,2);
        rM = materiales2(j,3);
    elseif procedure==1
        cpM = materiales(j,1);
        csM = materiales(j,2);
        rM = materiales(j,3);
    end




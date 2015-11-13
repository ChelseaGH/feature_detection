function [ Gx, Gy ] = GetKernel( kType )
%GetKernel Generate a common kernel type
%%% Julian Anthony Brackins   %%%
%%% CSC 514 - Computer Vision %%%
%%% Project 1                 %%%

    %Ensure first arg is always caps
    kType = upper(kType);
    
    if strcmp( kType, 'ROBERTS')
        %ROBERTS:
        Gx = [  0  1  ;
               -1  0 ];
        Gy = [  1  0  ;
                0 -1 ];
        
    else
        %HANDLE THE OTHERS
        if strcmp( kType, 'PREWITT')
            %PREWITT:
            p = 3;
        
        elseif strcmp( kType, 'SOBEL')
            %SOBEL:
            p = 4;
        
        elseif strcmp( kType, 'ISOTROPIC')
            %ISOTROPIC:
            p = 2 + sqrt(2);
        end
        %Gradient Kernel Family used for Prewitt, Sobel, Iso:
        GradKernX = [   -1    0    1   ;
                        2-p   0   p-2  ;
                        -1    0    1  ];

        GradKernY = [   -1   2-p  -1   ;
                         0    0    0   ;
                         1   p-2   1  ];            
        

        %Apply finite difference kernels
        Gx = (1/p) * GradKernX;
        Gy = (1/p) * GradKernY;
        
    end
end
% Created by Adolfo Ayuso Hernández
% Last Updated 2024-05-12

clear all;
clc;

% Select the kind of program to be run. Spheres = 'S', Cylinders = 'C'.
prog = 'C';

% Select the kind of waves, either 'P' or 'S'.
wave_type = 'P';

% Select the kind of program you want to execute.
% 1 uses Cp and Cs values, whereas 2 uses k and mu. Both handles rho.
procedure = 2;

% Select the adequate data from the two tables in the MI_MATERIALS_LIST file.
% If you selected 1, refer to the first. Else, to the second
% Enter the values for MAT as an array. The last one refers to the matrix.
MAT = [4,9,8,1];

% Select the corresponding concentrations of each material.
% Array c should have one entrance less than MAT, because the concentration
% of the matrix is given as 1-sum(c).
c = [0.3,0.2,0.1];

% Depending on the type of inclusion we are considering, the radii are computed
% and normalized
if prog == 'S'
    a = (3/(4*pi()))*c;
    a = a.^(1/3);
elseif prog == 'C'
    a = c/pi();
    a = a.^(1/2);
end

normalize_a = max(a);
a = a/normalize_a;

% Choose if you want to define the frequency by introducing a beginning /ending
% point, as well as a step size (in which case, write 1) or if you want
% to provide the specific array (in which case, write 2).

frequency_type = 1;

if frequency_type == 1
% If you chose the former option, enter the adequate data:
    start = 0;
    ending = 10;
    step = 0.01;
    frequency_array = start:step:ending;

elseif frequency_type == 2
% If you chose the latter option, enter directly the array:
    frequency_array = [1,2,3,4,5,6,7,8,9,10];
    % One way to augment the precision in certain intervals is to 
    % manage an array with multiple step sizes, as in the next example:
    % frequency_array=[0:step:5,5.1:.0001:8, 8.1:step:10]

end

% Finally, write the name you want the output data to have:
file_name = "ARN4S_P";

% Run the program
MI_BODY(prog,wave_type,procedure,MAT,a,c,frequency_array,file_name);

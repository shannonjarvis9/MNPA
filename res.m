function res(n1,n2,val)
%res.m 
% Adds stamp for resistor to the global G-Matric in circuit representaton 
%
% res(n1, n2, val_
%                     R=val (ohm)
%               n1 o---/\/\/\/---o n2  
% Author:
% Date:
%--------------------------------------------------------------------------
% define global variables
global G;

if (n1 ~= 0)
    G(n1,n1) = G(n1,n1) + 1/val;
end

if (n2 ~= 0)
    G(n2,n2) = G(n2,n2) + 1/val;
end

if (n1 ~= 0) && (n2 ~= 0)
    G(n1,n2) = G(n1,n2) - 1/val;
    G(n2,n1) = G(n2,n1) - 1/val;
end
%END





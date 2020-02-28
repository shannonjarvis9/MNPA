function vccs(nd1,nd2,ni1,ni2,val)
% vccs.m
% Adds stamp for a voltage-controlled current-source to the global circuit representation
% 
%
%   ni1 -------o+          |----------o nd1
%                          |
%                          *
%                      |   *    Vnd1 - Vnd2 = val*(Vni1 - Vni2)
%                Ivccs |   *
%                      V   * 
%                          |
%   ni2 -------o-          |----------o nd2
%
% The nodes across the dependent source are nd1 and nd2 (positive voltage at nd1)
% The independent nodes are ni1 and ni2 (positive voltage at ni1).
%   Vnd1 - Vnd2 = val*(Vni1 - Vni2)
%
%          
% ELEC4506, Lab-2
% Author:
% Date:
%--------------------------------------------------------------------------
% define global variables
global G;

if (nd1 ~= 0) && (ni1 ~= 0)
    G(nd1,ni1) = G(nd1,ni1) + val;
end

if (nd1 ~= 0) && (ni2 ~= 0)
    G(nd1,ni2) = G(nd1,ni2) - val;
end

if (nd2 ~= 0) && (ni1 ~= 0)
    G(nd2,ni1) = G(nd2,ni1) - val;
end

if (nd2 ~= 0) && (ni2 ~= 0)
    G(nd2,ni2) = G(nd2,ni2) + val;
end

%END
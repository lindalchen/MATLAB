function M = mach( Gamma, Pabs, Patm  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

M = sqrt((2/(Gamma-1))*(((Pabs/Patm)^((Gamma-1)/Gamma)) -1));
end


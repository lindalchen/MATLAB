function mu = mu_subsonic(A, Gamma, rho, Pabs, Patm )
%MU Subsonic Calculates the mass flow rate of pressure in the bottle in
%subsonic
%   Detailed explanation goes here
mu = A * sqrt(2*rho *Pabs * (Gamma/(Gamma-1)) *((Patm/Pabs)^(2/Gamma)-(Patm/Pabs)^((Gamma+1)/Gamma)));

end


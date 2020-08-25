function mu = mu_choked( A, Gamma, rho, Pabs )
%MU Choked Calculates the mass flow rate of pressure in the bottle in
%choked flow
%   Detailed explanation goes here
 mu = A * sqrt( Gamma*rho * Pabs * (2/(Gamma+1))^((Gamma+1)/(Gamma-1)));

end


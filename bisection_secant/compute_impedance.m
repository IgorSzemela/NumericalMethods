function [value] = compute_impedance( omega )

 Z = 1 / (sqrt(1 / 725^2 + (omega * 0.00008 - 1/(omega * 2))^ 2 ));
 value = Z-75;
end

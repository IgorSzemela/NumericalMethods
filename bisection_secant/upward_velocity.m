function [value] = upward_velocity( t )

 V = 2000 * log(150000 / (150000 - 2700*t)) - 9.81*t;
 value = V - 750;
end
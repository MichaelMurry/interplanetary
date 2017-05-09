function [ vinf_mag ] = VinfMagCalc( vinf )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description:
% Inputs:
%      vinf = a cell of vinf values
% Outputs:
%  vinf_mag = array of vinf magnitudes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute vinf magnitudes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[row, col] = size(vinf);
for i = 1:col
    for j = 1:row
        vinf_mag(j, i) = norm(vinf{j,i}(:,1));
    end
end

end


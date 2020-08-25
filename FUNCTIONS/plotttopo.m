function [mapims] = plotttopo(data, xx, yy, name)
% I don't like Frederik's code so here lol
% INPUT:
%
% data     topography data
% xx       meshgrid values
% yy       meshgrid yy values
% name     name of the location
%
% OUTPUT:
% mapims   the map
mapims = imagesc(xx, yy, data); axis image xy
ax = gca;
ax.TickDir='out';
ax.TickLength=ax.TickLength*2;
hold on
colorbar
title(sprintf('%s', name));
end


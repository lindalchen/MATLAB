function [carr] = cmaparr(data,ncmap)
%CMAPARR Generates color matrix for the c part of colorbar to any colormap
%theme.
%INPUT:
%
%data     Any matrix data, will resort into an array regardless.
%ncmap    Name of the colormap.
%
%OUTPUT:
%carr     Color array to specified colormap.
%Modified January 10, 2020.

datap = reshape(data, 1, []);

cmap = colormap(ncmap);
warm = sort(datap);
indx = round(rescale(warm, 1,256));
carr = cmap(indx,:);
end


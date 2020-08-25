function vgc=vegicol
% vgc=VEGICOL
%
% Create a custom colormap suitable for NDVI etc
%
% Last modified by maloof@princeton.edu, 10/3/2019
% Last modified by fjsimons-at-alum.mit.edu, 10/3/2019

r1 = [0 1];
g1 = [0 1];
b1 = [0 1];
rgb1 = [r1; g1; b1]';

rgbt = interp1([1 2],rgb1, linspace(1,2,32));

r1 = [1   0  ];
g1 = [1   0.5];
b1 = [0.4 0.4];
rgb2 = [r1; g1; b1]';

rgbb= interp1([1 2],rgb2, linspace(1,2,32));

vgc=[rgbt ; rgbb];


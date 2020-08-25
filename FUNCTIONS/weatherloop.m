function [dt,dats,locs,coor]=weatherloop(diro, trange)
%Loads data of all the meteoblue weather in a folder, uses indicies (order at which
%the farms are listed in locs). You can apply this to other forms of data 
%loading for all the farms.
% Modified: 2019 01 19
% INPUT:
%
% diro     default directory of all the meteoblue data
% trange   range of days for the data
%
% OUTPUT:
%
% dt       datetime array
% dats     all the data organized by data-by-wvar-by-locs
% locs     location names
% coor     coordinates

defval('diro','/Users/linda/Documents/MATLAB/FRS161/DATA/MBDATA/'); 

% from 01-01-1985 00:00:00 to 31-12-2018 23:00:00 for FRS161 Dataset
defval('trange', 1:298032);

% EXAMPLE 1 Original data
% locs={'agrestis' 'bagliodipianetto' 'carainene' 'ceraudo' ...
%    'darioratta' 'enotre1' 'feudodisisa' 'frantoicutera'...
%   'frantoioacri' 'frantoiodecarlo' 'frantoiodicornoledo' ...
%    'frantoiohermes' 'laselvotta' 'oleariasangiorgio'...
%    'oliocru' 'oliointini' 'sorellegarzo' 'tenutelibrandipasquale'...
%    'titone' 'trecolonne'};

% EXAMPLE 2 New data
 locs={'agrestis' 'bagliodipianetto' 'brindisi' 'campobasso' 'carainene' 'ceraudo' ...
   'cervia' 'darioratta' 'enotre1' 'feudodisisa' 'frantoicutera'...
   'frantoioacri' 'frantoiodecarlo' 'frantoiodicornoledo' ...
   'frantoiohermes' 'grosseto' 'laselvotta' 'marinadiginosa' 'messina' ...
   'oleariasangiorgio' 'oliocru' 'oliointini' 'pisa' 'romaciampino' ...
   'sorellegarzo' 'tenutelibrandipasquale'...
   'titone' 'terminillomtn' 'trapanibirgi' 'trecolonne'};

index=1;
vname=locs{index};
fname=sprintf('mb_%s.mat',vname);
load(fullfile(diro,fname));

% Assigns dt variable to set timerange
pdt = eval(sprintf('%s.dt',vname));
dt= pdt(trange);
data=nan(length(dt),25,length(locs));

% Extracting all the data files
for index=1:length(locs)
    vname=locs{index};
    fname=sprintf('mb_%s.mat',vname);
    load(fullfile(diro,fname));
    if(strcmp(vname,'enotre1'))
        pdats=eval(sprintf('%s.data', 'enotre'));
        dats(:,:,index) = pdats(trange,:);
        lat = eval(sprintf('%s.lat', 'enotre'));
        lon = eval(sprintf('%s.lon', 'enotre'));
        coor(index,:) = [lat lon];
    elseif(strcmp(vname,'brindisi') || strcmp(vname,'campobasso') || ...
            strcmp(vname,'cervia')||strcmp(vname,'grosseto')|| ...
            strcmp(vname,'marinadiginosa')||strcmp(vname,'messina')|| ...
            strcmp(vname,'pisa')||strcmp(vname,'romaciampino')|| ...
            strcmp(vname,'terminillomtn')||strcmp(vname,'trapanibirgi'))
        pdats=eval(sprintf('mb_%s.data',vname));
        dats(:,:,index) = pdats(trange,:);
        lat = eval(sprintf('mb_%s.lat', vname));
        lon = eval(sprintf('mb_%s.lon', vname));
        coor(index,:) = [lat lon];
    else
        pdats=eval(sprintf('%s.data',vname));
        dats(:,:,index) = pdats(trange,:);
        lat = eval(sprintf('%s.lat', vname));
        lon = eval(sprintf('%s.lon', vname));
        coor(index,:) = [lat lon];
    end
end
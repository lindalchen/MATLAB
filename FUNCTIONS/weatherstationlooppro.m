function [dt,dats,locs,vnames,coors]=weatherstationlooppro(diro, trange)
% Loads data of all the NOAA Daily Weather station and organizes it into a
% neat data matrix. More details in OUTPUT.
%
% INPUT:
%
% diro     default directory of all the weather station data
% trange   range of days for the data
% TO DO: streamline to it's mm-dd-yyyy as input, consult notebook for code
%
% OUTPUT:
%
% dt       datetime array
% dats     all the data organized by a matrix, keep in mind 4th column is
%          number date, organized by data-by-wvar-by-locs
% locs     location names
% coors    coordinates
%
% NOTE:    to convert date numbers to datetime variable
%          access by: dates = x2mdate(dats(:,4,1),0,'datetime');
%          also, make sure all your attribute columns are moved at the end
%          of the spreadsheet, cant do it because the matrix has to have
%          all doubles.

defval('diro','/Users/linda/Documents/MATLAB/FRS161/DATA/WeatherStationData/');

% from 01-01-1985 to 31-12-2018 for FRS161 (class) Dataset
defval('trange', 1:12418);

% Loading the file
[Dn, Ds, Dt] = xlsread(fullfile(diro, 'NOAAWeatherStationData.xlsx'));

locs = unique(Ds(2:end,2)); % lmao keep in mind this is in alphabetical order
Dd = x2mdate(Dn(:,4),0,'datetime');
dt = Dd(trange);

%some data cleanup
bvar = find(Dn==999);
Dn(bvar) = NaN;

%Names of each variable
vnames = Ds(1, 3:end)';

% loops through each weather station
for index = 1:length(locs)
    stationind = find(strcmp(Ds(2:end,2), locs(index)));
    dtnums = datenum(Dd(stationind));
    
    % changing indicies of the gaps
    diffs = diff(dtnums);
    gap = find(diffs~=1); 
    
    % original inidicies of the gaps
    origap = find(diffs~=1);
    pdats = Dn(stationind,:);
    coors(index,:) = [pdats(1,1) pdats(1,2)];
    
    if length(gap) > 1
        for j = 1:length(gap)
            insdex = gap(j);
            gapdex = origap(j);
            for k = 1:diffs(gapdex)-1
                mdate = pdats(insdex,4)+k;
                nanrow = [pdats(insdex,1:3) mdate NaN(1,5)];
                pdats = [pdats(1:insdex+k-1,:); nanrow; pdats(insdex+k:end,:)];
                gap=gap+1;
            end
        end
    end
    dats(:,:,index) = pdats(trange,:);
end
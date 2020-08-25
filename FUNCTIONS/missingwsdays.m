function [dt,dats,locs]=missingwsdays(diro)
%Loads data of all the weather in a folder, uses indicies (order at which
%the farms are listed in locs). You can apply this to other forms of data 
%loading for all the farms.

defval('diro','/Users/linda/Documents/MATLAB/FRS161/DATA/WeatherStationData/'); 
%weather data
%locations organized in alphabettical order
bindex = [2 12674 22607 35312 48012 60459 73057 85760 98241 ...
    110862 123565 136270 148021 160502 173053 184809 197022 ...
    209723 222330];

endex = [12673 22606 35311 48011 60458 73056 85759 98240 110861 ...
    123564 136269 148020 160501 173052 184808 197021 209722 222329 ...
    234862];
locs={'montesamelo' 'terminillo' 'romaciampino' 'trapanibirgi' ...
    'marinadiginosa' 'cervia' 'grosseto' 'capepalinuro'...
    'messina' 'pisa' 'brindisi' ...
    'frontone' 'practicadimare' 'santamariadileuc'...
    'ghedi' 'campobasso' 'istrana' 'ponzaisland'...
    'cozzspadaro'};

index=1;

[Dn, Ds, Dt] = xlsread(fullfile(diro, 'NOAAWeatherStationData.xlsx'));
locs2 = unique(Ds(2:end,2)); % lmao keep in mind this is in alphabetical order
Dd = x2mdate(Dn(:,4),0,'datetime');

% Some Data Cleanup
bvar = find(Dn==999);
Dn(bvar) = NaN;

%names of each variable:
varnames = Ds(1, 3:end)';

for i = 1:length(locs2)
    % Checks which days are missing by how much
    stationind = find(strcmp(Ds(2:end,2), locs2(i)));
    dtnums = datenum(Dd(stationind));
    
    datanum = Dn(stationind,:);
    
    diffs = diff(dtnums);
    g = find(diffs~=1);
    if length(g) > 1
        g = g(1:end-1);
    end
    %does which index, which dates, and how many days
    % use cellstr
    rawgap = {num2str(g); datestr(dtnums(g)); diffs(g)};
    gap = {cellstr(num2str(g)); cellstr(datestr(dtnums(g))); ...
        cellstr(num2str(diffs(g)))}; 
    
    if length(gap) > 0
        for n = 1:length(gap{1})
            for m = 1:length(gap)
                if m > 1
                    dispstr = append(dispstr, gap{m}(n));
                else
                    dispstr = append(char(locs2{i}), ' ',gap{m}(n), ' ');
                end 
            end
            disp(dispstr);
        end
    else
        disp('No empty data!');
    end
    % to access cell array do gap{row}(col)
    %find sizes then display values
    save(sprintf('%smissingdates', char(locs2{i})),'rawgap');
    
    
    %Calculates missing data
    pregap = find(isnan(datanum(:,5)));
    tavgap = find(isnan(datanum(:,7)));
    tmaxgap = find(isnan(datanum(:,8)));
    tmingap = find(isnan(datanum(:,9)));
    
    preper = length(pregap)/length(Dn)*100;
    tavper = length(tavgap)/length(Dn)*100;
    tmaxper = length(tmaxgap)/length(Dn)*100;
    tminper = length(tmingap)/length(Dn)*100;
    
    nandata = {pregap tavgap tmaxgap tmingap};
    nandatapercent = [preper tavper tmaxper tminper];
    save(sprintf('%sNaNdata', char(locs2{i})),'nandata','nandatapercent');
    
    dispdata = append(char(locs2{i}), ' ', num2str(preper), ' ', num2str(tavper), ...
        ' ', num2str(tmaxper), ' ', num2str(tminper));
    
    disp(dispdata);
end
dt = 1;
dats = 2;
locs = 3;
%[Dn, Ds, Dt] = xlsread('NOAAWeatherStationData.xlsx',sprintf('A%i:K%i',bindex(index),endex(index)));

% convert excel date to matlab date
%{
dt = x2mdate(Dn(:,4),0,'datetime');
data=nan(length(dt),9,length(bindex));
for index=1:length(bindex)
    [Dn, Ds, Dt] = xlsread('NOAAWeatherStationData.xlsx',sprintf('A%i:K%i',bindex(index),endex(index)));
    % convert excel date to matlab date
    dt = x2mdate(Dn(:,4),0,'datetime');
    dats(:,:,index)=Dn;
end
%}
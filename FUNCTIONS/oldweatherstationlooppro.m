function [dt,dats,locs]=oldweatherstationlooppro(diro)
%Loads data of all the weather in a folder, uses indicies (order at which
%the farms are listed in locs). You can apply this to other forms of data 
%loading for all the farms.

defval('diro','/Users/linda/Documents/MATLAB/FRS161/DATA/WeatherStationData/'); 
%weather data

%locations organized in alphabettical order
[Dn, Ds, Dt] = xlsread(fullfile(diro, 'NOAAWeatherStationData.xlsx'));
locs2 = unique(Ds(2:end,2)); % lmao keep in mind this is in alphabetical order
Dd = x2mdate(Dn(:,4),0,'datetime');

%some data cleanup
bvar = find(Dn==999);
Dn(bvar) = NaN;

%names of each variable:
varnames = Ds(1, 3:end)';
%%
for i = 1:length(locs2)
    % Checks which days are missing by how much
    stationind = find(strcmp(Ds(2:end,2), locs2(i)));
    dtnums = datenum(Dd(stationind));
    
    data = Dn(stationind,:);
    %{
    does which index, which dates, and how many days
    % use cellstr
    diffs = diff(dtnums);
    g = find(diffs~=1);
    if length(g) > 1
        g = g(1:end-1);
    end
    rawgap = {num2str(g); datestr(dtnums(g)); diffs(g)};
    gap = {cellstr(num2str(g)); cellstr(datestr(dtnums(g))); ...
        cellstr(num2str(diffs(g)))}; 
    %}
    
    gs = 1:3; %assume growing season is june 01 through september 30
    uy = unique(year(Dd))'-1;
    for i = 1:length(uy)
        mgsTx(i) = nansum(Dn((year(Dd)==uy(i) & month(Dd)>=gs(1) & month(Dd)<=gs(end)),7));
    end
    
    plotlineartrend(uy,mgsTx,i);
    
    %{
    % fit a line to mean growing season Tmax for 1980-2019
    [Coefs P] = polyfit(uy, mgsTx, 1);
    %[Coefs P] = polyfit(uy(31:end), mgsTx(31:end), 1);
    R2 = 1 - (P.normr/norm(mgsTx(2:end) - mean(mgsTx(2:end))))^2;
    %R2 = 1 - (P.normr/norm(mgsTx(31:end) - mean(mgsTx(31:end))))^2;
    x = linspace(min(uy), max(uy), 100);
    %x = linspace(min(uy(31:end)), max(uy(31:end)), 100);
    y = polyval(Coefs, x);
    dy = y(end)-y(1);
    
    figure(i)
    hold on
    grid on
    plot(uy,mgsTx,'LineWidth',2)
    p1=plot(x, y, '-k', 'LineWidth', 2);
    ylabel('Yearly P')
    legend([p1],sprintf('1985-2018 (r^2=%3.2f,dT_{max}=%3.1fmm)',R2,dy),...
        'FontSize',14,'Location','NorthWest')
    %title(sprintf('%s',  char(locs2{i})));
    set(gca,'FontSize',14)
    hold off
    %}
end
dt = 1;
dats = 2;
locs = 3;
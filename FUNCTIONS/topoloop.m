function [xc, yc, topo] = topoloop(ridiro, tdiro)
% Creates all the topography graphs
%   Detailed explanation goes here
%
% Note: No 'enotre1' for this case, frantoicutera is frantoicutrera
% frantoiodicornoledo is frantoiocornoleda
% edited 12/25

defval('ridiro', '/Users/linda/Documents/MATLAB/FRS161/DATA/RIDATA');
defval('tdiro', '/Users/linda/Documents/MATLAB/FRS161/DATA/TOPODATA');

 locs={'agrestis' 'bagliodipianetto' 'brindisi' 'campobasso' 'carainene' 'ceraudo' ...
   'cervia' 'darioratta' 'enotre' 'feudodisisa' 'frantoicutrera'...
   'frantoioacri' 'frantoiodecarlo' 'frantoiocornoleda' ...
   'frantoiohermes' 'grosseto' 'laselvotta' 'marinadiginosa' 'messina' ...
   'oleariasangiorgio' 'oliocru' 'oliointini' 'pisa' 'romaciampino' ...
   'sorellegarzo' 'tenutelibrandipasquale'...
   'titone' 'terminillomtn' 'trapanibirgi' 'trecolonne'};

 nl = {'brindisi' 'campobasso' 'cervia' 'grosseto' 'marinadiginosa'...
    'messina' 'pisa' 'romaciampino' 'terminillomtn' 'trapanibirgi'};

for index=1:length(locs)
    vname=locs{index};
    figure(index);
    if(any(strcmp(vname,nl)))
        fname=sprintf('td_%s.mat',vname);
        load(fullfile(tdiro,fname));
        yeye = yeye(1)-10*3999:10:yeye(1);
        map = plotttopo(topodata, xeye, yeye, char(locs{index}));
        topo{:,:,index} = topodata;
        xc{:,:,index} = xeye;
        yc{:,:,index} = yeye;
    else
        fname=sprintf('ri_%s.mat',vname);
        load(fullfile(ridiro,fname));
        topodata = eval(sprintf('%s.topodata', vname));
        xeye = eval(sprintf('%s.xeye', vname));
        yeye = eval(sprintf('%s.yeye', vname));
        map=plotttopo(topodata, xeye, yeye, char(locs{index}));
        topo{:,:,index} = topodata;
        xc{:,:,index} = xeye;
        yc{:,:,index} = yeye';
    end
    %savefig(sprintf('%s',char(locs{index})));
    %saveas(gcf,sprintf('%s.jpg',char(locs{index})));
end
end


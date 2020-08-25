function [R2, dy, x, y] = lineartrend(xdata,ydata)
%Plotting a linear trend of the function
    % fit a line to mean
    [Coefs, P] = polyfit(xdata, ydata, 1);
    %[Coefs P] = polyfit(yeers(31:end), datats(31:end), 1);
    R2 = 1 - (P.normr/norm(ydata - mean(ydata)))^2;
    %R2 = 1 - (P.normr/norm(datats(31:end) - mean(datats(31:end))))^2;
    x = linspace(min(xdata), max(xdata), 100);
    %x = linspace(min(yeers(31:end)), max(yeers(31:end)), 100);
    y = polyval(Coefs, x);
    dy = y(end)-y(1);
    
    %{
    figure(i)
    hold on
    grid on
    plot(yeers,datats,'LineWidth',2)
    lp=plot(x, y, '-k', 'LineWidth', 2);
    ylabel('Yearly P')
    legend([p1],sprintf('1985-2018 (r^2=%3.2f,dT_{max}=%3.1fmm)',R2,dy),...
        'FontSize',14,'Location','northWest')
    %title(sprintf('%s',  char(locs2{i})));
    set(gca,'FontSize',14)
    hold off
    %}
end


function correlation = correlation_plot(my_score,MOS,ci)

params = polyfit( my_score, MOS,3);
fitted_scores = polyval(params,my_score);
correlation = corrcoef(fitted_scores,MOS);
correlation = correlation(2);
errorbar(fitted_scores,MOS,ci,'g*');
xlabel('Fitted scores');
ylabel('MOS');
hold on;
plot(fitted_scores,MOS,'r*');
hold on;
max_value = max(my_score);

if max(MOS) > max_value
    max_value = max(MOS);
end

x=0:max_value+1;
y=0:max_value+1;
plot(x,y);
xlim([0 max_value+1]);
ylim([0 max_value+1]);
grid on

end
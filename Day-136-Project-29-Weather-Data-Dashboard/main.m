% Day 136 · Project 29: Weather Data Dashboard — Full program
% Run: open this file in MATLAB and press Run (or type main in the Command Window)

clc; clear; close all;
rng(2026);
d = datenum(2025, 1, 1):datenum(2025, 12, 31);
n = numel(d); doy = (1:n)';
monsoon = doy > 180 & doy < 270;
Tmax = 32 + 8*cos(2*pi*(doy - 160)/365) - 6*monsoon + 2.5*randn(n, 1);   % hottest in early June, cooler in the monsoon
Tmax(150:156) = Tmax(150:156) + 6;                      % a heat wave in early June
Tmin = Tmax - 9 - 2*randn(n, 1);
rain = max(0, (monsoon*18 + 1) .* (rand(n, 1) < (0.1 + 0.55*monsoon)) .* exprnd_local(1, n));
humid = min(100, 40 + 40*monsoon + 5*randn(n, 1));
wind = abs(8 + 3*randn(n, 1));
% ---- save and read back ----
fid = fopen('weather_2025.csv', 'w');
fprintf(fid, 'date,tmax,tmin,rain_mm,humidity,wind_kmh\n');
for k = 1:n
    fprintf(fid, '%s,%.1f,%.1f,%.1f,%.0f,%.1f\n', datestr(d(k), 'yyyy-mm-dd'), Tmax(k), Tmin(k), rain(k), humid(k), wind(k));
end
fclose(fid);
fid = fopen('weather_2025.csv'); C = textscan(fid, '%s %f %f %f %f %f', 'Delimiter', ',', 'HeaderLines', 1); fclose(fid);
delete('weather_2025.csv');
dates = datenum(C{1}, 'yyyy-mm-dd'); Tmax = C{2}; Tmin = C{3}; rain = C{4}; humid = C{5}; wind = C{6};
dv = datevec(dates); month = dv(:, 2);
% ---- monthly statistics ----
mon = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
avgTmax = accumarray(month, Tmax) ./ accumarray(month, 1);
avgTmin = accumarray(month, Tmin) ./ accumarray(month, 1);
rain_m = accumarray(month, rain);
rainy_days = accumarray(month, rain > 1);
fprintf('%5s %8s %8s %9s %6s\n', 'Month', 'Tmax', 'Tmin', 'Rain mm', 'Rainy');
for m = 1:12
    fprintf('%5s %8.1f %8.1f %9.1f %6d\n', mon{m}, avgTmax(m), avgTmin(m), rain_m(m), rainy_days(m));
end
[hot, kh] = max(Tmax); [cold, kc] = min(Tmin); [wet, kw] = max(rain);
fprintf('\nHottest day %s (%.1f C), coldest night %s (%.1f C), wettest day %s (%.1f mm)\n', ...
    datestr(dates(kh), 'dd-mmm'), hot, datestr(dates(kc), 'dd-mmm'), cold, datestr(dates(kw), 'dd-mmm'), wet);
% ---- heat waves: at least 3 days in a row above 40 C ----
hotday = [0; Tmax > 40; 0];
starts = find(diff(hotday) == 1); ends = find(diff(hotday) == -1) - 1;
len = ends - starts + 1;
for k = find(len >= 3)'
    fprintf('Heat wave: %s to %s (%d days)\n', datestr(dates(starts(k)), 'dd-mmm'), datestr(dates(ends(k)), 'dd-mmm'), len(k));
end
Tmean = (Tmax + Tmin)/2;
CDD = sum(max(Tmean - 24, 0)); HDD = sum(max(18 - Tmean, 0));
fprintf('Cooling degree-days %.0f, heating degree-days %.0f (base 24 C / 18 C)\n', CDD, HDD);
% ---- dashboard ----
subplot(3, 2, 1); plot(dates, Tmax, 'r', dates, Tmin, 'b'); hold on; plot(dates, movmean(Tmax, 15), 'k', 'LineWidth', 1.5); hold off
datetick('x', 'mmm'); title('Daily temperature (C)'); grid on
subplot(3, 2, 2); bar(rain_m); set(gca, 'XTick', 1:12, 'XTickLabel', mon); title('Monthly rain (mm)')
subplot(3, 2, 3); plot(1:12, avgTmax, 'r-o', 1:12, avgTmin, 'b-o'); set(gca, 'XTick', 1:12, 'XTickLabel', mon); title('Monthly averages'); grid on
subplot(3, 2, 4); hist(Tmax, 25); title('Distribution of Tmax')
subplot(3, 2, 5); scatter(Tmax, humid, 10, month, 'filled'); xlabel('Tmax'); ylabel('Humidity %'); title('Temperature vs humidity')
subplot(3, 2, 6); pie(accumarray(1 + (rain > 1) + (rain > 20), 1), {'dry', 'light rain', 'heavy rain'}); title('Days by rain')

function r = exprnd_local(mu, n)
    r = -mu * log(rand(n, 1));          % exponential random numbers without a toolbox
end

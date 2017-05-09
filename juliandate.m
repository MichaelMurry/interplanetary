function jd = juliandate(year, month, day, hour, minute, second)
% juliandate.m converts year, month, day, hours, minute, second to Julian
% Date
%   Input:
%       year = calendar year
%       month = calendar month
%       day = calendar day
%       hour = calendar hour
%       minute = calendar minute
%       second = calendar second
%   Output:
%       jd = julidan date

%% Initialize
day = day + ((second/60 + minute)/60 + hour)/24;

%% Compute
if(month < 3)
  year = year - 1;
  month = month + 12;
end

A = floor(year/100);
B = 2 - A + floor(A/4);

if(year < 1583)
  B = 0;
  if(year == 1582 && month > 9)
    if(day > 14)
      B = 2 - A + floor(A/4);
    end
  end
end
jd = floor(365.25*(year+4716)) + floor(30.6001*(month+1)) + day + B - 1524.5;
end


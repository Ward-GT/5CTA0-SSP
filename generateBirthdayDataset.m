function people = generateBirthdayDataset(N)
%GENERATEBIRTHDAYDATASET Generate a dataset of people with random names and birthdays
%   people = generateBirthdayDataset(N) returns a table with N rows,
%   each containing a random name and a random birthday.
%
%   Example:
%       people = generateBirthdayDataset(50);

    if nargin < 1
        N = 50; % default size
    end
    
    % Define lists of first and last names
    firstNames = { 'Alice','Bob','Charlie','Diana','Ethan','Fiona','George','Hannah', ...
                   'Ian','Julia','Kevin','Laura','Michael','Nina','Oliver','Paula', ...
                   'Quentin','Rachel','Sam','Tina','Uma','Victor','Wendy','Xavier', ...
                   'Yara','Zane'};
               
    lastNames = { 'Smith','Johnson','Williams','Brown','Jones','Miller','Davis', ...
                  'Garcia','Rodriguez','Wilson','Martinez','Anderson','Taylor', ...
                  'Thomas','Hernandez','Moore','Martin','Jackson','Thompson', ...
                  'White','Lopez','Lee','Gonzalez','Clark','Lewis','Robinson'};
              
    % Generate random names
    names = cell(N,1);
    for i = 1:N
        fn = firstNames{randi(numel(firstNames))};
        ln = lastNames{randi(numel(lastNames))};
        names{i} = sprintf('%s %s', fn, ln);
    end
    
    % Generate random birthdays (fixed year 1995)
    startDate = datetime(1990,1,1);
    endDate   = datetime(2000,12,31);
    dayRange  = days(endDate - startDate);
    birthdays = startDate + days(randi(dayRange+1, N, 1) - 1);
    
    % Output as a table
    people = table(names, birthdays, 'VariableNames', {'Name','Birthday'});
end
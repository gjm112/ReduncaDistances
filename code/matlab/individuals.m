cd('/Users/nastaranghorbani/Documents/shape/code/matlab');

% test LM1_pricei
folderPath = '/Users/nastaranghorbani/Documents/shape/data/individuals/LM1_pricei/';
numFiles = 19; 


q_representations = cell(numFiles, 1);
centered_curves = cell(numFiles, 1);


for i = 1:numFiles
    
    fileName = fullfile(folderPath, sprintf('data_LM1_pricei_%d.csv', i));
    
   
    
    
    data = csvread(fileName, 1, 0); 

    
    q_representations{i} = curve_to_q(data);
    curves{i} = q_to_curve(q_representations{i});

    
    centered_curves{i}(1,:) = curves{i}(1,:) - mean(curves{i}(1,:)); % Center x-coordinates
    centered_curves{i}(2,:) = curves{i}(2,:) - mean(curves{i}(2,:)); % Center y-coordinates
end


figure; hold on;
colors = lines(numFiles); 
for i = 1:numFiles
    plot(centered_curves{i}(1,:), centered_curves{i}(2,:), 'Color', colors(i,:));
end
hold off;
title('Comparison');
xlabel('X Coordinate');
ylabel('Y Coordinate');
legend(arrayfun(@(x) sprintf('Curve %d', x), 1:numFiles, 'UniformOutput', false));



%%%%%%%%%



cd('/Users/nastaranghorbani/Documents/shape/code/matlab');

toothtypes = {'LM1', 'LM2', 'LM3', 'UM1', 'UM2', 'UM3'};
species = {'scriptus', 'pricei'};

baseFolderPath = '/Users/nastaranghorbani/Documents/shape/data/individuals/';

% Loop through each tooth type and species
for t = 1:length(toothtypes)
    for s = 1:length(species)
        folderPath = fullfile(baseFolderPath, [toothtypes{t} '_' species{s} '/']);
        
        % Get the list of files in the directory
        files = dir(fullfile(folderPath, '*.csv'));
        numFiles = length(files);  % Number of CSV files

        q_representations = cell(numFiles, 1);
        centered_curves = cell(numFiles, 1);
        curves = cell(numFiles, 1);  % Initialize curves cell array

        for i = 1:numFiles
            fileName = fullfile(folderPath, sprintf('data_%s_%s_%d.csv', toothtypes{t}, species{s}, i));
            
            % Check if the file exists
            if exist(fileName, 'file') == 2
                % Read the CSV file, skipping the first row (header)
                data = csvread(fileName, 1, 0);

                % Convert data to q representation and back to curve
                q_representations{i} = curve_to_q(data);
                curves{i} = q_to_curve(q_representations{i});

                % Center the curves
                centered_curves{i}(1,:) = curves{i}(1,:) - mean(curves{i}(1,:)); % Center x-coordinates
                centered_curves{i}(2,:) = curves{i}(2,:) - mean(curves{i}(2,:)); % Center y-coordinates
            else
                fprintf('File not found: %s\n', fileName);
            end
        end

        % Plot the centered curves if any were processed
        if ~isempty(centered_curves)
            figure; hold on;
            colors = lines(numFiles); 
            for i = 1:numFiles
                if ~isempty(centered_curves{i})
                    plot(centered_curves{i}(1,:), centered_curves{i}(2,:), 'Color', colors(i,:));
                end
            end
            hold off;
            title(sprintf('Comparison of %s %s', toothtypes{t}, species{s}));
            xlabel('X Coordinate');
            ylabel('Y Coordinate');
            legend(arrayfun(@(x) sprintf('Curve %d', x), 1:numFiles, 'UniformOutput', false));
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RUN TO GET DEBRIS FROM SIMULATEDEBRIS FUNCTION %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Specify the path to your CSV file
csv_file = 'altitude_density_data.csv';

% Number of debris particles to simulate
num_debris = 1000;

% Call the function
debris_table = simulateDebris(csv_file, num_debris);

% Display the first few rows of the debris table
disp(head(debris_table));

% Optionally save the table to a CSV file
writetable(debris_table, 'simulated_debris_data.csv');

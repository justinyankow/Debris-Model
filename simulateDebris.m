
function debris_table = simulateDebris(csv_file, num_debris)
    % SIMULATEDEBRIS Simulates space debris based on altitude-density data.
    %
    % Inputs:
    %   csv_file   - Path to the CSV file with altitude and density data.
    %   num_debris - Number of debris particles to simulate.
    %
    % Outputs:
    %   debris_table - Table containing the simulated debris properties.
    
    % Load altitude-density data from the specified CSV file
    altitude_density_data = readtable(csv_file);
    
    % Initialize the debris table
    debris_table = table();
    
    % Loop to simulate debris particles
    for i = 1:num_debris
        % Randomly select an altitude and its corresponding density
        rand_index = randi(height(altitude_density_data));
        altitude = altitude_density_data{rand_index, 1}; % First column for Altitude
        density = altitude_density_data{rand_index, 2}; % Second column for Density
        % Generate random position in a spherical shell at the given altitude
        r = altitude + (rand() - 0.5) * 10; % Slight variation in altitude (±5 km)
        theta = rand() * pi; % Random polar angle
        phi = rand() * 2 * pi; % Random azimuthal angle
        
        % Convert spherical to Cartesian coordinates
        x = r * sin(theta) * cos(phi);
        y = r * sin(theta) * sin(phi);
        z = r * cos(theta);
        
        % Generate random velocity (typical orbital speed with variations)
        velocity_magnitude = 7.5 + randn() * 0.5; % Mean speed ~7.5 km/s
        velocity_theta = rand() * pi; % Random direction angle
        velocity_phi = rand() * 2 * pi; % Random azimuthal angle
        
        % Convert spherical velocity to Cartesian coordinates
        vx = velocity_magnitude * sin(velocity_theta) * cos(velocity_phi);
        vy = velocity_magnitude * sin(velocity_theta) * sin(velocity_phi);
        vz = velocity_magnitude * cos(velocity_theta);
        
        % Random size for debris particle (e.g., diameter in meters)
        size = rand() * 2 + 0.1; % Random size between 0.1 and 2.1 meters
        
        % Append data to the debris table
        debris_table = [debris_table; table(x, y, z, vx, vy, vz, size, density)];
    end
    
    % Assign column names to the table
    debris_table.Properties.VariableNames = {'X', 'Y', 'Z', 'VX', 'VY', 'VZ', 'Size', 'Density'};
end
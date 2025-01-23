function debris_particles = get_debris(num_debris)
    % Generates debris particles with random initial positions and velocities
    debris_particles(num_debris) = Debris;
    for i = 1:num_debris
        % Random initial position (example within LEO altitude)
        altitude = 200 + (2000 - 200) * rand;
        angle1 = rand * 2 * pi;
        angle2 = rand * pi;
        x = altitude * cos(angle1) * sin(angle2);
        y = altitude * sin(angle1) * sin(angle2);
        z = altitude * cos(angle2);
        
        % Random initial velocity (simplified, adjust as necessary)
        speed = 7 + rand * 1;  % Roughly orbital speed in LEO
        vx = speed * cos(angle1);
        vy = speed * sin(angle1);
        vz = 0; % Simplified to be in-plane
        
        % Random size (for potential future use)
        size = rand * 0.5; % Size in meters
        
        debris_particles(i) = Debris([x, y, z], [vx, vy, vz], size);
    end
end

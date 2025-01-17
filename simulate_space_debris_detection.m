function simulate_space_debris_detection()
    % Simulation parameters
    dt = 1;             % Time step (seconds)
    total_time = 1;        % Total simulation time (seconds)
    steps = total_time / dt;
    mu = 398600.4418;        % Gravitational parameter for Earth (km^3/s^2)
    
    % Initialize debris particles
    num_debris = 1000000;
    debris_particles = initialize_debris(num_debris);
    
    % Initialize cubesat
    cubesat_position = [7000, 0, 0]; % Example initial position in km
    cubesat_velocity = [0, 7.5, 0];  % Example initial velocity in km/s
    fov = 30;       % Field of view in degrees
    range = 100;    % Detection range in km
    cubesat = Cubesat(cubesat_position, cubesat_velocity, fov, range);
    
    % Initialize detection count
    detection_count = 0;
    
    % Simulation loop
    for step = 1:steps
        fprintf("a")
        % Update debris positions
        for i = 1:num_debris
            debris_particles(i) = debris_particles(i).apply_orbital_dynamics(dt, mu);
        end
        
        % Update cubesat position
        cubesat = cubesat.update_position(dt);
        
        % Check for detections
        for i = 1:num_debris
            if cubesat.detect_debris(debris_particles(i))
                detection_count = detection_count + 1;
            end
        end
    end
    
    fprintf('Total detections during simulation: %d\n', detection_count);
end

function debris_particles = initialize_debris(num_debris)
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

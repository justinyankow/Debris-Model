classdef Cubesat
    properties
        position    % [x, y, z] position in km
        velocity    % [vx, vy, vz] velocity in km/s
        fov         % Field of View in degrees
        range       % Detection range in km
    end
    
    methods
        % Constructor
        function obj = Cubesat(position, velocity, fov, range)
            if nargin > 0
                obj.position = position;
                obj.velocity = velocity;
                obj.fov = fov;
                obj.range = range;
            end
        end
        
        % Method to update position based on velocity and timestep
        function obj = update_position(obj, dt)
            obj.position = obj.position + obj.velocity * dt;
        end
        
        % Method to check if debris is within the sensor's volume
        function detected = detect_debris(obj, debris)
            % Vector from cubesat to debris
            rel_position = debris.position - obj.position;
            distance = norm(rel_position);
            
            % Check if within range
            if distance > obj.range
                detected = false;
                return;
            end
            
            % Calculate angle between sensor direction and debris position
            sensor_direction = obj.velocity / norm(obj.velocity); % Assume forward looking
            rel_position_norm = rel_position / distance;
            angle = acos(dot(sensor_direction, rel_position_norm)) * (180/pi); % Convert to degrees
            
            % Check if within field of view
            detected = angle <= obj.fov / 2;
        end
    end
end

classdef Debris
    properties
        position    % [x, y, z] position in km
        velocity    % [vx, vy, vz] velocity in km/s
        size        % Size of the debris particle (e.g., diameter in m)
    end
    
    methods
        % Constructor
        function obj = Debris(position, velocity, size)
            if nargin > 0
                obj.position = position;
                obj.velocity = velocity;
                obj.size = size;
            end
        end
        
        % Method to update position based on velocity and timestep
        function obj = update_position(obj, dt)
            % Update position based on current velocity and dt (in seconds)
            obj.position = obj.position + obj.velocity * dt;
        end
        
        % Method to apply simple orbital mechanics (e.g., gravitational acceleration)
        function obj = apply_orbital_dynamics(obj, dt, mu)
            r = norm(obj.position);            % Distance from Earth center
            a_gravity = -mu * obj.position / r^3;  % Gravitational acceleration vector
            
            % Update velocity with gravity effect
            obj.velocity = obj.velocity + a_gravity * dt;
            
            % Update position based on new velocity
            obj = obj.update_position(dt);
        end
    end
end
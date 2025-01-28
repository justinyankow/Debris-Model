classdef Simulator
    properties
        debris      % [debris...] list of debris objects
        cubesat     % cubsat object
        timestep    % time between frames in seconds
        mu          % Gravitational parameter for Earth (km^3/s^2)
        num_debris  % Count of debris particles
        duration    % Duration of simulation (seconds)

        detection_count
    end
    
    methods
        % Constructor
        function this = Simulator()
            fprintf("Init Simulator...\n")
            this.num_debris = 100000;
            this.mu = 398600.4418;
            this.timestep = 10;
            this.duration = 60;
            
            cubesat_position = [2000, 0, 0]; % Example initial position in km
            cubesat_velocity = [0, 7.5, 0];  % Example initial velocity in km/s
            fov = 90;       % Field of view in degrees
            range = .1;    % Detection range in km

            this.debris = get_debris(this.num_debris);
            this.cubesat = Cubesat(cubesat_position, cubesat_velocity, fov, range);

            this.detection_count = 0;
            fprintf("Finished Init Simulator\n")
        end

        function this = run(this)
            fprintf("Running Simulator\n")
            steps = this.duration / this.timestep;

            for step = 1:steps
                tic
                fprintf("Step %d\n", step)
                % Update debris positions
                for i = 1:this.num_debris
                    if mod(i, floor(this.num_debris / 10)) == 0
                        fprintf("Debris %d\n", i)
                    end
                    this.debris(i) = this.debris(i).apply_orbital_dynamics(this.timestep, this.mu);
                    %this.debris(i) = Update(this.debris(i), this.timestep, this.mu);
                end
                fprintf("Updated Debris\n")
                % Update cubesat position
                this.cubesat.update_position(this.timestep);
                
                % Check for detections
                for i = 1:this.num_debris
                    if mod(i, floor(this.num_debris / 10)) == 0
                        fprintf("Debris %d\n", i)
                    end
                    if this.cubesat.detect_debris(this.debris(i))
                        this.detection_count = this.detection_count + 1;
                        fprintf("FOUND PARTICLE===================================================================================================   %d\n", this.detection_count)
                    end
                end
                toc
            end
           
            fprintf("Simulator Finished\n")
        end
    end
end

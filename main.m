function main()
    
    tic
    simulator = Simulator;
    toc
    simulator = simulator.run();
 
    fprintf("Found %d debris\n", simulator.detection_count)
end
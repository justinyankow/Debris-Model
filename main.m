function main()
    simulator = Simulator;
    simulator = simulator.run();
    fprintf("Found %d debris\n", simulator.detection_count)
end
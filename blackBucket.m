classdef BlackBucket < AbstractBucket
    %UNTITLED9 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Constant = true)
        colorName = 'Black';
        rgbColor = [36,36,36]; % grau, damit man es von der maske unterscheiden kann
        hueMin = 0;
        hueMax = 1;
        satMin = 0;
        satMax = 1;
        valMin = 0;
        valMax = 0.15;
    end
end


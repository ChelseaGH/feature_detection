%Files Names
File1 = 'img\Yosemite\Yosemite1.jpg';;
File2 = 'img\Yosemite\Yosemite2.jpg';

%Feature Thresholds. Higher Thresholds restrict what features will display
Threshold1 = 1000;
Threshold2 = 1000;

%SSD Tolerance. Lower values restrict what distances are accepted
SSDTolerance = .85;

%This runs the program. Please adjust commented portions in GetFeatures()
%if you would like to run other Feature Descriptor methods 
FeatureDetection( File1,      ...
                  File2,      ...
                  Threshold1, ...
                  Threshold2, ...
                  SSDTolerance   );
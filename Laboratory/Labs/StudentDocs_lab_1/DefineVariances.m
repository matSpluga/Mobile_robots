% Set the parameters which have the "Determined by student" comment to tune
% the Kalman filter. Do not modify anything else in this file.

% Uncertainty on initial position of the robot.

%distribuzione uniforme perchè le distanze tra i rilevamenti sono tutte
%uguali

sigmaX     = 3 ;  %prof ha messo 5       % Determined by student 3.3 (vedi da video)
sigmaY     = 3 ;  %prof ha messo 5        % Determined by student 3.3
sigmaTheta = deg2rad(5) ;%prof deg2rad(5) no relation with encoder resolution (in case of this robot, with this
                                     %level of resolution   % Determined by
                                     %student 0.26
Pinit = diag( [sigmaX^2 sigmaY^2 sigmaTheta^2] ) ;

% Measurement noise.

sigmaXmeasurement = sqrt((20^2)/12); %prof sqrt((20^2)/12) ;  % ((119-90)^2) / 12 tutto sotto radice
sigmaYmeasurement = sqrt((10^2)/12);%prof sqrt((10^2)/12)  % 5 perchè +-5 è il massimo errore di lettura che si può commettere
Qgamma = diag( [sigmaXmeasurement^2 sigmaYmeasurement^2] ) ;


% Input noise

sigmaTuning = 0.1 ; %if 0 it means that your odom is perfect and it cannot be
Qwheels = sigmaTuning^2 * eye(2) ;
Qbeta   = jointToCartesian * Qwheels * jointToCartesian.' ; 

% State noise
 
Qalpha = zeros(3) ;

% Mahalanobis distance threshold

mahaThreshold = sqrt(chi2inv(0.95, 2)) ;  % Determined by student

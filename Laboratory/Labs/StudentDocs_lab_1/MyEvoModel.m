function X_next = MyEvoModel(X, U)
    % Evoluzione dello stato del robot mobile differenziale
    % X = [x; y; theta] : actual state
    % U = [v; omega]   : control input
    % X_next          : next state

    %temporal step
    dt = 1;

    % state and control variables
    x = X(1);
    y = X(2);
    theta = X(3);

    v = U(1);
    omega = U(2);

    % Kinematic model
    x_next = x + v * cos(theta) * dt;
    y_next = y + v * sin(theta) * dt;
    theta_next = theta + omega * dt;

    % Angle normalization 
    %theta_next = atan2(sin(theta_next), cos(theta_next));

    % Next state
    X_next = [x_next; y_next; theta_next];
end
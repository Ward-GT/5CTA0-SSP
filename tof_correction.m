function delayed_data = tof_correction(rf, x_grid, z_grid)

    % Set global parameters
    N_ax = size(rf,1);
    N_el = size(rf,2);
    fs = 25e6; % Sampling frequency
    time_vector = (0:(N_ax-1))/fs;
    angle = 0; % Transmission angle
    probe_geometry = [linspace(-19e-3,19e-3,N_el); zeros(1,N_el); zeros(1,N_el)]';
    c0 = 1540;
    
    delayed_data = zeros(numel(x_grid), N_el);
    data = rf;
    
    % Get the size pixel grid to which we focus
    N_x = size(x_grid,1);
    N_z = size(z_grid,2);

    % Flatten the grid to vectorize calculations
    x_grid = reshape(x_grid, [], 1);
    z_grid = reshape(z_grid, [], 1);

    % TOF correction loop
    transmit_delay = z_grid*cos(angle)+x_grid*sin(angle);
    for nrx=1:N_el %for every channel
        receive_delay = sqrt((probe_geometry(nrx,1)-x_grid).^2+(probe_geometry(nrx,3)-z_grid).^2);
        delay = (transmit_delay+receive_delay)/c0;
        delayed_data(:,nrx) = interp1(time_vector',data(:,nrx),delay,'spline',0);
    end        
      
    delayed_data = double(delayed_data);
    delayed_data = permute(delayed_data, [3,1,2]);
    delayed_data = reshape(delayed_data, N_x, N_z, N_el);
end

function model= gen_model

% basic parameters
model.x_dim= 4;   %dimension of state vector
model.z_dim= 2;   %dimension of observation vector

% dynamical model parameters (CV model)
model.T= 1;                                     %sampling period
model.A0= [ 1 model.T; 0 1 ];                         %transition matrix                     
model.F= [ model.A0 zeros(2,2); zeros(2,2) model.A0 ];
model.B0= [ (model.T^2)/2; model.T ];
model.B= [ model.B0 zeros(2,1); zeros(2,1) model.B0 ];
model.sigma_v = 5;
model.Q= (model.sigma_v)^2* model.B*model.B';   %process noise covariance

% survival/death parameters
model.P_S= .99;
model.Q_S= 1-model.P_S;

% birth parameters (Poisson birth model, multiple Gaussian components)
model.L_birth= 4;                                                     %no. of Gaussian birth terms
model.w_birth= zeros(model.L_birth,1);                                %weights of Gaussian birth terms (per scan) [sum gives average rate of target birth per scan]
model.m_birth= zeros(model.x_dim,model.L_birth);                      %means of Gaussian birth terms 
model.B_birth= zeros(model.x_dim,model.x_dim,model.L_birth);          %std of Gaussian birth terms
model.P_birth= zeros(model.x_dim,model.x_dim,model.L_birth);          %cov of Gaussian birth terms
model.u_b = zeros(model.L_birth,1); model.v_b = zeros(model.L_birth,1);     % Beta parameters for unknown detection profile

model.w_birth(1)= 3/100;                                              %birth term 1
model.m_birth(:,1)= [ 0; 0; 0; 0 ];
model.B_birth(:,:,1)= diag([ 50; 50; 50; 50 ]);
model.P_birth(:,:,1)= model.B_birth(:,:,1)*model.B_birth(:,:,1)';
model.u_b(1) = 98;
model.v_b(1) = 2;
    
model.w_birth(2)= 3/100;                                              %birth term 2
model.m_birth(:,2)= [ 400; 0; -600; 0 ];
model.B_birth(:,:,2)= diag([ 50; 50; 50; 50 ]);
model.P_birth(:,:,2)= model.B_birth(:,:,2)*model.B_birth(:,:,2)';
model.u_b(2) = 98;
model.v_b(2) = 2;

model.w_birth(3)= 3/100;                                              %birth term 3
model.m_birth(:,3)= [ -800; 0; -200; 0 ];
model.B_birth(:,:,3)= diag([ 50; 50; 50; 50 ]);
model.P_birth(:,:,3)= model.B_birth(:,:,3)*model.B_birth(:,:,3)';
model.u_b(3) = 98;
model.v_b(3) = 2;

model.w_birth(4)= 3/100;                                              %birth term 4
model.m_birth(:,4)= [ -200; 0; 800; 0 ];
model.B_birth(:,:,4)= diag([ 50; 50; 50; 50 ]);
model.P_birth(:,:,4)= model.B_birth(:,:,4)*model.B_birth(:,:,4)';
model.u_b(4) = 98;
model.v_b(4) = 2;

% observation model parameters (noisy x/y only)
model.H= [ 1 0 0 0 ; 0 0 1 0 ];    %observation matrix
model.D= diag([ 10; 10 ]); 
model.R= model.D*model.D';              %observation noise covariance

% detection parameters
model.P_D= .98;   %probability of detection in measurements
model.Q_D= 1-model.P_D; %probability of missed detection in measurements

% clutter parameters
model.range_c= [ -1000 1000; -1000 1000 ];      %uniform clutter region
model.lambda_cb= 1;
model.w_cb = model.lambda_cb;
model.clutter_P_S= 0.9;
model.clutter_P_D = 0.5;     % detection probability for clutter targets
model.Lc_birth = 1; model.u_cb = 1; model.v_cb = 1;
model.pdf_c= 1/prod(model.range_c(:,2)-model.range_c(:,1)); %uniform clutter density
model.clutter_Nt = 20;     % number of clutter generators
model.lambda_c = model.clutter_Nt * model.clutter_P_D;





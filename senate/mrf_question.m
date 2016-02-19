% Load senate dataset
addpath('L1General');
addpath('GraphLayout');

load senate112small;
[N,L] = size(senatorVotes);

%% QUESTION a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% node parameters \theta_s
theta_s = zeros(N,1);

% FILL IN WITH YOUR CODE! Produce the ML estimates for theta_s.
% theta_s = ???

figure(1);
barh(theta_s);
set(gca,'YTickLabel',senatorName);
title('ML estimate of theta, assuming a fully disconnected graph');

%% QUESTION c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ss = suffStats(senatorVotes);
funLL = @(theta)isingLlik(theta, ss, L, N);

theta0 = [theta_s; zeros(N*(N-1)/2,1)];
lambdaML = zeros(size(theta0));

% assumes L1General folder is already on your path. type 'help addpath'
% and 'genpath' for information on how to add folders recursively to your
% MATLAB path.
[thetaML,llTrace] = L1General2_TMP(funLL, theta0, lambdaML);

figure(2);
plot([1:numel(llTrace)], llTrace, '-b', 'linewidth', 3);
xlabel('Iteration');
ylabel('Negative Log-Likelihood');
%% QUESTION e %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% FILL IN YOUR ENTROPY-COMPUTING CODE HERE

%% QUESTION g %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lambdaBar = [0.001,0.005,0.01,0.05,0.1,0.5,1.0,5.0,10,30,50,100];
lambdaL1  = zeros(size(theta0));

LTrain  = 400;
ssTrain = suffStats(senatorVotes(:,1:LTrain));
funLL = @(theta)isingLlik(theta, ssTrain, LTrain, N);

LTest  = L - LTrain;
ssTest = suffStats(senatorVotes(:,LTrain+1:end));
llTest = zeros(1, numel(lambdaBar));

%initialize our estimate of theta to the ML estimate from part 2c
thetaInit = thetaML;

% store the learned theta parameters for each value of lambda bar. These
% will be needed for 2i.
thetaL1 = zeros(numel(thetaInit),numel(lambdaBar));

for ll = 1:numel(lambdaBar)
    fprintf('\n');
    fprintf('************************************\n');
    fprintf('Optimizing for lambdaBar=%g\n', lambdaBar(ll));
    fprintf('************************************\n');
    fprintf('\n');
    
    lambdaL1(N+1:end) = lambdaBar(ll);
    thetaL1(:,ll) = L1General2_TMP(funLL, thetaInit, lambdaL1);
    
    % FILL IN THE COMPUTATION OF THE LOG-PROBABILITY OF THE VALIDATION DATA
    % llTest(ll) = ???
end

figure(3);
semilogx(lambdaBar,llTest);
xlabel('Log-value of lambdaBar');
ylabel('Test log-likelihood');

%% QUESTION h %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following code can be used to do visualization.

%adj = getAdjacency(thetaL1(:,1), N);
%Xcoord = [0.2 0.1 0.3 0.1 0.3 0.4 0.4 0.9 0.65 0.8 0.2 0.6 0.8];
%Ycoord = [0.4 0.1 0.1 0.3 0.3 0.2 0.9 0.4 0.8 0.65 0.8 0.1 0.2];
%figure(4); clf;
%draw_layout(adj, senatorName, zeros(N,1), Xcoord, Ycoord);

function log_Pjoint = unnormProb(theta, N)
% P = unnormProb(theta,N)
% Computes the unnormalized log probabilities of all joint states
% 
% Inputs:
%    theta: Parameters of the model. theta(1:N) encodes the parameters governing
%           the unary potentials of the model (\theta_s in the handout).
%           theta(N+1:end) encodes the parameters governing the pairwise
%           potentials  (\theta_{st}) in the handout.
%    N: The number of variables nodes in the model.
% Outputs:
%   log_Pjoint: The log of the joint probability of each of the
%               2^N configurations of the (binary) variable nodes.

dims = 2*ones(N,1);
M = prod(dims);
log_Pjoint = zeros(M,1);

state = zeros(1,N);
for m = 1:M
  % Unary potentials
  log_Pjoint(m) = sum(theta(1:N) .* state');

  % Pairwise potentials
  edgeIndex = N+1;
  for ii = 1:N-1
    for jj = ii+1:N
      log_Pjoint(m) = log_Pjoint(m) + theta(edgeIndex)*state(ii)*state(jj);
      edgeIndex = edgeIndex + 1;
    end
  end

  % Update state configuration for next iteration
  state(1) = state(1) + 1;
  for (i = 1:N-1)
    if (state(i) >= dims(i))
      state(i+1) = state(i+1) + 1;
      state(i) = 0;
    else
      break;
    end
  end
end


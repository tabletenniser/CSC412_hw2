function adj = getAdjacency(theta, N)
%adj = getAdjacency(theta,N)    Extract adjacency matrix from parameter sparsity

adj = zeros(N);

edgeIndex = N+1;
for ii = 1:N-1
  for jj = ii+1:N
    if abs(theta(edgeIndex)) > eps
      adj(ii,jj) = 1;
      adj(jj,ii) = 1;
    end

    edgeIndex = edgeIndex + 1;
  end
end


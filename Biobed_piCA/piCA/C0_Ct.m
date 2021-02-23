function [Ct,C0] = C0_Ct(X,minlag,maxlag,norm_sw)
% Calculate the Ct and C0 matrices in batch using rank-1 updates.

% Save numbers of samples and signals.
[samples,dim] = size(X);

L = maxlag - minlag + 1;
C0 = zeros(dim,dim,L); Ct = zeros(dim,dim,L);

% Compute initial Ct and C0 matrices. Starting at maxlag is faster,
% because there are less samples that way than at minlag.
temp = X(1:(samples-maxlag),:);
C0(:,:,L) = temp'*temp;

temp = X((maxlag+1):samples,:);
Ct(:,:,L) = temp'*temp;

for i = 2:L
    k = L + 1 - i;

    temp = X(samples-maxlag-1+i,:);
    C0(:,:,k) = C0(:,:,k+1) + temp'*temp;

    temp = X(maxlag+1-i,:);
    Ct(:,:,k) = Ct(:,:,k+1) + temp'*temp;
end

if norm_sw
% Scale the Ct and C0 matrices.
    for i = 1:L
        k = 1/(samples-minlag+1-i);
        C0(:,:,i) = k*C0(:,:,i);
        Ct(:,:,i) = k*Ct(:,:,i);
    end
end


end
function [Xw, cm, preprocMatrix] = preproc(X,pre)
% Removes the mean from and performs PCA and/or whitening on the data and
% returns the tranformed data, the mean and the whitening matrix.

%__________________________________________________________________________
% Calculates the number of samples.

[samples,dim] = size(X);

%__________________________________________________________________________

% Return the signal as is, if pre = [0 0 0].
cm = []; preprocMatrix = [];

if ~pre(1) && ~pre(2) && ~pre(3)
    Xw = X;
    return
end

%__________________________________________________________________________
% Removes the mean from the data and saves it.

if pre(1)
    cm = mean(X); 
    X = X - ones(samples,1) * cm;
end

%__________________________________________________________________________
% Performing the whitening of the data (PCA & Sphering).

C = X'*X/samples; C = 0.5*(C + C');
[V,D] = eig_sort(C);

%__________________________________________________________________________
% Since the eigenvalues (and the corresponding eigenvectors) are computed
% and put in with eig_sort ascending order, from minimum to maximum,
% we flip them, because we want the first component calculated to be
% the one with the largest eigenvalue, as per the PCA method.

V = fliplr(V); D = diag(flipud(diag(D)));

%__________________________________________________________________________
% Computes the whitening matrix and the whitened data.

% Checks if whitening is feasible, by looking if the covariance matrix is
% 'broken', i.e. if any of its eigenvalues is negative.
if D(end,end) < 0
    warning(['The smallest eigenvalue of the covariance matrix ',...
        'is negative. The matrix is broken. Whitening is not feasible.'])
    pre(3) = 0;
end

% Performs whitening.
if pre(2) && ~pre(3)
    preprocMatrix = V;
    Xw = X * preprocMatrix;
elseif pre(3)
    e = 0.5*10^(-12);
    if D(end,end) < e
        warning(['The smallest eigenvalue of the covariance matrix ',...
            'is equal to %g, that is, very close to zero.'],D(end,end))
    end
    % Computes diag((1./diag(D)).?(0.5)) instead inv(sqrt(D)),
    % since the eigenvector and eigenvalue matrix are available, thus
    % making it faster than is computed faster than.
    preprocMatrix = V * diag((1./diag(D)).^(0.5));
    Xw = X * preprocMatrix;
else
    Xw = X;
end

end
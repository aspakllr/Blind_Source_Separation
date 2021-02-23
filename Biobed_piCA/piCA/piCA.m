function [o1,o2] = piCA(X,lag,varargin)
% Performs Periodic Component Analysis on the data for all lag values
% in [minlag,maxlag] and returns the resulting transformation matrices
% and the generalized eigenvalues of all the pairs (A[k],C) calculated.
% The cost function that is minimized is:
% e(X,w,k) = E{|s_hat(t+tau) -s_hat(t)|^2}/E{|s_hat(t)|^2}
% = (w'*A[k]*w/w'*C*w)
%
% Input Variables    Description
%__________________________________________________________________________
%
% 'X'                (double) (matrix)
%                    matrix with the signals as its columns.
%
% 'lag'              (integer)
%                    _ if length(lag) == 1, piCA calculates the minimizing
%                    weights and minimum periodicity error for that
%                    lag value.
%                    _ if length(lag) == 2, then piCA does the same for
%                    all lags in [lag(1),lag(2)].
%
% 'xcorr'            (double) (matrix) (optional)
%                    use for when the symmetric cross-correlation
%                    functions are available, to find the results
%                    faster. in this case, you should give the symmetric
%                    cross-correlations for all sample lags, using the
%                    function 'symm_xcorr'.
%
% 'norm'             (scalar) (optional)
%                    decides on whether to normalize the
%                    (cross-)correlation matrices by 1/(samples-lag).
%                    '1' for yes, '0' (default) for no.
%
% 'AMUSE'            (scalar) (optional)
%                    decides on whether to use a simpler version
%                    of piCA (minimization of 2 - s(t+k)'s(t) = 2-2*w'*Ce*w).
%                    generally not a good idea
%                    '1' for yes, '0' (default) for no.
%                    'pre' should be equal to [1 1 1] for meaningful
%                    results.
%
% 'pre'              (3-element array) (optional)
%                    decides on whether to center data, perform PCA
%                    and/or whitening.
%                    pre(1) is for mean centering, pre(2) is for PCA
%                    and pre(3) for whitening.
%                    '1' for yes, '0' for no.
%                    the default for pre is [1 1 1].
%                    for only mean centering, [1 0 0].
%                    for only PCA, [x 1 0].
%                    for whitening, [x x 1].
%                    'x' means that array element doesn't affect the
%                    result.
%                    for no preprocessing, [0 0 0].
%                    any non-zero number other than '1' is ok as well.
%
% 'circ'             (integer) (optional)
%                    decides on whether to assume the dara repeats itself
%                    circularly or not.
%                    '1' for yes, '0' for no (default).
%
%__________________________________________________________________________
%
% Output Variables    Description
%
%__________________________________________________________________________
%
% 'E'                (double) (matrix)
%                    matrix containing the sorted generalized eigenvalues
%                    of all matrix pairs (A[k],C).
%
% 'W'                (double) (matrix)
%                    gives the periodic components of X if multiplied
%                    with it to its left, i.e. X*W has the periodic
%                    components as columns.
%
%__________________________________________________________________________
%
% Examples: - [E,W] = piCA(X,[k1,k2],'pre',[1 1 1],'amuse',1);
%           means 'prewhiten the data, return all errors
%           and tranformation matrices for lags k1 to k2
%           and use only Ce to calculate them.
%
%__________________________________________________________________________
%
% REFERENCES
%
% [1] Lawrence K. Saul and Jont B. Allen,
% 'Periodic Component Analysis: An Eigenvalue Method
% for Representing Periodic Structure in Speech'

%__________________________________________________________________________
% Default values for parameters.

pre = [1 1 1];
Cs = [];
norm_sw = 1;
AMUSE = 0;
circ = 0;

%__________________________________________________________________________
% Read the optional parameters

if (rem(length(varargin),2)==1)
    error('Optional parameters must always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        if ~ischar (varargin{i}),
            error (['Invalid name for optional parameter (parameter',...
                ' names must be strings).']);
        end
        if strcmpi(varargin{i},'xcorr')
            Cs = varargin{i+1};
            if ~ismatrix(Cs)
                error('The cross-correlation must be a matrix.')
            end
        elseif strcmpi(varargin{i},'pre')
            pre = varargin{i+1};
            if length(pre) ~= 3
                error('The preprocessing array must be a 3-element array.')
            end
        elseif strcmpi(varargin{i},'norm')
            norm_sw = varargin{i+1};
            if ~isscalar(norm_sw)
                error('The normalization parameter must be a scalar.')
            end
        elseif strcmpi(varargin{i},'amuse')
            AMUSE = varargin{i+1};
            if ~isscalar(AMUSE)
                error('The ''amuse'' parameter must be a scalar.')
            end
        elseif strcmpi(varargin{i},'circ')
            circ = varargin{i+1};
            if ~isscalar(circ)
                error('The ''circ'' parameter must be a scalar.')
            end
        else
            error(['Invalid name for optional parameter: ''' varargin{i} '''']);
        end
    end
end

%__________________________________________________________________________
% Save numbers of samples and signals.

[samples, dim] = size(X);

%__________________________________________________________________________
% Check if samples are less than the dimensions and give a warning.

if samples <= dim
    warning(['The matrix you have provided has less samples than variables.',...
       'Make sure that this was your intention. ',...
        'Maybe you forgot to traspose it!']);
end

%__________________________________________________________________________
% Check the length of the lag input. If it's equal to 1, then only calculate
% the tranformation matrix and periodicity error for the value inputted.
% Otherwise, calculate them for all values in the range [k(1),k(2)].

if length(lag) == 2
    minlag = lag(1); maxlag = lag(2);
elseif length(lag) ~= 1
    error('The lag argument must have length equal to 1 or 2.nn')
end

%__________________________________________________________________________
% Check for the validity of the value of minlag and maxlag and calculate
% the number of time lags.

if length(lag) == 1
    if (lag <= 0) || (lag >= samples)
        error ('The lag has to be non-negative and less than the number of samples.nn');
    end
elseif length(lag) == 2
    if (maxlag <= 0) || (maxlag >= samples)
        error ('The maximum lag has to be non-negative and less than the number of samples.nn');
    end

    if (minlag <= 0) || (minlag >= samples)
        error ('The minimum lag has to be non-negative and less than the number of samples.nn');
    end
    
    if minlag >= maxlag
        error ('The minimum lag has to be less than the maximum lag.nn');
    end

    % Calculate number of time lags.
    L = maxlag - minlag + 1;
end

%__________________________________________________________________________
% Remove the mean value from the signals, perform PCA/whitening and
% return the whitened signal, the mean values and the whitening matrix.

[X, ~, preprocMatrix] = preproc(X,pre);

%__________________________________________________________________________
% Calculate fast all C0 and Ct matrices (autocorrelation matrices
% at lag = 0, for part of the signals, depends on the value of the lag) and
% also the covariance matrix C, if no prewhitening has occured.
if ~pre(3)
    C = X'*X/samples;

    % Make sure that it is as symmetric as possible.
    C = 0.5*(C+C');
end

% Ct and C0 only computed when not using the circular or AMUSE variants.
if length(lag) == 1
    if circ
        X0 = X; Xt = circshift(X,-k,2);
        if norm_sw, k = 1/samples; end
    else
        X0 = X(1:(samples-lag),:); Xt = X((lag+1):end,:);
        if norm_sw, k = 1/(samples-lag); end
    end
    Ct0 = Xt'*X0;
    if norm_sw, Ct0 = k*Ct0; end
    if ~(circ || AMUSE)
        C0 = X0'*X0; Ct = Xt'*Xt;
        if norm_sw, C0 = k*C0; Ct = k*Ct; end
        C0 = 0.5*(C0+C0'); Ct = 0.5*(Ct+Ct');
    end
elseif length(lag) == 2
    if ~(circ || AMUSE)
        [Ct,C0] = C0_Ct(X,minlag,maxlag,norm_sw);
    end
end

%__________________________________________________________________________
% Compute quickly the Ce matrices, which correspond to the
% symmetric crosscorrelation matrices at every timelag in [minlag,maxlag].

if length(lag) == 1
    Ce = 0.5*(Ct0+Ct0');
elseif length(lag) == 2
    Ce = C_e(X,minlag,maxlag,norm_sw,Cs,circ);
end

%__________________________________________________________________________
% We calculate the matrice A = Ct - (Ct0 + Ct0') = Ct -2*Ce. Adding C0 is not
% necessary.

if length(lag) == 1
    if circ || AMUSE
        A = Ce;
    else
        A = C0 + Ct - 2*Ce;
    end
    A = 0.5*(A+A');
elseif length(lag) == 2
    A = zeros(dim,dim,L);
    for i = 1:L
        if circ || AMUSE
            A(:,:,i) = Ce(:,:,i);
        else
            A(:,:,i) = C0(:,:,i) + Ct(:,:,i) - 2*Ce(:,:,i);
        end
        A(:,:,i) = 0.5*(A(:,:,i) + A(:,:,i)');
    end
end

%__________________________________________________________________________
% Calculate the transformation matrices and the error values.

if length(lag) == 1
    if pre(3)
        [W,e] = eig_sort(A);
    else
        [W,e] = eig_sort(A,C);
    end
    W = preprocMatrix * W;
    if circ || AMUSE
        % In both AMUSE or circular cases, we need to reverse the order,
        % because we have calculated the eigenvalues and eigenvectors of
        % 'Ce' and not 'A'.
        E = 2 - 2*real(diag(e));
        E = fliplr(E);
        W = fliplr(W);
    else
        E = real(diag(e));
    end
elseif length(lag) == 2
    E = zeros(L,dim);
    W = zeros(dim,dim,L);
    for i = 1:L
        % Calculate and sort eigenvalues and eigenvectors.
        if pre(3)
            [W(:,:,i),e] = eig_sort(A(:,:,i));
        else
            [W(:,:,i),e] = eig_sort(A(:,:,i),C);
        end

        % Fix the component weight matrices to work for the original
        % non-PCA'd or whitened data. Doesn't affect the result, because
        % the cost function is invariant w.r.t. the lag when a tranformation
        % of the weight matrix occurs.
        if pre(2) || pre(3)
            W(:,:,i) = preprocMatrix * W(:,:,i);
        end

        if circ || AMUSE
            % In both AMUSE or circular cases, we need to reverse the order,
            % because we have calculated the eigenvalues and eigenvectors of
            % 'Ce' and not 'A'.
            E(i,:) = 2 - 2*real(diag(e)');
            E(i,:) = fliplr(E(i,:));
            W(:,:,i) = fliplr(W(:,:,i));

        else
            E(i,:) = real(diag(e)');
        end
    end
end

%__________________________________________________________________________
% Return the outputs, according to how many there are.
if nargout == 1
    o1 = E;
elseif nargout == 2
    o1 = E;
    o2 = W;
end

end
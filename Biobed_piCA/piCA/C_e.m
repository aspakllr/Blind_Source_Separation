function Ce = C_e(X,minlag,maxlag,norm_sw,Cs,circ)
% Calculate the symmetric part of Ct0, Ce = (Ct0 + Ct0')/2, in batch, by
% using the Fast Fourier Transform.
% Impossibly slow to calculate in the time domain,
% fast in frequency domain, but it necessarily calculates the correlations
% at all possible time lags, before the user chooses which they want.
% Impossible to calculate like C0 and Ct via rank-1 updates.

% Save numbers of samples and signals.
[samples,dim] = size(X);

% Check if samples are less than the dimensions and gives a warning.
if samples <= dim
    warning(['The matrix you have provided has less samples than variables.',...
    'Make sure that this was your intention. ',...
    'Maybe you forgot to traspose it!']);
end

% Check for the validity of the value of minlag and maxlag.
if (maxlag < 0) || (maxlag >= samples)
    error ('The maximum lag has to be non?negative and less than the number of samples.nn');
end

if (minlag < 0) || (minlag >= samples)
    error ('The minimum lag has to be non?negative and less than the number of samples.nn');
end

if minlag > maxlag
    error ('The minimum lag has to be less than or equal to the maximum lag.nn');
end

% Calculate number of time lags.
L = maxlag - minlag + 1;

% Don't use symm xcorr if it has already been provided.
if size(Cs) == 0
    Cs = symm_xcorr(X,norm_sw,circ);
end

% Choose the values that correspond to the chosen minimum and maximum
% time lags.
Cs = Cs(minlag:maxlag,:);

% Create the matrices.
Ce = zeros(dim,dim,L);
k = 0;
for i = 1:dim
    for j = i:dim
        Ce(i,j,:) = Cs(:,(i-1)*dim+j-k);
        if j ~= i
            Ce(j,i,:) = Ce(i,j,:);
        end
    end
    k = k + i;
end

end
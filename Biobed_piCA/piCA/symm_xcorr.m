function Cs = symm_xcorr(X,norm_sw,circ)
% Calculate the symmetric cross?correlations of X.
% The symmetric autocorrelations or cross-correlations
% are taken to mean cs(i,j) = (c(i,j)+c(j,i))/2,
% where c(i,j) is the correlation between the i and j columns of X.
% 'circ' determines if the regular or circular symmetric crosscorrelations
% are calculated.

% Save numbers of samples and signals.
 [samples,dim] = size(X);

%Calculate the symmetric cross-correlations.
if circ
    s_p = samples;
else
    s_p = 2^nextpow2(2*samples-1);
end

% Calculate the DFT of the columns of X.
Xf = fft(X,s_p);
Xfc = conj(Xf);

% Calculate the DFT of the symmetric cross-correlations.
Cs = zeros(s_p,dim*(dim+1)/2);
k = 0;
for i = 1:dim
    for j = i:dim
        Cs(:,(i-1)*dim+j-k) = real(Xf(:,i).*Xfc(:,j));
    end
    k = k + i;
end

% Calculate the cross-correlations through the inverse DFT and force it to
% be real (since the input is assumed to be real, the correlations must
% also be real).
Cs = ifft(Cs);

% Only keep the necessary correlations, from lag = 1 to lag = samples-1.
Cs = Cs(2:samples,:);

if norm_sw
    if circ
        Cs = Cs/samples;
    else
        k = 1./(samples-(1:(samples-1)));
        Cs = Cs.*repmat(k',1,dim*(dim+1)/2);
    end
end


end
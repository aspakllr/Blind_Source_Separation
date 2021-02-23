function p = p_index(A,B)
% Performance index for the matrix P = A*B [S hat = X*B = S*A*B = S*P],
% where A is the mixing matrix and B is its estimate's inverse
% calculated with FastICA or piCA.
% Minimized at 0, only when P is a permutation matrix.

% Taking the absolute value, because the sign can't be determined
% neither by FastICA nor by piCA.
P = abs(A*B);

dim = size(P,1);

% Normalize columns to each one's maximum value.
P_col = P*diag(1./max(P));

% Normalize rows to each one's maximum value.
P_row = diag(1./max(P'))*P;


% Calculate the sum of the elements of both normalized matrices.
on = ones(dim,1);
e = on'*P_col*on + on'*P_row*on;

% The minimum value of e is 2*dim, when the normalized P is a perfect
% permutation matrix.
% Its maximum, on the other hand, value is achieved when the values
% of all elements of P are equal to each other and because those are
% normalized to maximum column and row values, the maximum value is equal
% to 2*dimˆ2.
% So we subtract its minimum value and normalize it to its maximum minus
% its minimum value, so that it takes values in [0,1]. We also make it
% negative and add 1, so that it is 1 when P is a permutation
% matrix and 0 when not at all, so that it actually shows 'closeness' and
% not 'distance' from a permutation matrix, making it more of a performance
% index.
p = 1 - (e - 2*dim)/(2*dim*(dim-1));

end
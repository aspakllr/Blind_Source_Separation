function [o1, o2] = eig_sort(A,B)
% Sorts the eigenvalue and eigenvector matrices in order of the eigenvalue
% with the smallest real part.

if nargout == 2
    switch nargin
        case 1
            [V,D] = eig(A);
        case 2
            [V,D] = eig(A,B);
        otherwise
            error(['There must be 1 or 2 input arguments',...
                'for eig sort to function.'])
    end
    D = diag(D);
elseif (nargout == 0) || (nargout == 1)
    switch nargin
        case 1
            D = eig(A);
        case 2
            D = eig(A,B);
        otherwise
            error(['There must be 1 or 2 input arguments ',...
                'for eig sort to function.'])
    end
else
    error(['There must be at most 2 output arguments '...
    'for eig sort to function.'])
end

D = real(D);
[~,I] = sort(D); 

if nargout == 0
    D(I)
elseif nargout == 1
    o1 = D(I);
elseif nargout == 2
    o1 = V(:,I); 
    o2 = diag(D(I));
end

end
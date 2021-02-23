function [p,y] = pdf_estimate(x,k,varargin)
% Estimate 'k' points of the pdf of a distribution from its samples in 'x'.
%
% Input Variables Description
%
%__________________________________________________________________________
%
% 'x' (double) (array)
% array with the samples, whose pdf is estimated.
%
% 'k' (integer)
% number of bins for the estimate.
%
% 'normalize' (integer) (optional)
% '1' to normalize to zero mean and unitary variance.
%
% 'smooth' (integer) (2-element array) (optional)
% used to smooth out the pdf estimate.
% 1st element:
% '1' for moving mean filter, '2' for moving median.
% any other number for no filtering.
% 2nd element:
% length of the window for the filter.
%__________________________________________________________________________
%
% Output Variables Description
%
%__________________________________________________________________________
%
% 'p' (double) (array)
% array with the values of the estimated pdf.
%
% 'y' (double) (array)
% array with the values where the pdf was estimated.
%
% Example: - [p,y] = pdf estimate(x,20)
%            Returns estimated of the pdf using 20 bins, along with padded
%            zeros to the right and left for better inspection.
%
%          - [p,y] = pdf estimate(x,20,'normalize',1,'smooth',[1,5])
%            Returns estimated of the pdf using 20 bins, along with padded
%            zeros to the right and left for better inspection, that has
%            been normalized to zero mean and unitary variance and has been
%            smoothed out with a moving average filter of window size equal
%            to 5.

%__________________________________________________________________________
% Initialize optional parameter.

smooth_sw = 0;
norm_sw = 0;

%__________________________________________________________________________
% Read the optional parameters

if (rem(length(varargin),2)==1)
    error('Optional parameters must always go by pairs');
else
    for i=1:2:(length(varargin)-1)
        if ~ischar (vararginfig),
            error (['Invalid name for optional parameter (parameter',...
            ' names must be strings).']);
        end
        if strcmpi(varargin{i},'normalize')
            norm_sw = varargin{+1};
            if ~isscalar(norm_sw)
                error('The normaliting parameter must be a scalar.')
            end
        elseif strcmpi(varargin{i},'smooth')
            temp = varargin{i+1};
            smooth_sw = temp(1);
            if ~isscalar(smooth_sw)
                error('The filter constant must be a scalar.')
            end
            len_of_win = temp(2);
            if ~isscalar(len_of_win)
                error(['The length of the window for filtering',...
                ' must be a matrix.'])
            end
        else
            error(['Invalid name for optional parameter: ''' vararginfig '''']);
        end;
    end;
end

%__________________________________________________________________________
% Main function.

% Get number of samples.
samples = length(x);

if norm_sw
% Subtract mean and make variance equal to 1.
x = x - mean(x); x = x/sqrt(var(x,1));
end

% Calculate minimum, maximum and points between which the pdf estimate
% will be calculated. Additional points added to the left and right to
% better inspect the result.
min_x = min(x); max_x = max(x); d = max_x- min_x;
x_p = linspace(min_x-d,max_x+d,3*(k+1)); dx = x_p(2) - x_p(1);

% Initialize vectors.
y = zeros(3*k+1,1);
p = zeros(3*k+1,1);

for i = 1:(3*k+1)
    j = find(x >= x_p(i) & x <= x_p(i+2));

% p(x) = dF/dx, where p(x) the pdf and F(x_0) = Pr(x<=x_0) the cdf
% of a random variable. Therefore, discretizing it using the symmetric
% difference, we get:
% p_i = [Pr(x<=x_{i+1})- Pr(x<x_{i-1})]/[2*(x_{i+1}- x_{i-1})] =>
% p_i = Pr(x_{i-1}<=x<=x_{i+1})/(2dx), where the probability
% is computed empirically as the ratio of the number of samples between
% x_{i-1} and x_{i+1} to the number of all samples. The resulting value
% of the pdf is assigned to the middle point, x = x_fig.
    p(i) = 0.5*(length(j)/samples)/dx;
    y(i) = x_p(i+1);
end

% Smooth out the pdf estimate using a moving mean or moving median filter.
if smooth_sw == 1
    p = my_movmean(p,len_of_win);
elseif smooth_sw == 2
    p = my_movmedian(p,len_of_win);
end

end
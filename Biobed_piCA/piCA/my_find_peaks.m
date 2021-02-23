function [max_val,i_max] = my_find_peaks(X,varargin)
% Finds all local maxima in X that optionally fulfil some criteria
% and returns their values and positions.
%
% Inputs Description
%
%__________________________________________________________________________
%
% 'X' (double) (array)
% input vector, the maxima of which this function finds.
%
% 'min thresh' (double) (scalar) (optional)
% minimum value that the maxima are allowed to take.
%
% 'max thresh' (double) (scalar) (optional)
% maximum value that the maxima are allowed to take.
%
% 'min dis' (integer) (scalar) (optional)
% minimum distance between minima. given in samples.
%
%__________________________________________________________________________
%
% Outputs Description
%
%__________________________________________________________________________
%
% 'max val' (double) (array)
% array with local maxima.
%
% 'i max' (integer) (array)
% array with positions of local maxima.
%
% Example: [max,imax] = my find peaks(X,'thresh',1.10,'min dis',201)
% Finds all local maximum over 1.10 with a minimum distance of
% 201 in samples between them.

%__________________________________________________________________________
% Default values for optional parameters.


min_thresh = -Inf; max_thresh = Inf; min_dis = 0;

%__________________________________________________________________________
% Read the optional parameters.

if rem(length(varargin),2) == 1
    error('Optional parameters must be always pairs.');
else
    for i=1:2:(length(varargin)-1)
        if ~ischar (varargin{i}),
            error (['Invalid name for optional parameter (parameter',...
                ' names must be strings).']);
        end
        if strcmpi(varargin{i},'min thresh')
            min_thresh = varargin{i+1};
            if ~isscalar(min_thresh)
            error('The minimum threshold must be a scalar.')
            end
        elseif strcmpi(varargin{i},'max thresh')
            max_thresh = varargin{i+1};
            if ~isscalar(max_thresh)
                error('The maximum threshold must be a scalar.')
            end
        elseif strcmpi(varargin{i},'min dis')
            min_dis = varargin{i+1};
            if ~isscalar(min_dis) || rem(min_dis,1) ~= 0
                error('The minimum distance must be a scalar and an integer.')
            end
        else
            error(['Invalid name for optional parameter: ''' varargin{i} '''']);
        end;
    end;
end

%__________________________________________________________________________
% Main body of function.

% Get the length of X:
s = length(X);

% Initialize arrays and temporary variables for the local maxima.
max_val = []; i_max = [];
for i = 2:s-1
    % Determine if it's a local maximum.
    if (X(i) >= X(i-1)) && (X(i) >= X(i+1))
    % Determine if it fullfils the thresholding and minumum distance
    % conditions.
        if (X(i) >= min_thresh) && (X(i) <= max_thresh) && ...
        (isempty(i_max) || (i - i_max(end)) >= min_dis)
            max_val = [max_val,X(i)];
            i_max = [i_max,i];
        end
    end
end

end
%% aggregate.m: aggregate values in a matrix
% Author: Kelly Kearney
%
% This repository includes the code for the |aggregate.m| Matlab function,
% along with all dependent functions required to run it. 
%
% This function groups together values of y, based on category values in
% x. It performs more or less like accumaray except it allows x to be any
% value, not just indices, and y can have any number of columns.      
%
%% Getting started
%
% *Prerequisites*
%
% This function requires Matlab R14 or later.
%
% *Downloading and installation*
%
% This code can be downloaded from <https://github.com/kakearney/aggregate-pkg/ Github>
% or the
% <http://www.mathworks.com/matlabcentral/fileexchange/42577-aggregate
% MatlabCentral File Exchange>.  The File Exchange entry is updated daily
% from the GitHub repository.   
%
% *Matlab Search Path*
%
% The following folders need to be added to your Matlab Search path (via
% |addpath|, |pathtool|, etc.):
%
%   aggregate-pkg/aggregate

%% Syntax
%
%  [xcon, yagg, yidxagg] = aggregate(x, y)
%  [xcon, yagg, yidxagg] = aggregate(x, y, fun)
%
% Input variables:
%  
% * |x|:          n x p array, aggregator variable can be either numeric or a
%                 cell array of strings   
% * |y|:          n x m array, values to be grouped
% * |fun|:        function handle. If included, this function is applied to
%                 the grouped values of y 
%  
% Output variables:
%  
% * |xcon|:       unique rows of x
% * |yagg|:       cell array of y values corresponding to each x.
% * |yidxagg|:    row indices of aggregated values

%% Examples
%
% For this example, we'll find the maximum value in each month in the
% following dataset: 

% Sample data

nt = 1000;
t = datenum(2014,6,1) + rand(nt,1)*365; 
dv = datevec(t); 
y = rand(nt,5);

%%
% To aggregate by month using accumarray, you first need to translate the
% unique months to grouping indices, then repeat the accumulation
% calculation independently for each column of y.  You also need to specify
% the output size, and add a function to get all values rather than an
% average:

tic;
[unqdv1,~,idx] = unique(dv(:,1:2), 'rows');
nmonth = size(unqdv1,1);
ncol = size(y,2);
ymonthly1 = zeros(nmonth,ncol);
for ii = 1:ncol
    ymonthly1(:,ii) = accumarray(idx, y(:,ii), [nmonth 1], @(x) max(x,[],1));
end
toc

unqdv1
ymonthly1

%%
% The aggregate function simplifies the syntax by removing the need for the
% aggregator (the first input to either |accumarray| or |aggregate|) to be
% positive integers.  It also performs the aggregations on all columns of y
% at once, both simplifying syntax and speeding up the calculation
% (relative to looping and repeating accumarray, as above).   

tic;
[unqdv2, ymonthly2] = aggregate(dv(:,1:2), y, @(x) max(x,[],1));
ymonthly2 = cat(1, ymonthly2{:});
toc

unqdv2
ymonthly2

%% Contributions
%
% Community contributions to this package are welcome!
% 
% To report bugs, please submit an
% <https://github.com/kakearney/aggregate-pkg/issues issue> on GitHub and
% include:  
% 
% * your operating system
% * your version of Matlab and all relevant toolboxes (type |ver| at the
%   Matlab command line to get this info)   
% * code/data to reproduce the error or buggy behavior, and the full text
%   of any error messages received  
% 
% Please also feel free to submit enhancement requests, or to send pull
% requests (via GitHub) for bug fixes or new features. 
% 
% I do monitor the MatlabCentral FileExchange entry for any issues raised
% in the comments, but would prefer to track issues on GitHub. 
% 

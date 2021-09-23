
# aggregate.m: aggregate values in a matrix


Author: Kelly Kearney
[![View aggregate on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/42577-aggregate)

This repository includes the code for the `aggregate.m` Matlab function, along with all dependent functions required to run it.


This function groups together values of y, based on category values in x. It performs more or less like accumaray except it allows x to be any value, not just indices, and y can have any number of columns.



## Contents

            
- Getting started        
- Syntax        
- Examples        
- Contributions

## Getting started


**Prerequisites**


This function requires Matlab R14 or later.


**Downloading and installation**


This code can be downloaded from [Github](https://github.com/kakearney/aggregate-pkg/) or the [MatlabCentral File Exchange](http://www.mathworks.com/matlabcentral/fileexchange/42577-aggregate).  The File Exchange entry is updated daily from the GitHub repository.


**Matlab Search Path**


The following folders need to be added to your Matlab Search path (via `addpath`, `pathtool`, etc.):



```matlab
aggregate-pkg/aggregate
```



## Syntax



```
[xcon, yagg, yidxagg] = aggregate(x, y)
[xcon, yagg, yidxagg] = aggregate(x, y, fun)
```


Input variables:



  - `x`:          n x p array, aggregator variable can be either numeric or a                 cell array of strings
  - `y`:          n x m array, values to be grouped
  - `fun`:        function handle. If included, this function is applied to                 the grouped values of y

Output variables:



  - `xcon`:       unique rows of x
  - `yagg`:       cell array of y values corresponding to each x.
  - `yidxagg`:    row indices of aggregated values


## Examples


For this example, we'll find the maximum value in each month in the following dataset:



```matlab
% Sample data

nt = 1000;
t = datenum(2014,6,1) + rand(nt,1)*365;
dv = datevec(t);
y = rand(nt,5);
```


To aggregate by month using accumarray, you first need to translate the unique months to grouping indices, then repeat the accumulation calculation independently for each column of y.  You also need to specify the output size, and add a function to get all values rather than an average:



```matlab
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
```




```
Elapsed time is 0.004897 seconds.

unqdv1 =

        2014           6
        2014           7
        2014           8
        2014           9
        2014          10
        2014          11
        2014          12
        2015           1
        2015           2
        2015           3
        2015           4
        2015           5


ymonthly1 =

    0.9986    0.9872    0.9641    0.9915    0.9993
    0.9906    0.9929    0.9505    0.9814    0.9939
    0.9655    0.9869    0.9860    0.9986    0.9955
    0.9945    0.9969    0.9973    0.9978    0.9938
    0.9999    0.9694    0.9988    0.9950    0.9935
    0.9853    0.9851    0.9950    0.9620    0.9967
    0.9940    0.9977    0.9976    0.9894    0.9848
    0.9909    0.9819    0.9948    0.9900    0.9658
    0.9926    0.9935    0.9942    1.0000    0.9691
    0.9944    0.9988    0.9996    0.9912    0.9953
    0.9958    0.9819    0.9789    0.9954    0.9959
    0.9767    0.9847    0.9738    0.9961    0.9883


```


The aggregate function simplifies the syntax by removing the need for the aggregator (the first input to either `accumarray` or `aggregate`) to be positive integers.  It also performs the aggregations on all columns of y at once, both simplifying syntax and speeding up the calculation (relative to looping and repeating accumarray, as above).



```matlab
tic;
[unqdv2, ymonthly2] = aggregate(dv(:,1:2), y, @(x) max(x,[],1));
ymonthly2 = cat(1, ymonthly2{:});
toc

unqdv2
ymonthly2
```




```
Elapsed time is 0.003516 seconds.

unqdv2 =

        2014           6
        2014           7
        2014           8
        2014           9
        2014          10
        2014          11
        2014          12
        2015           1
        2015           2
        2015           3
        2015           4
        2015           5


ymonthly2 =

    0.9986    0.9872    0.9641    0.9915    0.9993
    0.9906    0.9929    0.9505    0.9814    0.9939
    0.9655    0.9869    0.9860    0.9986    0.9955
    0.9945    0.9969    0.9973    0.9978    0.9938
    0.9999    0.9694    0.9988    0.9950    0.9935
    0.9853    0.9851    0.9950    0.9620    0.9967
    0.9940    0.9977    0.9976    0.9894    0.9848
    0.9909    0.9819    0.9948    0.9900    0.9658
    0.9926    0.9935    0.9942    1.0000    0.9691
    0.9944    0.9988    0.9996    0.9912    0.9953
    0.9958    0.9819    0.9789    0.9954    0.9959
    0.9767    0.9847    0.9738    0.9961    0.9883


```



## Contributions


Community contributions to this package are welcome!


To report bugs, please submit an [issue](https://github.com/kakearney/aggregate-pkg/issues) on GitHub and include:



  - your operating system
  - your version of Matlab and all relevant toolboxes (type `ver` at the   Matlab command line to get this info)
  - code/data to reproduce the error or buggy behavior, and the full text   of any error messages received

Please also feel free to submit enhancement requests, or to send pull requests (via GitHub) for bug fixes or new features.


I do monitor the MatlabCentral FileExchange entry for any issues raised in the comments, but would prefer to track issues on GitHub.



<sub>[Published with MATLAB R2016a]("http://www.mathworks.com/products/matlab/")</sub>
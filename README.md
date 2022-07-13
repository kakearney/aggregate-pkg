
# aggregate.m: aggregate values in a matrix


Author: Kelly Kearney


This repository includes the code for the `aggregate.m` and `aggregatehist.m` Matlab functions, along with all dependent functions required to run them.


This function groups together values of y, based on category values in x. It performs more or less like accumaray and the newer splitapply functions but with more flexible options for the grouping variable.



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
Elapsed time is 0.004129 seconds.

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

       0.9828      0.99894      0.99039      0.99836      0.99153
      0.97251      0.98854      0.99534      0.99817      0.99373
      0.99326      0.98096      0.99718      0.97635      0.99907
      0.98464      0.99274      0.99434      0.99898      0.98916
      0.99374      0.98904      0.99184      0.98563       0.9946
      0.96326      0.94601      0.99774      0.98785       0.9928
      0.98269      0.98128      0.96038      0.99827      0.97032
      0.99108      0.99053      0.99389      0.99406      0.99808
      0.98049      0.97057      0.99275      0.97529       0.9952
      0.98287      0.97395      0.99563      0.99642      0.98981
      0.99646      0.99582      0.99945      0.96349      0.99475
      0.97861      0.98167      0.99644       0.9871      0.98205


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
Elapsed time is 0.002709 seconds.

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

       0.9828      0.99894      0.99039      0.99836      0.99153
      0.97251      0.98854      0.99534      0.99817      0.99373
      0.99326      0.98096      0.99718      0.97635      0.99907
      0.98464      0.99274      0.99434      0.99898      0.98916
      0.99374      0.98904      0.99184      0.98563       0.9946
      0.96326      0.94601      0.99774      0.98785       0.9928
      0.98269      0.98128      0.96038      0.99827      0.97032
      0.99108      0.99053      0.99389      0.99406      0.99808
      0.98049      0.97057      0.99275      0.97529       0.9952
      0.98287      0.97395      0.99563      0.99642      0.98981
      0.99646      0.99582      0.99945      0.96349      0.99475
      0.97861      0.98167      0.99644       0.9871      0.98205


```



## Contributions


Community contributions to this package are welcome!


To report bugs, please submit an [issue](https://github.com/kakearney/aggregate-pkg/issues) on GitHub and include:



  - your operating system
  - your version of Matlab and all relevant toolboxes (type `ver` at the   Matlab command line to get this info)
  - code/data to reproduce the error or buggy behavior, and the full text   of any error messages received

Please also feel free to submit enhancement requests, or to send pull requests (via GitHub) for bug fixes or new features.


I do monitor the MatlabCentral FileExchange entry for any issues raised in the comments, but would prefer to track issues on GitHub.



<sub>[Published with MATLAB R2019a]("http://www.mathworks.com/products/matlab/")</sub>
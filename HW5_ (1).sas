*SAS code for HW5 - Problem 8.4*;
data prob4;
input group $ life status ;
if group = "1" then trt = "Untreated";
else trt = "Treated";
if group = "2" then Z1 = 1;
else Z1 = 0;
if group = "3" then Z2 = 1;
else Z2 = 0;
datalines;
1 20 1
1 21 1
1 23 1
1 24 1
1 24 1
1 26 1
1 26 1
1 27 1
1 28 1
1 30 1
2 26 1
2 28 1
2 29 1
2 29 1
2 30 1
2 30 1
2 31 1
2 31 1
2 32 1
2 35 0
3 31 1
3 32 1
3 34 1
3 35 1
3 36 1
3 38 1
3 38 1
3 39 1
3 42 0
3 42 0
;
*checking that the data are in the right places;
proc freq data = prob4;
table trt*group;
table Z1*group;
table Z2*group;
run;

*Getting the coefficient estimates and testing whether beta1 = beta2 *;
proc phreg data = prob4;
model life*status(0) = Z1 Z2/ ties = efron covb;
test Z1 = Z2;
run;

*Testing whether radiation (either radiation alone or radiation + BPA, trt = 1) has a different survival
* than the untreated (trt = 0);

proc phreg data = prob4;
class trt;
model life*status(0) = trt / ties=efron;
run;

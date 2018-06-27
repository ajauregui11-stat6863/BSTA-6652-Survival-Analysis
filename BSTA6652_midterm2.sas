proc import datafile="C:\Users\Adam\Downloads\valung.csv"
     out=valung
     dbms=csv
     replace;
     getnames=ys;
run;

proc print data=valung;
run;
/*test whether there is a difference between the treatments*/
PROC LIFETEST data=valung method=km plots=s(test);
	time time*status(0);
	strata trt;
run;
/*test to see if there is a difference in death rates between the treatments using a stratified test stratifying by cell type*/
PROC LIFETEST data=valung method=km plots=s;
	time time*status(0);
	strata cell / group=trt;
run;
/*derive estimates of the mean and median survival times for the adeno cell type patients on standard treatment*/
/*provide both point estimates and confidence intervals (SAS will give standard error, use eqtn 4.5.2 in textbook for mean CI*/
PROC SORT data=valung;
by cell;
run;

PROC PRINT data=valung;
run;

PROC LIFETEST data=valung timelim=observed method=km plots=s(test);
	by cell;
	time time*status(0);
	strata trt;
run;

/*fit the cox proportional hazards model with all the covariats. use efron method for ties*/
PROC PHREG data=valung;
class cell prior (ref="no") trt (ref="0");
model time*status(0) = trt cell kps diag age prior / ties=efron;
run;

/*using backwards selection fit the Cox proportional hazards model.*/
PROC PHREG data=valung;
class cell prior (ref="no") trt (ref="0");
model time*status(0) = trt cell kps diag age prior / selection=backwards slstay=.15;
run;

/*full model*/
PROC PHREG data=valung;
class trt (ref="0") cell;
model time*status(0) = trt cell kps / ties=efron covb;
run;

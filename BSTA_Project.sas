data projectdata;
set projectdata (rename= 
(Dsex = Acute
Wait = Chronic
Var6 = Page
Var7 = DAge
Var8 = PSex
Var9 = DSex
Var10 = Wait));
run;

data projectdata;
set projectdata;
if acute=0 & chronic=0 then Z10=1;
if acute =1 & chronic=0 then Z10 = 2;
if acute = 0 & chronic=1 then Z10=3;
if acute = 1 & chronic=1 then Z10=4;
run;

data gvhd1;
set projectdata;
if Z2 = 1 | Z3 = 1 | Z4=1 then delete;
;

data gvhd2;
set projectdata;
if Z3 = 1 | Z4 = 1 then delete;
;

data gvhd3;
set projectdata;
if Z2 = 1 | Z4 = 1 then delete;
;

data gvhd4;
set projectdata;
if Z2 = 1 | Z3 = 1 then delete;
;
 

/*modeling survival with PARAMETRIC method*/
/* checking for the distribution of Y ignoring the covariates */

proc lifetest data=projectdata outsurv=a;
   time time*status(0);
run;

data b;
   set a;
   s=survival;
   logneglog=log(-log(s)); /* checking for weibull distribution */
   neglog=(-log(s)); /* checking for exponential distribution */
   lnorm=probit(1-s); /* probit: inverse function of cdf of N(0,1); for lognormal distribution */
   ltime=log(time);
run;

proc gplot data=b;
	symbol1 value=none i=join;
	plot logneglog*ltime lnorm*ltime neglog*time;
run;

/* AFT model fitting */
proc lifereg data=projectdata;
   class group;
   model time*status(0)=group page dage psex dsex wait z2 z3 z4
         / dist=gamma; /* generalized gamma distribution */
	PROBPLOT;
run;

proc lifereg data=projectdata;
   class group;
   model time*status(0)=group page dage psex dsex wait z2 z3 z4
         / dist=lnormal; /* log-normal */
	PROBPLOT;
run;

proc lifereg data=projectdata;
   class group;
   model time*status(0)=group page dage psex dsex wait z2 z3 z4
         / dist=llogistic; /* log-logistic */
PROBPLOT;
run;

proc lifereg data=projectdata;
   class group;
   model time*status(0)=group page dage psex dsex wait z2 z3 z4
         /dist=weibull; /* weibull */
PROBPLOT;
run;

proc lifereg data=projectdata;
   class group;
   model time*status(0)=group page dage psex dsex wait z2 z3 z4
         /dist=exp; /* exponential */
PROBPLOT;
run;
/* From the results, the gamma appears to be the best one.*/

/*modeling survival with SEMIPARAMETRIC model.*/
PROC PHREG data=projectdata;
class group (ref="1") psex (ref="0") dsex (ref="0");
model time*status(0) = group page dage psex dsex wait z2 z3 z4
/ ties=efron selection=backwards slstay=.15;
run;
proc phreg data = prob4;
model life*status(0) = Z1 Z2/ ties = efron covb;
test Z1 = Z2;
run;
/*reduced model*/
PROC PHREG data=projectdata;
class group (ref="1") chronic (ref="0");
model time*status(0) = group wait z3 z4; 
/ ties=efron;
run;


/* modeling survival with NONPARAMETRIC model.*/

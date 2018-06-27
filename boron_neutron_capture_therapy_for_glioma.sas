/* #7.7: A study was performed to determine the efficacy of boron neutron capture therapy (BNCT) in treating the therapeutically refractory F98 glioma, using boronophenylalanine (BPA) as the capture agent. F98 glioma cells were implanted into the brains of rats. Three groups of rats were studied. One group went untreated, another was treated only with radiation, and the third group received radiation plus an appropriate concentration of BPA. The data for the three groups lists the death times (in days) and is given below:*/
data BNCT;
input treatment $ days status;
if treatment='1' then treatment='untreated';
if treatment='2' then treatment='radiated';
if treatment='3' then treatment='rad_BPA';
if treatment='radiated' then Z2=1;
else Z2=0;
if treatment='rad_BPA' then Z3=1;
else Z3=0;
cards;
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

/* (a) Compare the survival curves for the three groups */
/* (b) Perform pairwise tests to determine if there is any difference in survival between pairs of groups*/
PROC LIFETEST data=BNCT method=km plots=s(test);
	time days*status(0);
	strata treatment;
run;
PROC LIFETEST data=BNCT timelim = observed  method=km plots=s(test);
	time days*status(0);
	strata treatment / adjust=bon; /*tukey pairwise tests bonferonni adjusted*/
run;
/* 8.4. Refer to problem 7.7*/

proc phreg data = bnct;
class treatment (ref='untreate');
model days*status(0) = treatment / ties = breslow type3(all); /* global hypothesis*/
/*type3(all) gives p-value of all 3 tests*/
test treatmentradiated=treatmentrad_BPA; /*radiated animal vs radiated + BPA animal*/
hazardratio 'H1' treatment / diff=all cl=both; /*95%CI for the relative risk of death between groups*/
run;

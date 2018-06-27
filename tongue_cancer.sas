ODS PDF;
/* #7.4: In section 1.11, data from a study of the effect 
of ploidy on survival patients with tumors of the tongue 
was reported.*/
/*Data on 80 males diagnosed with cancer of the tongue
See Section 1.11
Data can be read in free format. The variables represented 
in the dataset are as follows: 

Tumor DNA profile (1=Aneuploid Tumor, 2=Diploid Tumor) 
Time to death or on-study time, weeks 
Death indicator (0=alive, 1=dead) 
Reference Sickle-Santanello et al. Cytometry 9 (1988): 594-599.*/

Data tonguetumors;
input tumor $ weeks death;
if tumor='1' then tumor='Aneuploid Tumor';
else tumor='Diploid Tumor';
cards;
1 1 1
1 3 1
1 3 1
1 4 1
1 10 1
1 13 1
1 13 1
1 16 1
1 16 1
1 24 1
1 26 1
1 27 1
1 28 1
1 30 1
1 30 1
1 32 1
1 41 1
1 51 1
1 65 1
1 67 1
1 70 1
1 72 1
1 73 1
1 77 1
1 91 1
1 93 1
1 96 1
1 100 1
1 104 1
1 157 1
1 167 1
1 61 0
1 74 0
1 79 0
1 80 0
1 81 0
1 87 0
1 87 0
1 88 0
1 89 0
1 93 0
1 97 0
1 101 0
1 104 0
1 108 0
1 109 0
1 120 0
1 131 0
1 150 0
1 231 0
1 240 0
1 400 0
2 1 1
2 3 1
2 4 1
2 5 1
2 5 1
2 8 1
2 12 1
2 13 1
2 18 1
2 23 1
2 26 1
2 27 1
2 30 1
2 42 1
2 56 1
2 62 1
2 69 1
2 104 1
2 104 1
2 112 1
2 129 1
2 181 1
2 8 0
2 67 0
2 76 0
2 104 0
2 176 0
2 231 0
;
ODS GRAPHICS ON;
/*(a) Test the hypothesis that the survival rates of patients 
with cancer of the tongue are the same for patients with aneuploid 
and diploid tumors using the log-rank test.*/
/* Solution: Look at the p-value for the log-rank test.*/
PROC lifetest data=tonguetumors method=km plots=s(test);
	TIME weeks*death(0);
	STRATA tumor;
run;
ODS PDF CLOSE;

/*(b) If primary interest is in detecting differences in survival 
rates between the two types of cancers which occur soon after the 
diagnosis of the cancer, repeat part a using a more appropriate statistic.*/
/* Solution: Look at the p-value for the Wilcoxon test.*/
proc phreg data = tonguetumors;
class tumor;
model weeks*death(0) = tumor / ties = efron;
output out =Devres resdev = Dres xbeta = xb;
run;
proc gplot data = Devres;
plot Dres*xb;
run;

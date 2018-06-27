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
PROC lifetest data=tonguetumors method=km;
	TIME weeks*death(0);
	STRATA tumor;
run;

/*(b) If primary interest is in detecting differences in survival 
rates between the two types of cancers which occur soon after the 
diagnosis of the cancer, repeat part a using a more appropriate statistic.*/
/* Solution: Look at the p-value for the Wilcoxon test.*/

/* #7.5: Using the data on laryngeal cancers in Example 7.6, test, 
by the log-rank statistic, the null hypothesis of no difference 
in death rates among the four stages of cancer against the global 
alternative that at least one of the death rates differs from 
the others. Compare your results to those found in Example 7.6.
Data on 90 males with larynx cancer
See Section 1.8
Data can be read in free format. The variables represented in 
the dataset are as follows: 

Stage of disease (1=stage 1, 2=stage2, 3=stage 3, 4=stage 4) 
Time to death or on-study time, months 
Age at diagnosis of larynx cancer 
Year of diagnosis of larynx cancer 
Death indicator (0=alive, 1=dead) 
Reference: Kardaun Stat. Nederlandica 37 (1983), 103-126.*/

data laryngeal_cancer;
input stage$ months age year$ death period$;
if year<='75' then period='1';
if year>='75' then period='2';
cards;
1 0.6 77 76 1
1 1.3 53 71 1
1 2.4 45 71 1
1 2.5 57 78 0
1 3.2 58 74 1
1 3.2 51 77 0
1 3.3 76 74 1
1 3.3 63 77 0
1 3.5 43 71 1
1 3.5 60 73 1
1 4 52 71 1
1 4 63 76 1
1 4.3 86 74 1
1 4.5 48 76 0
1 4.5 68 76 0
1 5.3 81 72 1
1 5.5 70 75 0
1 5.9 58 75 0
1 5.9 47 75 0
1 6 75 73 1
1 6.1 77 75 0
1 6.2 64 75 0
1 6.4 77 72 1
1 6.5 67 70 1
1 6.5 79 74 0
1 6.7 61 74 0
1 7 66 74 0
1 7.4 68 71 1
1 7.4 73 73 0
1 8.1 56 73 0
1 8.1 73 73 0
1 9.6 58 71 0
1 10.7 68 70 0
2 0.2 86 74 1
2 1.8 64 77 1
2 2 63 75 1
2 2.2 71 78 0
2 2.6 67 78 0
2 3.3 51 77 0
2 3.6 70 77 1
2 3.6 72 77 0
2 4 81 71 1
2 4.3 47 76 0
2 4.3 64 76 0
2 5 66 76 0
2 6.2 74 72 1
2 7 62 73 1
2 7.5 50 73 0
2 7.6 53 73 0
2 9.3 61 71 0
3 0.3 49 72 1
3 0.3 71 76 1
3 0.5 57 74 1
3 0.7 79 77 1
3 0.8 82 74 1
3 1 49 76 1
3 1.3 60 76 1
3 1.6 64 72 1
3 1.8 74 71 1
3 1.9 72 74 1
3 1.9 53 74 1
3 3.2 54 75 1
3 3.5 81 74 1
3 3.7 52 77 0
3 4.5 66 76 0
3 4.8 54 76 0
3 4.8 63 76 0
3 5 59 73 1
3 5 49 76 0
3 5.1 69 76 0
3 6.3 70 72 1
3 6.4 65 72 1
3 6.5 65 74 0
3 7.8 68 72 1
3 8 78 73 0
3 9.3 69 71 0
3 10.1 51 71 0
4 0.1 65 72 1
4 0.3 71 76 1
4 0.4 76 77 1
4 0.8 65 76 1
4 0.8 78 77 1
4 1 41 77 1
4 1.5 68 73 1
4 2 69 76 1
4 2.3 62 71 1
4 2.9 74 78 0
4 3.6 71 75 1
4 3.8 84 74 1
4 4.3 48 76 0
;

PROC LIFETEST data=laryngeal_cancer method=km;
	time months*death(0);
	strata stage;
run;
/* #7.7: A study was performed to determine the efficacy of boron neutron capture therapy (BNCT) in treating the therapeutically refractory F98 glioma, using boronophenylalanine (BPA) as the capture agent. F98 glioma cells were implanted into the brains of rats. Three groups of rats were studied. One group went untreated, another was treated only with radiation, and the third group received radiation plus an appropriate concentration of BPA. The data for the three groups lists the death times (in days) and is given below:*/
data BNCT;
input treatment $ days status;
if treatment='1' then treatment='untreated';
if treatment='2' then treatment='radiated';
if treatment='3' then treatment='rad + BPA';
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
PROC LIFETEST data=BNCT method=km;
	time days*status(0);
	strata treatment / adjust=bon; /*tukey pairwise tests bonferonni adjusted*/
run;

/*#7.11 The data on laryngeal cancer patients was collected over 
the period 1970-1978. It is possible that the therapy used to 
treat laryngeal cancer may have changed over this nine year period. 
To adjust for this possible confounding fact, test the hypothesis 
of no difference in survival between patients with different 
stages of disease against a global alternative using a test which 
stratifies on the cancer being diagnosed prior to 1975 or not. 
Also perform a separate test of the hypothesis of interest in 
each stratum. */
proc sort data=laryngeal_cancer out=lary_cancer_sorted;
	by period;
run; 

PROC LIFETEST data=lary_cancer_sorted method=km;
	by period;
	time months*death(0);
	strata stage / adjust=bon;
run;
ODS PDF CLOSE;

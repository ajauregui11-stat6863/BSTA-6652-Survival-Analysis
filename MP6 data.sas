*** Survival Analysis:6-MP data;
* These are the data for the 6-MP data set used in K&M;
data leukemia;
input weeks status drug $;
if drug='1' then drug='6-MP';
else drug='placebo';
datalines;
6 0 1
6 1 1
6 1 1
6 1 1
7 1 1
9 0 1
10 0 1
10 1 1
11 0 1
13 1 1
16 1 1
17 0 1
19 0 1
20 0 1
22 1 1
23 1 1
25 0 1
32 0 1
32 0 1
34 0 1
35 0 1
1 1 0
1 1 0
2 1 0
2 1 0
3 1 0
4 1 0
4 1 0
5 1 0
5 1 0
8 1 0
8 1 0
8 1 0
8 1 0
11 1 0
11 1 0
12 1 0
12 1 0
15 1 0
17 1 0
22 1 0
23 1 0
;
proc lifetest data=leukemia method=km;
time weeks*status(0);
strata drug;
run;

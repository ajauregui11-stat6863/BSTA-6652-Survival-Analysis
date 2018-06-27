data kidney;
input id $ months catheter $ status;
datalines;
1 1.5 S 1
2 3.5 S 1
3 4.5 S 1
4 4.5 S 1
5 5.5 S 1
6 8.5 S 1
7 8.5 S 1
8 9.5 S 1
9 10.5 S 1
10 11.5 S 1
11 15.5 S 1
12 16.5 S 1
13 18.5 S 1
14 23.5 S 1
15 26.5 S 1
16 2.5 S 0
17 2.5 S 0
18 3.5 S 0
19 3.5 S 0
20 3.5 S 0
21 4.5 S 0
22 5.5 S 0
23 6.5 S 0
24 6.5 S 0
25 7.5 S 0
26 7.5 S 0
27 7.5 S 0
28 7.5 S 0
29 8.5 S 0
30 9.5 S 0
31 10.5 S 0
32 11.5 S 0
33 12.5 S 0
34 12.5 S 0
35 13.5 S 0
36 14.5 S 0
37 14.5 S 0
38 21.5 S 0
39 21.5 S 0
40 22.5 S 0
41 22.5 S 0
42 25.5 S 0
43 27.5 S 0
44 .5 P 1
45 .5 P 1
46 .5 P 1
47 .5 P 1
48 .5 P 1
49 .5 P 1
50 2.5 P 1
51 2.5 P 1
52 3.5 P 1
53 6.5 P 1
54 15.5 P 1
55 .5 P 0
56 .5 P 0
57 .5 P 0
58 .5 P 0
59 .5 P 0
60 .5 P 0
61 .5 P 0
62 .5 P 0
63 .5 P 0
64 .5 P 0
65 1.5 P 0
66 1.5 P 0
67 1.5 P 0
68 1.5 P 0
69 2.5 P 0
70 2.5 P 0
71 2.5 P 0
72 2.5 P 0
73 2.5 P 0
74 3.5 P 0
75 3.5 P 0
76 3.5 P 0
77 3.5 P 0
78 3.5 P 0
79 4.5 P 0
80 4.5 P 0
81 4.5 P 0
82 5.5 P 0
83 5.5 P 0
84 5.5 P 0
85 5.5 P 0
86 5.5 P 0
87 6.5 P 0
88 7.5 P 0
89 7.5 P 0
90 7.5 P 0
91 8.5 P 0
92 8.5 P 0
93 8.5 P 0
94 9.5 P 0
95 9.5 P 0
96 10.5 P 0
97 10.5 P 0
98 10.5 P 0
99 11.5 P 0
100 11.5 P 0
101 12.5 P 0
102 12.5 P 0
103 12.5 P 0
104 12.5 P 0
105 14.5 P 0
106 14.5 P 0
107 16.5 P 0
108 16.5 P 0
109 18.5 P 0
110 19.5 P 0
111 19.5 P 0
112 19.5 P 0
113 20.5 P 0
114 22.5 P 0
115 24.5 P 0
116 25.5 P 0
117 26.5 P 0
118 26.5 P 0
119 26.5 P 0
;
proc lifetest data=kidney method=km nelson plots=survival(cl) /* 'nelson' produces cumulative hazard function*/
	plots=(s,ls) graphics outsurv=a;
	time months*status(0);
	strata catheter;
	symbol1 v=none color=black line=1;
	symbol2 v=none color=black line=2;
run;
proc lifetest data=kidney method=life plots=survival(cl) /* 'life' gives the hazard rate */
	plots=(s,ls,h) graphics;
	time months*status(0);
	strata catheter;
	symbol1 v=none color=black line=1;
	symbol2 v=none color=black line=2;
run;

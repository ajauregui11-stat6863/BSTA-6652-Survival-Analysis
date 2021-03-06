data HIV;
input id $ indate $ outdate$ months age ivdrug status;
datalines;
        1   15may90   14oct90          5         46          0          1
        2   19sep89   20mar90          6         35          1          0
        3   21apr91   20dec91          8         30          1          1
        4   03jan91   04apr91          3         30          1          1
        5   18sep89   19jul91         22         36          0          1
        6   18mar91   17apr91          1         32          1          0
        7   11nov89   11jun90          7         36          1          1
        8   25nov89   25aug90          9         31          1          1
        9   11feb91   13may91          3         48          0          1
       10   11aug89   11aug90         12         47          0          1
       11   11apr90   10jun90          2         28          1          0
       12   11may91   10may92         12         34          0          1
       13   17jan89   16feb89          1         44          1          1
       14   16feb91   17may92         15         32          1          1
       15   09apr91   06feb94         34         36          0          1
       16   09mar91   08apr91          1         36          0          1
       17   03aug90   02dec90          4         54          0          1
       18   10jun90   08jan92         19         35          0          0
       19   12jun91   11sep91          3         44          1          0
       20   07jan91   08mar91          2         38          0          1
       21   29aug89   28oct89          2         40          0          0
       22   29may89   27nov89          6         34          1          1
       23   16nov90   14nov95         60         25          0          0
       24   09may90   08apr91         11         32          0          1
       25   10sep91   09nov91          2         42          1          0
       26   26dec91   26may92          5         47          0          1
       27   29may91   27sep91          4         30          0          0
       28   01may90   31may90          1         47          1          1
       29   24mar91   22apr92         13         41          0          1
       30   18jul89   17oct89          3         40          1          1
       31   16sep90   15nov90          2         43          0          1
       32   22jun89   22jul89          1         41          0          1
       33   27apr90   25oct92         30         30          0          1
       34   16may90   14dec90          7         37          0          1
       35   19feb89   20jun89          4         42          1          1
       36   17feb90   18oct90          8         31          1          1
       37   06aug91   05jan92          5         39          1          1
       38   10aug89   10jun90         10         32          0          1
       39   27dec90   25feb91          2         51          0          1
       40   26apr89   24jan90          9         36          0          1
       41   04dec90   03dec93         36         43          0          1
       42   28apr91   28jul91          3         39          0          1
       43   09jul91   07apr92          9         33          0          1
       44   31dec89   01apr90          3         45          1          1
       45   20dec89   18nov92         35         33          0          1
       46   22jun91   20feb92          8         28          0          1
       47   11apr90   11mar91         11         31          0          1
       48   22may90   19jan95         56         20          1          0
       49   11nov91   10jan92          2         44          0          0
       50   18jan91   19apr91          3         39          1          1
       51   11nov89   10feb91         15         33          0          1
       52   01oct90   31oct90          1         31          0          1
       53   20mar90   18jan91         10         33          0          1
       54   30jul90   29aug90          1         50          1          1
       55   17jul89   14feb90          7         36          1          1
       56   10nov90   09feb91          3         30          1          1
       57   05mar89   04jun89          3         42          1          1
       58   02mar91   01may91          2         32          1          1
       59   11sep89   11may92         32         34          0          1
       60   12sep89   12dec89          3         38          1          1
       61   08apr90   06feb91         10         33          0          0
       62   20apr89   20mar90         11         39          1          1
       63   31jan91   02may91          3         39          1          1
       64   15sep89   15apr90          7         33          1          1
       65   07dec91   07may92          5         34          1          1
       66   04mar90   01oct92         31         34          0          1
       67   20apr89   19sep89          5         46          1          1
       68   16jun89   15apr94         58         22          0          1
       69   01oct90   31oct90          1         44          1          1
       70   01feb91   03may91          3         37          0          0
       71   13may89   10dec92         43         25          0          1
       72   09aug90   08sep90          1         38          0          1
       73   18dec91   17jun92          6         32          0          1
       74   23aug90   21jan95         53         34          0          1
       75   19jan91   19mar92         14         29          0          1
       76   26aug91   25dec91          4         36          1          1
       77   16may91   13nov95         54         21          0          1
       78   20mar89   19apr89          1         26          1          1
       79   05oct91   04nov91          1         32          1          1
       80   21may91   19jan92          8         42          0          1
       81   10jun91   09nov91          5         40          1          1
       82   31aug89   30sep89          1         37          1          1
       83   28dec91   27jan92          1         47          0          1
       84   29sep90   28nov90          2         32          1          1
       85   20nov91   19jun92          7         41          1          0
       86   02jul89   01aug89          1         46          1          0
       87   11oct91   10aug92         10         26          1          1
       88   11oct90   10oct92         24         30          0          0
       89   05dec90   05jul91          7         32          1          1
       90   08sep89   08sep90         12         31          1          0
       91   10apr90   09aug90          4         35          0          1
       92   11dec90   09sep95         57         36          0          1
       93   15dec90   14jan91          1         41          1          1
       94   13jan89   13jan90         12         36          1          0
       95   22aug91   21mar92          7         35          1          1
       96   02aug91   01sep91          1         34          1          1
       97   22may91   21oct91          5         28          0          1
       98   02apr90   01apr95         60         29          0          0
       99   01may91   30jun91          2         35          1          0
      100   11may89   10jun89          1         34          1          1

;
run;

ods pdf;

** K-M estimation;
proc lifetest data=hiv method=km nelson plots=survival(cl)
	plots=(s,ls) graphics outsurv=hivtable;
	time months*status(0);
	strata ivdrug;
	symbol1 v=none color=black line=1;
	symbol2 v=none color=black line=2;
run;
** LIfe-table estimation;
proc lifetest data=hiv method=life
	plots=(s,ls) graphics outsurv=hivlifetable;
	time months*status(0);
	strata ivdrug;
	symbol1 v=none color=green line=1;
	symbol2 v=none color=yellow line=2;
run;

ods pdf close;


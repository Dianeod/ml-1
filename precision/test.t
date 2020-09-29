// Load in data saved as golden copy for this analysis
// Load files
fileList:`mat1`mat12`mat13`mat2`mat23`mat3`func1`func2`func3`sub1`sub2`sub3`func1_old`func2_old`func3_old`test1`test2`test3
{load hsym`$":precision/data/",string x}each fileList;

precisionFunc:{$[x~y;1b;
       [-1"Sum of differences of ",string sum raze abs x-y;-1"\nMax difference of ",string max raze abs x-y;0b]]}

-1"\nTesting Least Squares (lsq)";

// lsq check
precisionFunc[mat1;lsq1:lsq[test1;test1]]
precisionFunc[mat2;lsq2:lsq[test2;test2]]
precisionFunc[mat3;lsq3:lsq[test3;test3]]


precisionFunc:{$[x~y;1b;
      [-1"Sum of difference of ",string sum abs x-y;-1"\nMax difference of ",string max abs x-y;0b]]}


subtract:{x-y}

-1"\nTesting gradient function";



precisionFunc[sub1;subtract[func1_old;func1]]
precisionFunc[sub2;subtract[func2_old;func2]]
precisionFunc[sub3;subtract[func3_old;func3]]





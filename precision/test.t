// Load in data saved as golden copy for this analysis
// Load files
fileList:`mat1`mat12`mat13`mat2`mat23`mat3`func1`func2`func3`sub1`sub2`sub3`func1_old`func2_old`func3_old`test1`test2`test3`fexp1`fexp2`fexp3
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


funcEval:{[func;xk;eps]
  // increment function optimisation values by epsilon
  xk[0]+:eps;
  // Evaluate the gradient
  func[xk]
  }

subtract:{x-y}

// Function to get gradient of
rosenFunc:{(sum(100*(_[1;x] - _[-1;x]xexp 2.0)xexp 2) + (1 - _[-1;x])xexp 2)}

-1"\nTesting gradient function";



precisionFunc[func1;f1:funcEval[rosenFunc;1_first mat1;1.49e-8]]
precisionFunc[func2;f2:funcEval[rosenFunc;1_first mat2;1.49e-8]]
precisionFunc[func3;f3:funcEval[rosenFunc;1_first mat3;1.49e-8]]

1"func1: ",string func1-f1;
1"func2: ",string func2-f2;
1"func3: ",string func3-f3;


precisionFunc[sub1;subtract[rosenFunc[1_first mat1];func1]]
precisionFunc[sub2;subtract[rosenFunc[1_first mat2];func2]]
precisionFunc[sub3;subtract[rosenFunc[1_first mat3];func3]]

precisionFunc[sub1;subtract[rosenFunc[1_first mat1];f1]]
precisionFunc[sub2;subtract[rosenFunc[1_first mat2];f2]]
precisionFunc[sub3;subtract[rosenFunc[1_first mat3];f3]]


precisionFunc[sub1;subtract[func1_old;func1]]
precisionFunc[sub2;subtract[func2_old;func2]]
precisionFunc[sub3;subtract[func3_old;func3]]


fexp:{xexp[x;2]}
precisionFunc[fexp1;fe1:fexp[1.370841e-6]]
precisionFunc[fexp2;fe2:fexp[1e-8]]
precisionFunc[fexp3;fe3:fexp[-7.200289e-5]]

1"\nexp1: ",string fexp1-fe1;
1"\nexp2: ",string fexp2-fe2;
1"\nexp3: ",string fexp3-fe3;


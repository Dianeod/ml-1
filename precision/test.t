// Load in data saved as golden copy for this analysis
// Load files
fileList:`mat1`mat12`mat13`mat2`mat23`mat3`mmu1`mmu12`mmu13`mmu2`mmu23`mmu3`test1`test2`test3,
         `mmulsq1`mmulsq2`mmulsq3`mmulsq12`mmulsq13`mmulsq23`gradR1`gradR2`gradR3`accum1`accum2`accum3
{load hsym`$":precision/data/",string x}each fileList;

precisionFunc:{$[x~y;1b;
       [-1"Sum of differences of ",string sum raze abs x-y;;-1"\nMax difference of ",string max raze abs x-y;0b]]}

-1"\nTesting Least Squares (lsq)";

// lsq check
precisionFunc[mat1;lsq1:lsq[test1;test1]]
precisionFunc[mat2;lsq2:lsq[test2;test2]]
precisionFunc[mat3;lsq3:lsq[test3;test3]]
precisionFunc[mat12;lsq[test1;test2]]
precisionFunc[mat13;lsq[test1;test3]]
precisionFunc[mat23;lsq[test2;test3]]

-1"\nTesting matrix multiplication (mmu)";

// mmu check
precisionFunc[mmu1;mmu[test1;flip test1]]
precisionFunc[mmu2;mmu[test2;flip test2]]
precisionFunc[mmu3;mmu[test3;flip test3]]
precisionFunc[mmu12;mmu[test1;flip test2]]
precisionFunc[mmu13;mmu[test1;flip test3]]
precisionFunc[mmu23;mmu[test2;flip test3]]

-1"\nTesting matrix multiplication with output generated from lsq function as input";

// mmu with lsq
precisionFunc[mmulsq1;mmu[lsq1;lsq1]]
precisionFunc[mmulsq2;mmu[lsq2;lsq2]]
precisionFunc[mmulsq3;mmu[lsq3;lsq3]]
precisionFunc[mmulsq12;mmu[lsq1;lsq2]]
precisionFunc[mmulsq13;mmu[lsq1;lsq3]]
precisionFunc[mmulsq23;mmu[lsq2;lsq3]]

// gradfunc

precisionFunc:{$[x~y;1b;
      [-1"Sum of difference of ",string sum abs x-y;-1"\nMax difference of ",string max abs x-y;0b]]}


grad:{[func;xk;eps]
  fk:func[xk];
  gradEval[fk;func;xk;eps]each til count xk
  }

gradEval:{[fk;func;xk;eps;idx]
  // increment function optimisation values by epsilon
  xk[idx]+:eps;
  // Evaluate the gradient
  (func[xk]-fk)%eps
  }

// Function to get gradient of
rosenFunc:{(sum(100*(_[1;x] - _[-1;x]xexp 2.0)xexp 2) + (1 - _[-1;x])xexp 2)}

-1"\nTesting gradient function";

precisionFunc[gradR1;grad[rosenFunc;first mat1;1.49e-8]]
precisionFunc[gradR2;grad[rosenFunc;first mat2;1.49e-8]]
precisionFunc[gradR3;grad[rosenFunc;first mat3;1.49e-8]]
precisionFunc[gradR1;grad[rosenFunc;first lsq1;1.49e-8]]
precisionFunc[gradR2;grad[rosenFunc;first lsq2;1.49e-8]]
precisionFunc[gradR3;grad[rosenFunc;first lsq3;1.49e-8]]


-1"\nTesting gradient function with accumulative error";

gradAccum:{[func;xk;eps]
  fk:func[xk];
  xk*gradEval[fk;func;xk;eps]each til count xk
  }

precisionFunc[accum1;35 gradAccum[rosenFunc;;1.49e-8]/1_first mat1]
precisionFunc[accum2;35 gradAccum[rosenFunc;;1.49e-8]/1_first mat2]
precisionFunc[accum3;35 gradAccum[rosenFunc;;1.49e-8]/1_first mat3]
precisionFunc[accum1;35 gradAccum[rosenFunc;;1.49e-8]/1_first lsq1]
precisionFunc[accum2;35 gradAccum[rosenFunc;;1.49e-8]/1_first lsq2]
precisionFunc[accum3;35 gradAccum[rosenFunc;;1.49e-8]/1_first lsq3]

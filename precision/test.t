\S 42

\l ml.q
\l util/util.q
\l optimize/optim.q

// Load in data saved as golden copy for this analysis
// Load files
fileList:`mat1`mat12`mat13`mat2`mat23`mat3`mmu1`mmu12`mmu13`mmu2`mmu23`mmu3`test1`test2`test3,
         `mmulsq1`mmulsq2`mmulsq3`mmulsq12`mmulsq13`mmulsq23`grad1`grad2`grad3`gradR1`gradR2`gradR4`gradR3`gradR4`rosen1`rosen2
{load hsym`$":precision/data/",string x}each fileList;

precisionFunc:{$[x~y;1b;[-1"Difference of ",string sum raze x-y;0b]]}

// lsq check
precisionFunc[mat1;lsq1:lsq[test1;test1]]
precisionFunc[mat2;lsq2:lsq[test2;test2]]
precisionFunc[mat3;lsq3:lsq[test3;test3]]
precisionFunc[mat12;lsq[test1;test2]]
precisionFunc[mat13;lsq[test1;test3]]
precisionFunc[mat23;lsq[test2;test3]]

// mmu check
precisionFunc[mmu1;mmu[test1;flip test1]]
precisionFunc[mmu2;mmu[test2;flip test2]]
precisionFunc[mmu3;mmu[test3;flip test3]]
precisionFunc[mmu12;mmu[test1;flip test2]]
precisionFunc[mmu13;mmu[test1;flip test3]]
precisionFunc[mmu23;mmu[test2;flip test3]]

// mmu with lsq
precisionFunc[mmulsq1;mmu[lsq1;lsq1]]
precisionFunc[mmulsq2;mmu[lsq2;lsq2]]
precisionFunc[mmulsq3;mmu[lsq3;lsq3]]
precisionFunc[mmulsq12;mmu[lsq1;lsq2]]
precisionFunc[mmulsq13;mmu[lsq1;lsq3]]
precisionFunc[mmulsq23;mmu[lsq2;lsq3]]

// gradfunc

precisionFunc:{$[x~y;1b;[-1"Difference of ",string sum x-y;0b]]}


quadFunc:{xexp[x[0];2]-4*x[0]}

precisionFunc[grad1;.ml.i.grad[quadFunc;enlist 1029f;();1.49e-8]]
precisionFunc[grad2;.ml.i.grad[quadFunc;enlist 712f;();1.49e-9]]
precisionFunc[grad3;.ml.i.grad[quadFunc;enlist 111f;();1.49e-6]]


rosenFunc:{(sum(100*(_[1;x] - _[-1;x]xexp 2.0)xexp 2) + (1 - _[-1;x])xexp 2)}
precisionFunc[gradR1;.ml.i.grad[rosenFunc;rosen1;();1.49e-8]]
precisionFunc[gradR2;.ml.i.grad[rosenFunc;rosen1;();1.49e-7]]
precisionFunc[gradR3;.ml.i.grad[rosenFunc;"f"$rosen2;();1.49e-6]]
precisionFunc[gradR4;.ml.i.grad[rosenFunc;"f"$rosen2;();1.49e-9]]
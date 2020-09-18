\S 42

\l ml.q
\l util/util.q
\l optimize/optim.q

// Load in data saved as golden copy for this analysis
// Load files
fileList:`mat1`mat12`mat13`mat2`mat23`mat3`mmu1`mmu12`mmu13`mmu2`mmu23`mmu3`test1`test2`test3,
         `mmulsq1`mmulsq2`mmulsq3`mmulsq12`mmulsq13`mmulsq23`grad1`grad2`grad3`gradR1`gradR2`gradR4`gradR3`gradR4,
         `gradR5`gradR6`gradR7`rosen1`rosen2`submat1`submat2`submat3
{load hsym`$":precision/data/",string x}each fileList;

precisionFunc:{$[x~y;1b;
       [-1"Sum of differences of ",string sum raze abs x-y;;-1"\nMax difference of ",string max raze abs x-y;0b]]}

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

precisionFunc:{$[x~y;1b;
      [-1"Sum of difference of ",string sum abs x-y;-1"\nMax difference of ",string max abs x-y;0b]]}


sub:{x-y}

precisionFunc[submat1;sub[;1.49e-8]each lsq1[0]]
precisionFunc[submat1;sub[;1.49e-8]each mat1[0]]
precisionFunc[submat2;sub[;1.49e-8]each lsq2[0]]
precisionFunc[submat2;sub[;1.49e-8]each mat2[0]]
precisionFunc[submat3;sub[;1.49e-8]each lsq3[0]]
precisionFunc[submat3;sub[;1.49e-8]each mat3[0]]
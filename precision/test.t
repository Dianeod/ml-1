\S 42

\l ml.q
\l util/util.q
\l optimize/optim.q

// Load in data saved as golden copy for this analysis
// Load files
fileList:`mat1`mat12`mat13`mat2`mat23`mat3`mmu1`mmu12`mmu13`mmu2`mmu23`mmu3`test1`test2`test3,
         `mmulsq1`mmulsq2`mmulsq3`mmulsq12`mmulsq13`mmulsq23`grad1`grad2`grad3`gradR1`gradR2`gradR4`gradR3`gradR4`rosen1`rosen2
{load hsym`$":precision/data/",string x}each fileList;

// lsq check
mat1~lsq1:lsq[test1;test1]
mat2~lsq2:lsq[test2;test2]
mat3~lsq3:lsq[test3;test3]
mat12~lsq[test1;test2]
mat13~lsq[test1;test3]
mat23~lsq[test2;test3]

// mmu check
mmu1~mmu[test1;flip test1]
mmu2~mmu[test2;flip test2]
mmu3~mmu[test3;flip test3]
mmu12~mmu[test1;flip test2]
mmu13~mmu[test1;flip test3]
mmu23~mmu[test2;flip test3]

// mmu with lsq
mmulsq1~mmu[lsq1;lsq1]
mmulsq2~mmu[lsq2;lsq2]
mmulsq3~mmu[lsq3;lsq3]
mmulsq12~mmu[lsq1;lsq2]
mmulsq13~mmu[lsq1;lsq3]
mmulsq23~mmu[lsq2;lsq3]

// gradfunc
quadFunc:{xexp[x[0];2]-4*x[0]}

grad1~.ml.i.grad[quadFunc;enlist 1029f;();1.49e-8]
grad2~.ml.i.grad[quadFunc;enlist 712f;();1.49e-9]
grad3~.ml.i.grad[quadFunc;enlist 111f;();1.49e-6]


rosenFunc:{(sum(100*(_[1;x] - _[-1;x]xexp 2.0)xexp 2) + (1 - _[-1;x])xexp 2)}
gradR1~.ml.i.grad[rosenFunc;rosen1;();1.49e-8]
gradR2~.ml.i.grad[rosenFunc;rosen1;();1.49e-7]
gradR3~.ml.i.grad[rosenFunc;"f"$rosen2;();1.49e-6]
gradR4~.ml.i.grad[rosenFunc;"f"$rosen2;();1.49e-9]
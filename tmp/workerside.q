\l p.q
gengsearch:{[x;dict;data]
 mdl:.p.import[`pickle][`:loads][x];
 algs:mkalg[dict;mdl];
 {x[`:fit][y 0;y 2][`:score][y 1;y 3]`}[;data]each algs}
kffitscore:{[x;data]
 mdl:.p.import[`pickle][`:loads][x];
 {x[`:fit][y 0;y 2][`:score][y 1;y 3]`}[mdl;data]}
mkalg:{[dict;algo]$[1=count kd:key[dict];
 {x[(y 0) pykw z]}[algo;kd]each (value dict)0;
 algo@'{pykwargs x}each {key[x]!y}[dict;]each (cross/)value dict]}
kfoldx2:{[x;y;i;fn]
 alg:.p.import[`pickle][`:loads][fn];
 data:distrib[x;i],'distrib[y;i];
 vals:{x[`:fit][y 0;y 2][`:score][y 1;y 3]`}[alg]each data;
 $[1=count shape vals;avg vals;avg each (,'/)vals]}
shape:{-1_count each first scan x}
distrib:{{(raze x _ y;x y)}[x y;]each til count y}

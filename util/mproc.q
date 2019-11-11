\d .ml

.z.pd:$[`mproc in key .ml;.z.pd;`u#0#0i];
.z.pc:{.z.pd:`u#.z.pd except x}
mproc.reg:{.z.pd,:.z.w;neg[.z.w]@/:mproc.cmds}
mproc.run:{mproc.cmds:y;
	   do[x;system"q ",path,"/util/mprocw.q -pp ",string z];}
mproc.call:{{neg[y]x}[raze x]each .z.pd;
	   mproc.dict:mproc.dict,'enlist each y#x;}
mproc.init:{[n;x]
  b:not`cmds in key .ml.mproc;
  if[not p:system"p";'"set port to multiprocess"];
  $[b;mproc.run[n;x;p];
   abs[system"s"]=mp:count[.z.pd];	
   mproc.call[x;mp];
   mproc.cmds,:x]} 

\l p.q
\l ml.q
\l util/util.q
\l optimize/optim.q
\l timeseries/utils.q
\l timeseries/fit.q
\l fresh/extract.q
\l timeseries/tests/failMessage.q

\S 42
endogInt  :10000?1000
endogFloat:10000?1000f
exogInt   :10000 50#50000?1000
exogFloat :10000 50#50000?1000f
exogMixed :(10000 20#20000?1000),'(10000 20#20000?1000f),'(10000 10#10000?0b)
residInt  :10000?1000
residFloat:10000?1000f
/test1:100 1000#100000?100000f
/test2:100 1000#100000?100000f
/test3:100 1000#100000?100000f


// Load files
fileList:`AR1`AR2`AR3`AR4`ARCH1`ARCH2`ARMA1`ARMA2`ARMA3`ARMA4`ARIMA1`ARIMA2,
         `ARIMA3`ARIMA4`SARIMA1`SARIMA2`SARIMA3`SARIMA4`nonStat`mat1`mat2`mat3`mat12`mat13`mat23`test1`test2`test3
{load hsym`$":timeseries/tests/data/fit/",string x}each fileList;

// precision function for windows vs unix results
precisionFunc:{all 1e-2>0N!max abs raze raze each value x-y}

matFunc:{sub:abs x-y;0N!"sum: ",string sum sum each sub;0N!"max: ",string max raze sub;x~y}

matFunc[mat1;test1 lsq test1]
matFunc[mat2;(test2 lsq test2)]
matFunc[mat3;(test3 lsq test3)]
matFunc[mat12;(test1 lsq test2)]
matFunc[mat13;(test1 lsq test3)]
matFunc[mat23;(test2 lsq test3)]


// AR tests
precisionFunc[.ml.ts.AR.fit[endogInt  ;()       ;1;0b];AR1]
precisionFunc[.ml.ts.AR.fit[endogInt  ;exogFloat;3;1b];AR2]
precisionFunc[.ml.ts.AR.fit[endogFloat;exogInt  ;2;1b];AR3]
precisionFunc[.ml.ts.AR.fit[endogFloat;exogMixed;4;0b];AR4]

failingTest[.ml.ts.AR.fit;(endogInt  ;5000#exogInt  ;1;1b);0b;"Endog length less than length"]
failingTest[.ml.ts.AR.fit;(endogFloat;5000#exogFloat;1;1b);0b;"Endog length less than length"]


// ARMA tests
precisionFunc[.ml.ts.ARMA.fit[endogInt  ;()       ;1;2;1b];ARMA1]
precisionFunc[.ml.ts.ARMA.fit[endogInt  ;exogFloat;2;1;0b];ARMA2]
precisionFunc[.ml.ts.ARMA.fit[endogFloat;exogInt  ;1;1;0b];ARMA3]
precisionFunc[.ml.ts.ARMA.fit[endogFloat;exogMixed;3;2;1b];ARMA4]

failingTest[.ml.ts.ARMA.fit;(endogInt  ;5000#exogInt  ;2;1;0b);0b;"Endog length less than length"]
failingTest[.ml.ts.ARMA.fit;(endogFloat;5000#exogFloat;2;1;0b);0b;"Endog length less than length"]


// ARCH tests
precisionFunc[.ml.ts.ARCH.fit[residInt  ;3];ARCH1]
precisionFunc[.ml.ts.ARCH.fit[residFloat;1];ARCH2]


// ARIMA tests
precisionFunc[.ml.ts.ARIMA.fit[endogInt  ;()       ;2;1;2;0b];ARIMA1]
precisionFunc[.ml.ts.ARIMA.fit[endogInt  ;exogFloat;1;1;1;1b];ARIMA2]
precisionFunc[.ml.ts.ARIMA.fit[endogFloat;exogInt  ;3;0;1;1b];ARIMA3]
precisionFunc[.ml.ts.ARIMA.fit[endogFloat;exogMixed;1;2;2;0b];ARIMA4]

failingTest[.ml.ts.ARIMA.fit;(endogInt  ;5000#exogInt  ;1;1;1;1b);0b;"Endog length less than length"]
failingTest[.ml.ts.ARIMA.fit;(endogFloat;5000#exogFloat;1;1;1;1b);0b;"Endog length less than length"]
failingTest[.ml.ts.ARIMA.fit;(nonStat   ;()            ;1;0;1;1b);0b;"Time series not stationary, try another value of d"]

// SARIMA tests
s1:`P`D`Q`m!1 0 2 5
s2:`P`D`Q`m!2 1 0 10
s3:`P`D`Q`m!2 1 1 30
s4:`P`D`Q`m!0 1 1 20

precisionFunc[.ml.ts.SARIMA.fit[endogInt  ;()       ;1;1;1;0b;s1];SARIMA1]
precisionFunc[.ml.ts.SARIMA.fit[endogInt  ;exogFloat;1;0;1;1b;s2];SARIMA2]
precisionFunc[.ml.ts.SARIMA.fit[endogFloat;exogInt  ;1;2;0;0b;s3];SARIMA3]
precisionFunc[.ml.ts.SARIMA.fit[endogFloat;exogMixed;2;1;1;0b;s4];SARIMA4]

failingTest[.ml.ts.SARIMA.fit;(endogInt  ;5000#exogInt  ;2;0;1;1b;s1);0b;"Endog length less than length"]
failingTest[.ml.ts.SARIMA.fit;(endogFloat;5000#exogFloat;2;0;1;1b;s1);0b;"Endog length less than length"]
failingTest[.ml.ts.SARIMA.fit;(nonStat   ;()            ;2;0;0;1b;s1);0b;"Time series not stationary, try another value of d"]


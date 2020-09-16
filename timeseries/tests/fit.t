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

// Load files
fileList:`AR1`AR2`AR3`AR4`ARCH1`ARCH2`ARMA1`ARMA2`ARMA3`ARMA4`ARIMA1`ARIMA2,
         `ARIMA3`ARIMA4`SARIMA1`SARIMA2`SARIMA3`SARIMA4`nonStat
{load hsym`$":timeseries/tests/data/fit/",string x}each fileList;

// precision function for windows vs unix results
precisionfunc:{
  .[{x~y};(x;y);{-1"Exact match not created, ensuring diff < 1e-12\n";all 1e-10>raze x-y}[x;y]]
  }


// AR tests
precisionfunc[.ml.ts.AR.fit[endogInt  ;()       ;1;0b];AR1]
precisionfunc[.ml.ts.AR.fit[endogInt  ;exogFloat;3;1b];AR2]
precisionfunc[.ml.ts.AR.fit[endogFloat;exogInt  ;2;1b];AR3]
precisionfunc[.ml.ts.AR.fit[endogFloat;exogMixed;4;0b];AR4]

failingTest[.ml.ts.AR.fit;(endogInt  ;5000#exogInt  ;1;1b);0b;"Endog length less than length"]
failingTest[.ml.ts.AR.fit;(endogFloat;5000#exogFloat;1;1b);0b;"Endog length less than length"]


// ARMA tests
precisionfunc[.ml.ts.ARMA.fit[endogInt  ;()       ;1;2;1b];ARMA1]
precisionfunc[.ml.ts.ARMA.fit[endogInt  ;exogFloat;2;1;0b];ARMA2]
precisionfunc[.ml.ts.ARMA.fit[endogFloat;exogInt  ;1;1;0b];ARMA3]
precisionfunc[.ml.ts.ARMA.fit[endogFloat;exogMixed;3;2;1b];ARMA4]

failingTest[.ml.ts.ARMA.fit;(endogInt  ;5000#exogInt  ;2;1;0b);0b;"Endog length less than length"]
failingTest[.ml.ts.ARMA.fit;(endogFloat;5000#exogFloat;2;1;0b);0b;"Endog length less than length"]


// ARCH tests
precisionfunc[.ml.ts.ARCH.fit[residInt  ;3];ARCH1]
precisionfunc[.ml.ts.ARCH.fit[residFloat;1];ARCH2]


// ARIMA tests
precisionfunc[.ml.ts.ARIMA.fit[endogInt  ;()       ;2;1;2;0b];ARIMA1]
precisionfunc[.ml.ts.ARIMA.fit[endogInt  ;exogFloat;1;1;1;1b];ARIMA2]
precisionfunc[.ml.ts.ARIMA.fit[endogFloat;exogInt  ;3;0;1;1b];ARIMA3]
precisionfunc[.ml.ts.ARIMA.fit[endogFloat;exogMixed;1;2;2;0b];ARIMA4]

failingTest[.ml.ts.ARIMA.fit;(endogInt  ;5000#exogInt  ;1;1;1;1b);0b;"Endog length less than length"]
failingTest[.ml.ts.ARIMA.fit;(endogFloat;5000#exogFloat;1;1;1;1b);0b;"Endog length less than length"]
failingTest[.ml.ts.ARIMA.fit;(nonStat   ;()            ;1;0;1;1b);0b;"Time series not stationary, try another value of d"]

// SARIMA tests
s1:`P`D`Q`m!1 0 2 5
s2:`P`D`Q`m!2 1 0 10
s3:`P`D`Q`m!2 1 1 30
s4:`P`D`Q`m!0 1 1 20

precisionfunc[.ml.ts.SARIMA.fit[endogInt  ;()       ;1;1;1;0b;s1];SARIMA1]
precisionfunc[.ml.ts.SARIMA.fit[endogInt  ;exogFloat;1;0;1;1b;s2];SARIMA2]
precisionfunc[.ml.ts.SARIMA.fit[endogFloat;exogInt  ;1;2;0;0b;s3];SARIMA3]
precisionfunc[.ml.ts.SARIMA.fit[endogFloat;exogMixed;2;1;1;0b;s4];SARIMA4]

failingTest[.ml.ts.SARIMA.fit;(endogInt  ;5000#exogInt  ;2;0;1;1b;s1);0b;"Endog length less than length"]
failingTest[.ml.ts.SARIMA.fit;(endogFloat;5000#exogFloat;2;0;1;1b;s1);0b;"Endog length less than length"]
failingTest[.ml.ts.SARIMA.fit;(nonStat   ;()            ;2;0;0;1b;s1);0b;"Time series not stationary, try another value of d"]


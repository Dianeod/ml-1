\l p.q
\l ml.q
\l util/util.q
\l optimize/optim.q
\l timeseries/utils.q
\l timeseries/fit.q
\l fresh/extract.q
\l timeseries/tests/failMessage.q


\S 42
endogInt  :1000?1000
endogFloat:1000?1000f
exogInt   :1000 10#10000?1000
exogFloat :1000 10#10000?1000f
exogMixed :(1000 5#5000?1000),'(1000 5#5000?1000f),'(1000 5#5000?0b)
residInt  :1000?100
residFloat:1000?100f


// Load files
fileList:`AR1`AR2`AR3`AR4`ARCH1`ARCH2`ARMA1`ARMA2`ARMA3`ARMA4`ARIMA1`ARIMA2,
         `ARIMA3`ARIMA4`SARIMA1`SARIMA2`SARIMA3`SARIMA4`nonStat
{load hsym`$":timeseries/tests/data/fit/",string x}each fileList;

// precision function for windows vs unix results
precisionFunc:{all 1e-11>abs raze raze each value x-y}


// AR tests
precisionFunc[.ml.ts.AR.fit[endogInt  ;()       ;1;0b];AR1]
precisionFunc[.ml.ts.AR.fit[endogInt  ;exogFloat;3;1b];AR2]
precisionFunc[.ml.ts.AR.fit[endogFloat;exogInt  ;2;1b];AR3]
precisionFunc[.ml.ts.AR.fit[endogFloat;exogMixed;4;0b];AR4]

failingTest[.ml.ts.AR.fit;(endogInt  ;500#exogInt  ;1;1b);0b;"Endog length less than length"]
failingTest[.ml.ts.AR.fit;(endogFloat;500#exogFloat;1;1b);0b;"Endog length less than length"]


// ARMA tests
precisionFunc[.ml.ts.ARMA.fit[endogInt  ;()       ;1;2;1b];ARMA1]
precisionFunc[.ml.ts.ARMA.fit[endogInt  ;exogFloat;2;1;0b];ARMA2]
precisionFunc[.ml.ts.ARMA.fit[endogFloat;exogInt  ;1;1;0b];ARMA3]
precisionFunc[.ml.ts.ARMA.fit[endogFloat;exogMixed;3;2;1b];ARMA4]

failingTest[.ml.ts.ARMA.fit;(endogInt  ;500#exogInt  ;2;1;0b);0b;"Endog length less than length"]
failingTest[.ml.ts.ARMA.fit;(endogFloat;500#exogFloat;2;1;0b);0b;"Endog length less than length"]


// ARCH tests
precisionFunc[.ml.ts.ARCH.fit[residInt  ;3];ARCH1]
precisionFunc[.ml.ts.ARCH.fit[residFloat;1];ARCH2]


// ARIMA tests
precisionFunc[.ml.ts.ARIMA.fit[endogInt  ;()       ;2;1;2;0b];ARIMA1]
precisionFunc[.ml.ts.ARIMA.fit[endogInt  ;exogFloat;1;1;1;1b];ARIMA2]
precisionFunc[.ml.ts.ARIMA.fit[endogFloat;exogInt  ;3;0;1;1b];ARIMA3]
precisionFunc[.ml.ts.ARIMA.fit[endogFloat;exogMixed;1;2;2;0b];ARIMA4]

failingTest[.ml.ts.ARIMA.fit;(endogInt  ;500#exogInt  ;1;1;1;1b);0b;"Endog length less than length"]
failingTest[.ml.ts.ARIMA.fit;(endogFloat;500#exogFloat;1;1;1;1b);0b;"Endog length less than length"]
failingTest[.ml.ts.ARIMA.fit;(nonStat   ;()            ;1;0;1;1b);0b;"Time series not stationary, try another value of d"]

// SARIMA tests

precisionFuncSARIMA:{all $[.z.o like "w*";
                       0.2;
                       1e-11]>abs raze raze each value x-y}

s1:`P`D`Q`m!1 0 1 5
s2:`P`D`Q`m!2 1 0 7
s3:`P`D`Q`m!2 1 1 8
s4:`P`D`Q`m!0 1 1 10

precisionFuncSARIMA[.ml.ts.SARIMA.fit[endogInt  ;()       ;1;1;1;0b;s1];SARIMA1]
precisionFuncSARIMA[.ml.ts.SARIMA.fit[endogInt  ;exogFloat;1;0;1;1b;s2];SARIMA2]
precisionFuncSARIMA[.ml.ts.SARIMA.fit[endogFloat;exogInt  ;1;2;0;0b;s3];SARIMA3]
precisionFuncSARIMA[.ml.ts.SARIMA.fit[endogFloat;exogMixed;2;1;1;0b;s4];SARIMA4]

failingTest[.ml.ts.SARIMA.fit;(endogInt  ;500#exogInt  ;2;0;1;1b;s1);0b;"Endog length less than length"]
failingTest[.ml.ts.SARIMA.fit;(endogFloat;500#exogFloat;2;0;1;1b;s1);0b;"Endog length less than length"]
failingTest[.ml.ts.SARIMA.fit;(nonStat   ;()            ;2;0;0;1b;s1);0b;"Time series not stationary, try another value of d"]


\l p.q
\l ml.q
\l timeseries/utils.q
\l timeseries/fit.q
\l timeseries/predict.q
\l timeseries/tests/failMessage.q

\S 42
exogIntFuture   :1000 50#5000?1000
exogFloatFuture :1000 50#5000?1000f
exogMixedFuture :(1000 20#20000?1000),'(1000 20#20000?1000f),'(1000 10#10000?0b)

// Load files
fileList:`AR1`AR2`AR3`AR4`ARCH1`ARCH2`ARMA1`ARMA2`ARMA3`ARMA4`ARIMA1`ARIMA2,
         `ARIMA3`ARIMA4`SARIMA1`SARIMA2`SARIMA3`SARIMA4
loadFunc:{load hsym`$":timeseries/tests/data/",x,string y}
loadFunc["fit/"]each fileList;
loadFunc["pred/pred"]each fileList;

// precision function for windows vs unix results
precisionfunc:{ 
 .[{x~y};(x;y);{-1"Exact match not created, ensuring diff < 1e-12\n";all 1e-10>raze y-z}[x;y]]
 }

// AR tests

precisionfunc[.ml.ts.AR.predict[AR1;();1000];predAR1]
precisionfunc[.ml.ts.AR.predict[AR2;exogFloatFuture;1000];predAR2]
precisionfunc[.ml.ts.AR.predict[AR3;exogIntFuture;1000];predAR3]
precisionfunc[.ml.ts.AR.predict[AR4;exogMixedFuture;1000];predAR4]

failingTest[.ml.ts.AR.predict;(AR2;-1_'exogFloatFuture;1000);0b;"Test exog length does not match train exog length"]
failingTest[.ml.ts.AR.predict;(AR3;-1_'exogIntFuture  ;1000);0b;"Test exog length does not match train exog length"]

// ARCH tests

precisionfunc[.ml.ts.ARCH.predict[ARCH1;1000];predARCH1]
precisionfunc[.ml.ts.ARCH.predict[ARCH2;1000];predARCH2]

// ARMA tests

precisionfunc[.ml.ts.ARMA.predict[ARMA1;();1000];predARMA1]
precisionfunc[.ml.ts.ARMA.predict[ARMA2;exogFloatFuture;1000];predARMA2]
precisionfunc[.ml.ts.ARMA.predict[ARMA3;exogIntFuture;1000];predARMA3]
precisionfunc[.ml.ts.ARMA.predict[ARMA4;exogMixedFuture;1000];predARMA4]

failingTest[.ml.ts.ARMA.predict;(ARMA2;-1_'exogFloatFuture;1000);0b;"Test exog length does not match train exog length"]
failingTest[.ml.ts.ARMA.predict;(ARMA3;-1_'exogIntFuture  ;1000);0b;"Test exog length does not match train exog length"]
failingTest[.ml.ts.ARMA.predict;(AR1  ;()                 ;1000);0b;"The following required dictionary keys for 'mdl' are not provided: q_param, resid, estresid, pred_dict"]

// ARIMA tests

precisionfunc[.ml.ts.ARIMA.predict[ARIMA1;();1000];predARIMA1]
precisionfunc[.ml.ts.ARIMA.predict[ARIMA2;exogFloatFuture;1000];predARIMA2]
precisionfunc[.ml.ts.ARIMA.predict[ARIMA3;exogIntFuture;1000];predARIMA3]
precisionfunc[.ml.ts.ARIMA.predict[ARIMA4;exogMixedFuture;1000];predARIMA4]

failingTest[.ml.ts.ARIMA.predict;(ARIMA2;-1_'exogFloatFuture;1000);0b;"Test exog length does not match train exog length"]
failingTest[.ml.ts.ARIMA.predict;(ARIMA3;-1_'exogIntFuture  ;1000);0b;"Test exog length does not match train exog length"] 
failingTest[.ml.ts.ARIMA.predict;(ARMA4 ;exogMixedFuture    ;1000);0b;"The following required dictionary keys for 'mdl' are not provided: origd"]

// SARIMA tests

precisionfunc[.ml.ts.SARIMA.predict[SARIMA1;();1000];predSARIMA1]
precisionfunc[.ml.ts.SARIMA.predict[SARIMA2;exogFloatFuture;1000];predSARIMA2]
precisionfunc[.ml.ts.SARIMA.predict[SARIMA3;exogIntFuture;1000];predSARIMA3]
precisionfunc[.ml.ts.SARIMA.predict[SARIMA4;exogMixedFuture;1000];predSARIMA4]

failingTest[.ml.ts.SARIMA.predict;(SARIMA2;-1_'exogFloatFuture;1000);0b;"Test exog length does not match train exog length"]
failingTest[.ml.ts.SARIMA.predict;(SARIMA3;-1_'exogIntFuture  ;1000);0b;"Test exog length does not match train exog length"]
failingTest[.ml.ts.SARIMA.predict;(ARIMA2 ;exogFloatFuture    ;1000);0b;"The following required dictionary keys for 'mdl' are not provided: origs, P_param, Q_param"]


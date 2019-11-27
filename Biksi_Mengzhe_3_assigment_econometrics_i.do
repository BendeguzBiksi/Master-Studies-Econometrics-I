* Third group assignment
* Econometrics I
* BGSE 10/2015, fall term


use "Biksi_Mengzhe_2_assigment_econometrics_i_gas.dta", clear


*exercise 1
gen G=G/pop
gen G=g/pop
gen lnG=log(G)
gen lnY=log(y)
gen lnPG=log(pg)
gen lnPuc=log(puc)
gen lnPnc=log(pnc)
reg lnG year lnY lnPG lnPuc lnPnc
*a)
reg lnG year lnY lnPG lnPuc lnPnc in 1/14
reg lnG year lnY lnPG lnPuc lnPnc in 15/36
*b)
reg lnG year lnY lnPG lnPuc lnPnc in 1/14
est store P1
reg lnG year lnY lnPG lnPuc lnPnc in 15/36
est store P2
hausman P1 P2
*c）

*exercise 2
clear all
use "Biksi_Mengzhe_3_assigment_econometrics_i_jec.dta"


gen lnQ=log(quantity)
gen lnP=log(p)

*b)
reg lnQ lnP ice seas1 seas2 seas3 seas4 seas5 seas6 seas7 seas8 seas9 seas10 seas11 seas12

*f)
reg lnP cartel to test if the cartel is a weak biased
and use the regression result in b)

*g)
ivreg lnQ seas1 seas2 seas3 seas4 seas5 seas6 seas7 seas8 seas9 seas10 seas11 seas12 (lnP= cartel)

*h)
reg lnQ lnP ice seas1 seas2 seas3 seas4 seas5 seas6 seas7 seas8 seas9 seas10 seas11 seas12
est store a
ivreg lnQ seas1 seas2 seas3 seas4 seas5 seas6 seas7 seas8 seas9 seas10 seas11 seas12 (lnP= cartel)
est store b
hausman a b 

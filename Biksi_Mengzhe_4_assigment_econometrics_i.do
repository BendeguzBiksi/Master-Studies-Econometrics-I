* Forth group assignment
* Econometrics I
* BGSE 10/2015, fall term

use "Biksi_Mengzhe_4_assigment_econometrics_i_forcapm.dta", clear

*1_5
reg agr market
outreg2 using 4_1.tex, tex replace
reg psg market
outreg2 using 4_1.tex, tex append
reg hrr market
outreg2 using 4_1.tex, tex append
reg pop market
outreg2 using 4_1.tex, tex append
reg gas market
outreg2 using 4_1.tex, tex append
*1_5
reg ura market
outreg2 using 4_2.tex, tex replace
reg azk market
outreg2 using 4_2.tex, tex append
reg sch market
outreg2 using 4_2.tex, tex append
reg vid market
outreg2 using 4_2.tex, tex append
reg upl market
outreg2 using 4_2.tex, tex append
*1_5
reg cgi market
outreg2 using 4_3.tex, tex replace
reg alb market
outreg2 using 4_3.tex, tex append
reg eur market
outreg2 using 4_3.tex, tex append
reg ibe market
outreg2 using 4_3.tex, tex append
reg tud market
outreg2 using 4_3.tex, tex append
*1_5
reg caf market
outreg2 using 4_4.tex, tex replace
reg bkt market
outreg2 using 4_4.tex, tex append
reg urb market
outreg2 using 4_4.tex, tex append
reg fnz market
outreg2 using 4_4.tex, tex append
reg ele market
outreg2 using 4_4.tex, tex append
*1_5
reg tef market
outreg2 using 4_5.tex, tex replace
reg nan market
outreg2 using 4_5.tex, tex append
reg ffr market
outreg2 using 4_5.tex, tex append
reg byb market
outreg2 using 4_5.tex, tex append
reg mvc market
outreg2 using 4_5.tex, tex append

sureg (agr: agr = market) (psg: psg = market) (hrr: hrr = market) (pop: pop = market) (gas: gas = market) (ura:ura = market) (azk: azk = market) (sch: sch = market) (vid: vid = market) (upl: upl = market) (cgi: cgi = market) (alb: alb = market) (eur: eur = market) (ibe: ibe = market) (tud: tud = market) (caf: caf = market) (bkt: bkt = market) (urb: urb = market) (fnz: fnz = market) (ele: ele = market) (tef: tef = market) (nan: nan = market) (ffr: ffr = market) (byb: byb = market) (mvc: mvc = market)

outreg2 using 4_sure.tex, tex replace

test (_cons)



clear all

use "Biksi_Mengzhe_4_assigment_econometrics_i_agriculture.dta", clear


*2.b.


***** 2sls with levels w/ first stage regression output included

reg3 (demand: y = p cpi income) (supply: p = y l nptcost), 2sls first

* elasticities at the means of the variables

* price elasticity of the demand:
margins, eyex (p) atmeans

* income elasticity of the demand:
margins, eyex (income) atmeans

* cross-price elasticity of the demand:
margins, eyex (cpi) atmeans

* price elasticity of the supply:

display (1/.441083)*(85.40741/89.96296)


***** 3sls with levels

reg3 (demand: y = p cpi income) (supply: p = y l nptcost)

* elasticities at the means of the variables

* price elasticity of the demand:
margins, eyex (p) atmeans

* income elasticity of the demand:
margins, eyex (income) atmeans

* cross-price elasticity of the demand:
margins, eyex (cpi) atmeans

* price elasticity of the supply:

display (1/.4239944 )*(85.40741/89.96296)



***** 2sls with logs of the variables


* firstly generate the log of the variables:

gen l_y=log(y)
gen l_p=log(p)
gen l_cpi=log(cpi)
gen l_income=log(income)
gen l_l=log(l)
gen l_nptcost=log(nptcost)


* now do the 2sls with logs:

reg3 (demand: l_y = l_p l_cpi l_income) (supply: l_p = l_y l_l l_nptcost), 2sls

* with the log-log setting the coefficients are directly elasticities, except
* the price elasticity of the supply, that is 1/-1.13194 = -.88343905.

***** 3sls with log of the variables


reg3 (demand: l_y = l_p l_cpi l_income) (supply: l_p = l_y l_l l_nptcost)

* to obtain the price elasticity of the supply:

display 1/-.7704187

* that is: -1.2979955.



clear all


*4_3

use "Biksi_Mengzhe_4_assigment_econometrics_i_panel_CMR.dta", clear

xtset i t

*a

reg l_c l_q l_pf lf

display 1/.8827385-1

*b

*b.1

*i.
xi: regress l_c l_q l_pf lf i.i 

*ii.
testparm _Ii*

*b.2

*i.
xi: regress l_c l_q l_pf lf i.t

*ii.

testparm _It*


*c

*random effect:

xtreg l_c l_q l_pf lf, re


*fixed effect:

xtreg l_c l_q l_pf lf, fe



*d

* estimating the random effect model:

xtreg l_c l_q l_pf lf, re

* Breusch-Pagan test, that tests that the variance of alpha is 0 or not

xttest0



*e

xtreg l_c l_q l_pf lf, fe

estimates store fixed_eff

xtreg l_c l_q l_pf lf, re

estimates store random_eff

hausman fixed_eff random_eff




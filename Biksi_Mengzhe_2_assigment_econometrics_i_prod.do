* Second group assignment
* Econometrics I
* BGSE 10/2015, fall term


clear all

set more off

use "Econometrics_i_2_assigment_Production.dta", clear

* 2.a 
* Use nonlinear least squares to get estimates of the elasticities of output
* to labor and capital (see below how to do this with Stata).

nl (valueadd = {alpha} * labor^{beta}* capital^{gama})

* for latex output

outreg2 using 2_a_1.tex, tex replace

* 2.b
* Transform now this nonlinear model by taking logs of value added, labor and 
* capital. Notice that the model now is perfectly linear, so it can be estimated
* by OLS. Do it, and compare the estimates of A, ß and ?. Have these changed much?

gen l_valueadd=log(valueadd)

gen l_labor=log(labor)

gen l_capital=log(capital)

reg l_valueadd l_labor l_capital, r

* for latex output

outreg2 using 2_b.tex, tex replace ctitle(Log-Log with OLS)


* 2.c 
* Test the following hypotheses:
* a. Labor elasticity is equal to 0.3.

test l_labor=.3

* b. Constant returns to scale (ß + ? = 1).

test l_labor+l_capital=1

* c. Labor elasticity is equal to 0.3 and the production function has constant 
* returns to scale.

test (l_labor=.3) (l_labor+l_capital=1)

* 2.d
* Test whether the translog function is more appropriate than the Cobb-Douglas 
* function (so, in a sense, test the linearity of lny or that the Cobb-Douglas 
* function is enough to account for output). Are the coefficients of the translog
* function as easy to interpret as those of the Cobb-Douglas function?

gen half_ln2L=0.5*(l_labor^2)

gen half_ln2K=0.5*(l_capital^2)

gen l_L_l_K=l_labor*l_capital

reg l_valueadd l_labor l_capital half_ln2L half_ln2K l_L_l_K, r

* for latex output

outreg2 using 2_d.tex, tex replace 


reg l_valueadd l_labor l_capital, r


predict errors, residual


estat ovtest

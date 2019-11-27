* First group assignment
* Econometrics
* BGSE 10/2015, fall term

clear all

set more off

import excel "D:\backup\BGSE\1.trimeszter\Econometrics\Bendegúz_István_Biksi.xls", sheet("Car Prices") firstrow



* a.)
* simple regression of the prices on kilometers

reg Car_Price Kilometers

* for latex:

eststo: quietly reg Car_Price Kilometers

esttab using 1_a_2.tex, label star r2() title(Regression table\label{tab1})


* b.)
* the marginal effect of an added kilometer on price

margins, dydx(Kilometers)

* c.)
* get the residuals from the regression from a.)

predict errors, residual


* plot the residuals against kilometers

scatter errors Kilometers

* test wheter there is non-linearity

estat ovtest

* it turns out there are no omitted variables, so there is not non-linearity

* If there would be non-linearity one could do the following:
* Generate a new variable that is the square of kilometers
gen km2=Kilometers^2

* then do the regression with two explanatory variables and the constant term

reg Car_Price Kilometers km2

* the parameter of km2 is not significant on 5% significance level (as expected)


* d.)

* take a look at the pairwaise correlations

pwcorr

* a reasonable good model can be the following:

reg Car_Price Kilometers HP Year Gas_1Diesel_0

* Test whether the new additional variables have significant joint
* explanatory power:

test HP=Year=Gas_1Diesel_0=0

* it turns out that they have significant joint explanatory power

* e.)

* Test the following hypothesis:

* 1. The price of the car goes down by 1200 euros per additional
* year old the car is.

test Year=1200

* This is a bit tricky, because this test tests: wheter the effect of on extra year
* is 1200. Remember as the year goes up the car gets younger,
* so one extra year means one year younger and 1200 plus for the price,
* if the null hypothesis holds (and it does hold).
* So vice versa if year goes down the car gets older and the price lowers.

* 2. The number of CC and ABS have no impact on the price of the car.

test CC=ABS=0

* this works only if one does for instance:

reg Car_Price CC ABS Kilometers HP Year Gas_1Diesel_0

* and then:

test CC=ABS=0

* It turns out that they both have no impact on car prices.

* 3. The effect of having a CD player is the same as the difference between
* a gas and a diesel car.

reg Car_Price CD Kilometers HP Year Gas_1Diesel_0

test CD=Gas_1Diesel_0

* as the p-value is smaller than: 0.05, we can reject the null hypothesis, so
* the effect of having a CD player is NOT the same as the difference between
* a gas and a diesel car.


* 4. Two cars that have the same characteristics except that one has 20000 more
* kilometers but it is of a design 4 years newer will sell for the same price.

test -20000*Kilometers-4*Year=0

* Explanation: Imagine car A with kilometers: x and year: y.
* Now take car B with x+20000 kilometers and y+4 years.
* Prices of the cars are given:
* PRICE(A)=constant+Bkilometers*x+Byear*y+other x's
* PRICE(B)=constant+Bkilometers*(x+20000)+Byear*(y+4)+other x's
* Now the null hypothesis is the following PRICE(A)=PRICE(B)
* If you subtract from PRICE(A) PRICE(B) and equal it with zero, than you get:
* Bkilometers*(-20000)+Byear*(-4)=0, so we have to test this.
* As the p-value of the test is smaller than .05, we can reject the null hypothesis.

* 5. There is no heteroskedasticity problem (White’s test).

estat imtest, white

* As tha p-value is smaller, than .05, we can reject the null hypothesis, so
* heteroscedasticity occurs.

* 6. There is no heteroskedasticity related to YEAR or HP (Breusch-Pagan test).

estat hettest Year HP

* As tha p-value is smaller, than .05, we can reject the null hypothesis, so
* heteroscedasticity occurs.

* f.) Estimate the model with and without robust standard errors. Do the robust
* errors –and, therefore, the conclusions on significance- differ much from
* regular OLS standard errors?

* Model without robust standard errors:

reg Car_Price Kilometers HP Year Gas_1Diesel_0

* Model with robust standard errors:

reg Car_Price Kilometers HP Year Gas_1Diesel_0, r

* The errors are higher in the second model as expected, but the conclusions
* on significance differ not much compared to the regular OLS.

* for latex:
reg Car_Price Kilometers HP Year Gas_1Diesel_0

outreg2 using 1_e_2.tex, tex replace

reg Car_Price Kilometers HP Year Gas_1Diesel_0, r

outreg2 using 1_e_2.tex, tex append

* to combine the two estimates use: append





* g.) 
* Additional horsepower and cars runing with diesel can be sell for higher prices.

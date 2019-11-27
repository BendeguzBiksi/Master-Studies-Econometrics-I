* Second group assignment
* Econometrics I
* BGSE 10/2015, fall term


use "Econometrics_i_2_assigment_Gasoline.dta", clear


*1.a

gen g_pop= g/pop

reg g_pop year pg y pnc puc ppt pd pn ps, r


*1.b

test pnc=puc


*1.c

margins, eyex (pg) atmeans post

outreg2 using 1_c_all.tex, tex replace

margins, eyex (y) atmeans post

outreg2 using 1_c_all.tex, tex append 

margins, eyex (ppt) atmeans post

outreg2 using 1_c_all.tex, tex append 


*1.d

gen l_g_pop=log(g_pop)

gen lnY=log(y)

gen lnPPT=log(ppt)

gen lnPG=log(pg)

gen lnPNC=log(pnc)

gen lnPUC=log(puc)

gen lnPD=log(pd)

gen lnPN=log(pn)

gen lnPS=log(ps)

reg l_g_pop lnPG lnY lnPPT lnPNC lnPUC lnPD lnPN lnPS year, r

outreg2 using 1_d_1.tex, tex replace









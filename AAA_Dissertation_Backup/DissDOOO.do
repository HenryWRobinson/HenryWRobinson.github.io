clear all
capture log close
cd "/Users/henryrobinson/Desktop/3rd year/AED/Stata"
log using "DissLog1.log", replace

*merge 3 datasets
use "data_Set_vote.dta", clear
sort id year
save "exp_data_vote.dta", replace
use "data_Set_radio.dta"
sort id year 
merge 1:1 id year using "exp_data_vote.dta", generate(_merge1)
save "exp_merge_vote_radio.dta", replace
clear all
use "data_Set_socio_demo.dta", clear
sort id year
merge 1:1 id year using "exp_merge_vote_radio.dta", generate(_merge2)
save "exp_big_merge.dta", replace

*remove blank outliers?
drop if calendar_year == "19"

*create dummy variables for each year
//tabulate calendar_year, generate(dcalendar_year)
//rename (dcalendar_year*) (d1920 d1924 d1928 d1930 d1932 d1933 d1934 d1935 d1936 d1937 d1938)


//gen slant = 1 
//replace slant = 0 if calendar_year != ("1928")
//replace slant = -1 if calendar_year != ("1930" "1932")


*regress
encode year, gen(year_enc)
// Election dates June1920 Dec1924 May1928 Sept1930 July1932 Nov1932 Mar1933
// n206 n24d n285 n309 n327 n32n n333
// 1)n206 2)n245 3)n24d 4)n285 5)n309 6)n327 7)n32n 8)n333 9)n337 10)n346 11)n351 12)n355 13)n366 14)n373 15)n387 
// elections in 1) 3) 4) 5) 6) 7) 8)
// drop 2) 9) 10) 11) 12) 13) 14) 15) (also 1 and 3 since outside time we are concerned with)
drop if year_enc == 1 | year_enc == 2 | year_enc == 3 | year_enc == 9 | year_enc == 10 | year_enc == 11 | year_enc == 12 | year_enc == 13 | year_enc == 14 | year_enc == 15

tab year_enc, gen(dyear_enc)
forval x=1/5{
	gen pop_`x' = pops * dyear_enc`x'
	gen pop_2_`x' = pops_2 * dyear_enc`x'
	gen pop_3_`x' = pops_3 * dyear_enc`x'
	gen pop_4_`x' = pops_4 * dyear_enc`x'
	gen pop_5_`x' = pops_5 * dyear_enc`x'
	gen juden_share`x' = c25juden_share * dyear_enc`x'
	gen kath_share`x' = c25kath_share * dyear_enc`x'
	gen arbei_share`x' = c25arbei_share * dyear_enc`x'
	gen anges_share`x' = c25anges_share * dyear_enc`x'
	gen city`x' = city * dyear_enc`x'
	gen war_per1000_`x' = war_per1000 * dyear_enc`x'
	gen in_welfare_per1000_`x' = in_welfare_per1000 * dyear_enc`x'
	gen sozialrentner_per1000_`x' = sozialrentner_per1000 * dyear_enc`x'
	gen logtaxprop`x' = logtaxprop * dyear_enc`x'
	gen altitude`x' = altitude * dyear_enc`x'
	gen erlos_share`x' = c33erlos_share * dyear_enc`x'
	gen brlos_share`x' = c33brlos_share * dyear_enc`x'
	gen bigd`x' = bigd * dyear_enc`x'
	gen turnout24_`x' = turnout24 * dyear_enc`x'
	gen vote24_`x' = vote24 * dyear_enc`x'
	gen nsfb24_`x' = nsfb24 * dyear_enc`x'
	gen spd24_`x' = spd24 * dyear_enc`x'
	gen z24_`x' = z24 * dyear_enc`x'
	}
	
tab wkr, gen(dwkr)
	
forval x=1/34{
	gen wkr_285_`x' = dwkr`x' * dyear_enc1
	gen wkr_309_`x' = dwkr`x' * dyear_enc2
	gen wkr_327_`x' = dwkr`x' * dyear_enc3
	gen wkr_32n_`x' = dwkr`x' * dyear_enc4
	gen wkr_333_`x' = dwkr`x' * dyear_enc5
}

xtset id year_enc

//xtreg Nazi_share ss ///
//pop_1-wkr_333_34 ///
//i.year_enc if year_enc == [ 5 | 6 | 7 ], fe cluster(id)

*Column 1
xtreg Nazi_share ss ///
pop_2 pop_3 pop_4 ///
pop_2_2 pop_2_3 pop_2_4 ///
pop_3_2 pop_3_3 pop_3_4 ///
pop_4_2 pop_4_3 pop_4_4 ///
pop_5_2 pop_5_3 pop_5_4 ///
juden_share2 juden_share3 juden_share4 ///
kath_share2 kath_share3 kath_share4 ///
arbei_share2 arbei_share3 arbei_share4 ///
anges_share2 anges_share3 anges_share4 ///
city2 city3 city4 ///
war_per1000_2 war_per1000_3 war_per1000_4 ///
in_welfare_per1000_2 in_welfare_per1000_3 in_welfare_per1000_4 ///
sozialrentner_per1000_2 sozialrentner_per1000_3 sozialrentner_per1000_4 ///
logtaxprop2 logtaxprop3 logtaxprop4 ///
altitude2 altitude3 altitude4 ///
erlos_share2 erlos_share3 erlos_share4 ///
brlos_share2 brlos_share3 brlos_share4 ///
bigd2 bigd3 bigd4 ///
turnout24_2 turnout24_3 turnout24_4 ///
vote24_2 vote24_3 vote24_4 ///
nsfb24_2 nsfb24_3 nsfb24_4 ///
spd24_2 spd24_3 spd24_4 ///
z24_2 z24_3 z24_4 ///
wkr_309_1 wkr_309_2 wkr_309_3 wkr_309_4 wkr_309_5 wkr_309_6 wkr_309_7 wkr_309_8 wkr_309_9 wkr_309_10 wkr_309_11 wkr_309_12 wkr_309_13 wkr_309_14 wkr_309_15 wkr_309_16 wkr_309_17 wkr_309_18 wkr_309_19 wkr_309_20 wkr_309_21 wkr_309_22 wkr_309_23 wkr_309_24 wkr_309_25 wkr_309_26 wkr_309_27 wkr_309_28 wkr_309_29 wkr_309_30 wkr_309_31 wkr_309_32 wkr_309_33 wkr_309_34 ///
wkr_327_1 wkr_327_2 wkr_327_3 wkr_327_4 wkr_327_5 wkr_327_6 wkr_327_7 wkr_327_8 wkr_327_9 wkr_327_10 wkr_327_11 wkr_327_12 wkr_327_13 wkr_327_14 wkr_327_15 wkr_327_16 wkr_327_17 wkr_327_18 wkr_327_19 wkr_327_20 wkr_327_21 wkr_327_22 wkr_327_23 wkr_327_24 wkr_327_25 wkr_327_26 wkr_327_27 wkr_327_28 wkr_327_29 wkr_327_30 wkr_327_31 wkr_327_32 wkr_327_33 wkr_327_34 ///
wkr_32n_1 wkr_32n_2 wkr_32n_3 wkr_32n_4	wkr_32n_5 wkr_32n_6	wkr_32n_7 wkr_32n_8	wkr_32n_9 wkr_32n_10 wkr_32n_11	wkr_32n_12 wkr_32n_13 wkr_32n_14 wkr_32n_15	wkr_32n_16 wkr_32n_17	wkr_32n_18 wkr_32n_19 wkr_32n_20 wkr_32n_21	wkr_32n_22 wkr_32n_23 wkr_32n_24 wkr_32n_25	wkr_32n_26 wkr_32n_27 wkr_32n_28 wkr_32n_29	wkr_32n_30 wkr_32n_31 wkr_32n_32 wkr_32n_33	wkr_32n_34 i.year_enc if year_enc==5|year_enc==6|year_enc==7, fe cluster(id) ///

*Column 2
xtreg Nazi_share ss_nl ///
pop_2 pop_3 pop_4 ///
pop_2_2 pop_2_3 pop_2_4 ///
pop_3_2 pop_3_3 pop_3_4 ///
pop_4_2 pop_4_3 pop_4_4 ///
pop_5_2 pop_5_3 pop_5_4 ///
juden_share2 juden_share3 juden_share4 ///
kath_share2 kath_share3 kath_share4 ///
arbei_share2 arbei_share3 arbei_share4 ///
anges_share2 anges_share3 anges_share4 ///
city2 city3 city4 ///
war_per1000_2 war_per1000_3 war_per1000_4 ///
in_welfare_per1000_2 in_welfare_per1000_3 in_welfare_per1000_4 ///
sozialrentner_per1000_2 sozialrentner_per1000_3 sozialrentner_per1000_4 ///
logtaxprop2 logtaxprop3 logtaxprop4 ///
altitude2 altitude3 altitude4 ///
erlos_share2 erlos_share3 erlos_share4 ///
brlos_share2 brlos_share3 brlos_share4 ///
bigd2 bigd3 bigd4 ///
turnout24_2 turnout24_3 turnout24_4 ///
vote24_2 vote24_3 vote24_4 ///
nsfb24_2 nsfb24_3 nsfb24_4 ///
spd24_2 spd24_3 spd24_4 ///
z24_2 z24_3 z24_4 ///
wkr_309_1 wkr_309_2 wkr_309_3 wkr_309_4 wkr_309_5 wkr_309_6 wkr_309_7 wkr_309_8 wkr_309_9 wkr_309_10 wkr_309_11 wkr_309_12 wkr_309_13 wkr_309_14 wkr_309_15 wkr_309_16 wkr_309_17 wkr_309_18 wkr_309_19 wkr_309_20 wkr_309_21 wkr_309_22 wkr_309_23 wkr_309_24 wkr_309_25 wkr_309_26 wkr_309_27 wkr_309_28 wkr_309_29 wkr_309_30 wkr_309_31 wkr_309_32 wkr_309_33 wkr_309_34 ///
wkr_327_1 wkr_327_2 wkr_327_3 wkr_327_4 wkr_327_5 wkr_327_6 wkr_327_7 wkr_327_8 wkr_327_9 wkr_327_10 wkr_327_11 wkr_327_12 wkr_327_13 wkr_327_14 wkr_327_15 wkr_327_16 wkr_327_17 wkr_327_18 wkr_327_19 wkr_327_20 wkr_327_21 wkr_327_22 wkr_327_23 wkr_327_24 wkr_327_25 wkr_327_26 wkr_327_27 wkr_327_28 wkr_327_29 wkr_327_30 wkr_327_31 wkr_327_32 wkr_327_33 wkr_327_34 ///
wkr_32n_1 wkr_32n_2 wkr_32n_3 wkr_32n_4	wkr_32n_5 wkr_32n_6	wkr_32n_7 wkr_32n_8	wkr_32n_9 wkr_32n_10 wkr_32n_11	wkr_32n_12 wkr_32n_13 wkr_32n_14 wkr_32n_15	wkr_32n_16 wkr_32n_17	wkr_32n_18 wkr_32n_19 wkr_32n_20 wkr_32n_21	wkr_32n_22 wkr_32n_23 wkr_32n_24 wkr_32n_25	wkr_32n_26 wkr_32n_27 wkr_32n_28 wkr_32n_29	wkr_32n_30 wkr_32n_31 wkr_32n_32 wkr_32n_33	wkr_32n_34 i.year_enc if year_enc==5|year_enc==6|year_enc==7, fe cluster(id) ///

*Column 3
xtreg Nazi_share ss_artf ///
pop_1 pop_2 pop_3 pop_4 pop_5 ///
pop_2_1 pop_2_2 pop_2_3 pop_2_4 pop_2_5 ///
pop_3_1 pop_3_2 pop_3_3 pop_3_4 pop_3_5 ///
pop_4_1 pop_4_2 pop_4_3 pop_4_4 pop_4_5 ///
pop_5_1 pop_5_2 pop_5_3 pop_5_4 pop_5_5 ///
juden_share1 juden_share2 juden_share3 juden_share4 juden_share5 ///
kath_share1 kath_share2 kath_share3 kath_share4 kath_share5 ///
arbei_share1 arbei_share2 arbei_share3 arbei_share4 arbei_share5 ///
anges_share1 anges_share2 anges_share3 anges_share4 anges_share5 ///
city1 city2 city3 city4 city5 ///
war_per1000_1 war_per1000_2 war_per1000_3 war_per1000_4 war_per1000_5 ///
in_welfare_per1000_1 in_welfare_per1000_2 in_welfare_per1000_3 in_welfare_per1000_4 in_welfare_per1000_5 ///
sozialrentner_per1000_1 sozialrentner_per1000_2 sozialrentner_per1000_3 sozialrentner_per1000_4 sozialrentner_per1000_5 ///
logtaxprop1 logtaxprop2 logtaxprop3 logtaxprop4 logtaxprop5 ///
altitude1 altitude2 altitude3 altitude4 altitude5 ///
erlos_share1 erlos_share2 erlos_share3 erlos_share4 erlos_share5 ///
brlos_share1 brlos_share2 brlos_share3 brlos_share4 brlos_share5 ///
bigd1 bigd2 bigd3 bigd4 bigd5 ///
turnout24_1 turnout24_2 turnout24_3 turnout24_4 turnout24_5 ///
vote24_1 vote24_2 vote24_3 vote24_4 vote24_5 ///
nsfb24_1 nsfb24_2 nsfb24_3 nsfb24_4 nsfb24_5 ///
spd24_1 spd24_2 spd24_3 spd24_4 spd24_5 ///
z24_1 z24_2 z24_3 z24_4 z24_5 ///
wkr_285_1 wkr_285_2 wkr_285_3 wkr_285_4 wkr_285_5 wkr_285_6 wkr_285_7 wkr_285_8 wkr_285_9 wkr_285_10 wkr_285_11 wkr_285_12 wkr_285_13 wkr_285_14 wkr_285_15 wkr_285_16 wkr_285_17 wkr_285_18 wkr_285_19 wkr_285_20 wkr_285_21 wkr_285_22 wkr_285_23 wkr_285_24 wkr_285_25 wkr_285_26 wkr_285_27 wkr_285_28 wkr_285_29 wkr_285_30 wkr_285_31 wkr_285_32 wkr_285_33 wkr_285_34 ///
wkr_309_1 wkr_309_2 wkr_309_3 wkr_309_4 wkr_309_5 wkr_309_6 wkr_309_7 wkr_309_8 wkr_309_9 wkr_309_10 wkr_309_11 wkr_309_12 wkr_309_13 wkr_309_14 wkr_309_15 wkr_309_16 wkr_309_17 wkr_309_18 wkr_309_19 wkr_309_20 wkr_309_21 wkr_309_22 wkr_309_23 wkr_309_24 wkr_309_25 wkr_309_26 wkr_309_27 wkr_309_28 wkr_309_29 wkr_309_30 wkr_309_31 wkr_309_32 wkr_309_33 wkr_309_34 ///
wkr_327_1 wkr_327_2 wkr_327_3 wkr_327_4 wkr_327_5 wkr_327_6 wkr_327_7 wkr_327_8 wkr_327_9 wkr_327_10 wkr_327_11 wkr_327_12 wkr_327_13 wkr_327_14 wkr_327_15 wkr_327_16 wkr_327_17 wkr_327_18 wkr_327_19 wkr_327_20 wkr_327_21 wkr_327_22 wkr_327_23 wkr_327_24 wkr_327_25 wkr_327_26 wkr_327_27 wkr_327_28 wkr_327_29 wkr_327_30 wkr_327_31 wkr_327_32 wkr_327_33 wkr_327_34 ///
wkr_32n_1 wkr_32n_2 wkr_32n_3 wkr_32n_4	wkr_32n_5 wkr_32n_6	wkr_32n_7 wkr_32n_8	wkr_32n_9 wkr_32n_10 wkr_32n_11	wkr_32n_12 wkr_32n_13 wkr_32n_14 wkr_32n_15	wkr_32n_16 wkr_32n_17	wkr_32n_18 wkr_32n_19 wkr_32n_20 wkr_32n_21	wkr_32n_22 wkr_32n_23 wkr_32n_24 wkr_32n_25	wkr_32n_26 wkr_32n_27 wkr_32n_28 wkr_32n_29	wkr_32n_30 wkr_32n_31 wkr_32n_32 wkr_32n_33	wkr_32n_34 ///
wkr_333_1 wkr_333_2	wkr_333_3 wkr_333_4	wkr_333_5 wkr_333_6	wkr_333_7 wkr_333_8	wkr_333_9 wkr_333_10 wkr_333_11	wkr_333_12 wkr_333_13 wkr_333_14 wkr_333_15 wkr_333_16 wkr_333_17 wkr_333_18 wkr_333_19 wkr_333_20 wkr_333_21 wkr_333_22 wkr_333_23 wkr_333_24 wkr_333_25 wkr_333_26 wkr_333_27 wkr_333_28 wkr_333_29 wkr_333_30 wkr_333_31 wkr_333_32 wkr_333_33 wkr_333_34, fe cluster(id) ///

*Column 4
xtreg Nazi_share ss_nl_artf ///
pop_1 pop_2 pop_3 pop_4 pop_5 ///
pop_2_1 pop_2_2 pop_2_3 pop_2_4 pop_2_5 ///
pop_3_1 pop_3_2 pop_3_3 pop_3_4 pop_3_5 ///
pop_4_1 pop_4_2 pop_4_3 pop_4_4 pop_4_5 ///
pop_5_1 pop_5_2 pop_5_3 pop_5_4 pop_5_5 ///
juden_share1 juden_share2 juden_share3 juden_share4 juden_share5 ///
kath_share1 kath_share2 kath_share3 kath_share4 kath_share5 ///
arbei_share1 arbei_share2 arbei_share3 arbei_share4 arbei_share5 ///
anges_share1 anges_share2 anges_share3 anges_share4 anges_share5 ///
city1 city2 city3 city4 city5 ///
war_per1000_1 war_per1000_2 war_per1000_3 war_per1000_4 war_per1000_5 ///
in_welfare_per1000_1 in_welfare_per1000_2 in_welfare_per1000_3 in_welfare_per1000_4 in_welfare_per1000_5 ///
sozialrentner_per1000_1 sozialrentner_per1000_2 sozialrentner_per1000_3 sozialrentner_per1000_4 sozialrentner_per1000_5 ///
logtaxprop1 logtaxprop2 logtaxprop3 logtaxprop4 logtaxprop5 ///
altitude1 altitude2 altitude3 altitude4 altitude5 ///
erlos_share1 erlos_share2 erlos_share3 erlos_share4 erlos_share5 ///
brlos_share1 brlos_share2 brlos_share3 brlos_share4 brlos_share5 ///
bigd1 bigd2 bigd3 bigd4 bigd5 ///
turnout24_1 turnout24_2 turnout24_3 turnout24_4 turnout24_5 ///
vote24_1 vote24_2 vote24_3 vote24_4 vote24_5 ///
nsfb24_1 nsfb24_2 nsfb24_3 nsfb24_4 nsfb24_5 ///
spd24_1 spd24_2 spd24_3 spd24_4 spd24_5 ///
z24_1 z24_2 z24_3 z24_4 z24_5 ///
wkr_285_1 wkr_285_2 wkr_285_3 wkr_285_4 wkr_285_5 wkr_285_6 wkr_285_7 wkr_285_8 wkr_285_9 wkr_285_10 wkr_285_11 wkr_285_12 wkr_285_13 wkr_285_14 wkr_285_15 wkr_285_16 wkr_285_17 wkr_285_18 wkr_285_19 wkr_285_20 wkr_285_21 wkr_285_22 wkr_285_23 wkr_285_24 wkr_285_25 wkr_285_26 wkr_285_27 wkr_285_28 wkr_285_29 wkr_285_30 wkr_285_31 wkr_285_32 wkr_285_33 wkr_285_34 ///
wkr_309_1 wkr_309_2 wkr_309_3 wkr_309_4 wkr_309_5 wkr_309_6 wkr_309_7 wkr_309_8 wkr_309_9 wkr_309_10 wkr_309_11 wkr_309_12 wkr_309_13 wkr_309_14 wkr_309_15 wkr_309_16 wkr_309_17 wkr_309_18 wkr_309_19 wkr_309_20 wkr_309_21 wkr_309_22 wkr_309_23 wkr_309_24 wkr_309_25 wkr_309_26 wkr_309_27 wkr_309_28 wkr_309_29 wkr_309_30 wkr_309_31 wkr_309_32 wkr_309_33 wkr_309_34 ///
wkr_327_1 wkr_327_2 wkr_327_3 wkr_327_4 wkr_327_5 wkr_327_6 wkr_327_7 wkr_327_8 wkr_327_9 wkr_327_10 wkr_327_11 wkr_327_12 wkr_327_13 wkr_327_14 wkr_327_15 wkr_327_16 wkr_327_17 wkr_327_18 wkr_327_19 wkr_327_20 wkr_327_21 wkr_327_22 wkr_327_23 wkr_327_24 wkr_327_25 wkr_327_26 wkr_327_27 wkr_327_28 wkr_327_29 wkr_327_30 wkr_327_31 wkr_327_32 wkr_327_33 wkr_327_34 ///
wkr_32n_1 wkr_32n_2 wkr_32n_3 wkr_32n_4	wkr_32n_5 wkr_32n_6	wkr_32n_7 wkr_32n_8	wkr_32n_9 wkr_32n_10 wkr_32n_11	wkr_32n_12 wkr_32n_13 wkr_32n_14 wkr_32n_15	wkr_32n_16 wkr_32n_17	wkr_32n_18 wkr_32n_19 wkr_32n_20 wkr_32n_21	wkr_32n_22 wkr_32n_23 wkr_32n_24 wkr_32n_25	wkr_32n_26 wkr_32n_27 wkr_32n_28 wkr_32n_29	wkr_32n_30 wkr_32n_31 wkr_32n_32 wkr_32n_33	wkr_32n_34 ///
wkr_333_1 wkr_333_2	wkr_333_3 wkr_333_4	wkr_333_5 wkr_333_6	wkr_333_7 wkr_333_8	wkr_333_9 wkr_333_10 wkr_333_11	wkr_333_12 wkr_333_13 wkr_333_14 wkr_333_15 wkr_333_16 wkr_333_17 wkr_333_18 wkr_333_19 wkr_333_20 wkr_333_21 wkr_333_22 wkr_333_23 wkr_333_24 wkr_333_25 wkr_333_26 wkr_333_27 wkr_333_28 wkr_333_29 wkr_333_30 wkr_333_31 wkr_333_32 wkr_333_33 wkr_333_34, fe cluster(id) ///


log close

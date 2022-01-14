clear all 
set more off 
 
cd "/Users/henryrobinson/Desktop/3rd year/AED/Stata"
 
capture log close 
 
log using "fianltestdiss.log", replace 
 
use "data_Set_radio.dta" , clear 
 
*Then merge to second dataset, drop _merge and merge to third by observation* 
 
merge 1:1 _n using "/Users/henryrobinson/Desktop/3rd year/AED/Stata/data_Set_socio_demo.dta" 
 
drop _merge  
 
merge 1:1 _n using "/Users/henryrobinson/Desktop/3rd year/AED/Stata/data_Set_vote.dta" 
 
save merged_data, replace 
 
*Destring year variable 
encode year, generate(yearDes) 
 
*Remove years that are irrelevant 
drop if yearDes==1 | yearDes == 2 | yearDes == 3 | yearDes == 9 | yearDes == 10 | yearDes == 11 | yearDes == 12 | yearDes == 13 | yearDes == 14 | yearDes == 15
 
*Remove outlier from inspection 
drop if calendar_year =="19" 
 
*Create dummy variables for each year 
ta yearDes, gen(yeardum) 
 
*Create FE controls by multiplying election dummies by controls 

forval x=1/5{
	gen pop_`x' = pops * yeardum`x'
	gen pop_2_`x' = pops_2 * yeardum`x'
	gen pop_3_`x' = pops_3 * yeardum`x'
	gen pop_4_`x' = pops_4 * yeardum`x'
	gen pop_5_`x' = pops_5 * yeardum`x'
	gen jewishpop`x' = c25juden_share * yeardum`x'
	gen cathpop`x' = c25kath_share * yeardum`x'
	gen bluecollar`x' = c25arbei_share * yeardum`x'
	gen whitecollar`x' = c25anges_share * yeardum`x'
	gen city`x' = city * yeardum`x'
	gen warparticipant`x' = war_per1000 * yeardum`x'
	gen welfare`x' = in_welfare_per1000 * yeardum`x'
	gen socialrent`x' = sozialrentner_per1000 * yeardum`x'
	gen proptax`x' = logtaxprop * yeardum`x'
	gen altitude`x' = altitude * yeardum`x'
	gen unemployed`x' = c33erlos_share * yeardum`x'
	gen partemploy`x' = c33brlos_share * yeardum`x'
	gen bigd`x' = bigd * yeardum`x'
	gen turnout`x' = turnout24 * yeardum`x'
	gen dnvpshare`x' = vote24 * yeardum`x'
	gen nsfpshare`x' = nsfb24 * yeardum`x'
	gen spdshare`x' = spd24 * yeardum`x'
	gen zentrumshare`x' = z24 * yeardum`x'
	} 
 
*Loop for Wahlkreis 
 
forval x=1/35{ 
gen wkr`x'=1 if wkr==`x' 
replace wkr`x'=0 if wkr!=`x' 
} 
 
*Generate local fixed effects for Wahlkreis 
forval x=1/35{ 
 
gen wkr`x'_1928=wkr`x'*yeardum1 
gen wkr`x'_1930=wkr`x'*yeardum2 
gen wkr`x'_1932_jul=wkr`x'*yeardum3 
gen wkr`x'_1932_nov=wkr`x'*yeardum4 
gen wkr`x'_1933=wkr`x'*yeardum5 
} 
  
*Tell Stata that this is panel data 
xtset id yearDes 
 
*Column 1 regression 
 
xtreg Nazi_share ss /* 
*/ pop_2 pop_3 pop_4 pop_2_2 pop_2_3 pop_2_4 pop_3_2 pop_3_3 pop_3_4 pop_4_2 pop_4_3 pop_4_4 pop_5_2 pop_5_3 pop_5_4/* 
*/ jewishpop2 jewishpop3 jewishpop4 cathpop2 cathpop3 cathpop4 /* 
*/ bluecollar2 bluecollar3 bluecollar4 whitecollar2 whitecollar3 whitecollar4 warparticipant2 warparticipant3 warparticipant4 welfare2 welfare3 welfare4 socialrent2 socialrent3 socialrent4 /* 
*/ city2 city3 city4 proptax2 proptax3 proptax4 altitude2 altitude3 altitude4 unemployed2 unemployed3 unemployed4 partemploy2 partemploy3 partemploy4 bigd2 bigd3 bigd4 /* 
*/ turnout2 turnout3 turnout4 dnvpshare2 dnvpshare3 dnvpshare4 nsfpshare2 nsfpshare3 nsfpshare4 spdshare2 spdshare3 spdshare4 zentrumshare2 zentrumshare3 zentrumshare4 /* 
*/ wkr*_1930 wkr*_1932_jul wkr*_1932_nov /* 
*/i.yearDes if yearDes==5|yearDes==6|yearDes==7, fe cluster(id) 
 
*install outreg2
ssc install outreg2

*Table for column 1 
outreg2 Nazi_share ss estimates save "Table3_replica.doc" using "Table3_replica.doc", title(RADIO AVAILABILITY AND VOTING FOR THE NAZIS: DISTRICT FIXED EFFECTS) replace ctitle("", Nazi Vote Share,"",September 1930 July 1932 and November 1932,"", Panel: OLS) keep(ss) addtext (Baseline controls interacted with time fixed effects, Yes, Baseline controls, No, District fixed effects, Yes, Time fixed effects, Yes) 
 
*Regression for Column 2 
 
xtreg Nazi_share ss_nl /* 
*/ pop_2 pop_3 pop_4 pop_2_2 pop_2_3 pop_2_4 pop_3_2 pop_3_3 pop_3_4 pop_4_2 pop_4_3 pop_4_4 pop_5_2 pop_5_3 pop_5_4/* 
*/ jewishpop2 jewishpop3 jewishpop4 cathpop2 cathpop3 cathpop4 /* 
*/ bluecollar2 bluecollar3 bluecollar4 whitecollar2 whitecollar3 whitecollar4 warparticipant2 warparticipant3 warparticipant4 welfare2 welfare3 welfare4 socialrent2 socialrent3 socialrent4 /* 
*/ city2 city3 city4 proptax2 proptax3 proptax4 altitude2 altitude3 altitude4 unemployed2 unemployed3 unemployed4 partemploy2 partemploy3 partemploy4 bigd2 bigd3 bigd4 /* 
*/ turnout2 turnout3 turnout4 dnvpshare2 dnvpshare3 dnvpshare4 nsfpshare2 nsfpshare3 nsfpshare4 spdshare2 spdshare3 spdshare4 zentrumshare2 zentrumshare3 zentrumshare4 /* 
*/ wkr*_1930 wkr*_1932_jul wkr*_1932_nov /* 
*/i.yearDes if yearDes==5|yearDes==6|yearDes==7, fe cluster(id) 
 
*Table for column 2 
outreg2 Nazi_share ss_nl est save "Table3_replica.doc" using "Table3_replica.doc", append ctitle( Panel: OLS) keep(ss_nl) addtext (Baseline controls interacted with time fixed effects, Yes, Baseline controls, No, District fixed effects, Yes, Time fixed effects, Yes) 
 
*Regression for column 3 
 
xtreg Nazi_share ss_artf /* 
*/ pop_1 pop_2 pop_3 pop_4 pop_5 pop_2_1 pop_2_2 pop_2_3 pop_2_4 pop_2_5 pop_3_1 pop_3_2 pop_3_3 pop_3_4 pop_3_5 pop_4_1 pop_4_2 pop_4_3 pop_4_4 pop_4_5 pop_5_1 pop_5_2 pop_5_3 pop_5_4 pop_5_5/* Socio-economic and geographical factors 
*/ jewishpop1 jewishpop2 jewishpop3 jewishpop4 jewishpop5 cathpop1 cathpop2 cathpop3 cathpop4 cathpop5 bluecollar1 bluecollar2 bluecollar3 bluecollar4 bluecollar5 whitecollar1 whitecollar2 whitecollar3 whitecollar4 whitecollar5 city1 city2 city3 city4 city5 warparticipant1 warparticipant2 warparticipant3 warparticipant4 warparticipant5 welfare1 welfare2 welfare3 welfare4 welfare5 socialrent1 socialrent2 socialrent3 socialrent4 socialrent5 proptax1 proptax2 proptax3 proptax4 proptax5 altitude1 altitude2 altitude3 altitude4 altitude5 unemployed1 unemployed2 unemployed3 unemployed4 unemployed5 partemploy1 partemploy2 partemploy3 partemploy4 partemploy5 bigd1 bigd2 bigd3 bigd4 bigd5 /* 
*/ turnout1 turnout2 turnout3 turnout4 turnout5 dnvpshare1 dnvpshare2 dnvpshare3 dnvpshare4 dnvpshare5 nsfpshare1 nsfpshare2 nsfpshare3 nsfpshare4 nsfpshare5 spdshare1 spdshare2 spdshare3 spdshare4 spdshare5 zentrumshare1 zentrumshare2 zentrumshare3 zentrumshare4 zentrumshare5 /* 
*/ wkr*_* /*  
*/ i.yearDes, fe cluster(id) 
 
*Table for Column 3 
outreg2 Nazi_share ss_artf est save "Table3_replica.doc" using "Table3_replica.doc", append ctitle("", Nazi Vote Share,"",All parliamentary elections 1928-1933,"", Panel: OLS) keep(ss_artf) addtext (Baseline controls interacted with time fixed effects, Yes, Baseline controls, No, District fixed effects, Yes, Time fixed effects, Yes) 
 
*Regression for Column 4 
xtreg Nazi_share ss_nl_artf /* 
*/ pop_1 pop_2 pop_3 pop_4 pop_5 pop_2_1 pop_2_2 pop_2_3 pop_2_4 pop_2_5 pop_3_1 pop_3_2 pop_3_3 pop_3_4 pop_3_5 pop_4_1 pop_4_2 pop_4_3 pop_4_4 pop_4_5 pop_5_1 pop_5_2 pop_5_3 pop_5_4 pop_5_5/* Socio-economic and geographical factors 
*/ jewishpop1 jewishpop2 jewishpop3 jewishpop4 jewishpop5 cathpop1 cathpop2 cathpop3 cathpop4 cathpop5 bluecollar1 bluecollar2 bluecollar3 bluecollar4 bluecollar5 whitecollar1 whitecollar2 whitecollar3 whitecollar4 whitecollar5 city1 city2 city3 city4 city5 warparticipant1 warparticipant2 warparticipant3 warparticipant4 warparticipant5 welfare1 welfare2 welfare3 welfare4 welfare5 socialrent1 socialrent2 socialrent3 socialrent4 socialrent5 proptax1 proptax2 proptax3 proptax4 proptax5 altitude1 altitude2 altitude3 altitude4 altitude5 unemployed1 unemployed2 unemployed3 unemployed4 unemployed5 partemploy1 partemploy2 partemploy3 partemploy4 partemploy5 bigd1 bigd2 bigd3 bigd4 bigd5 /* 
*/ turnout1 turnout2 turnout3 turnout4 turnout5 dnvpshare1 dnvpshare2 dnvpshare3 dnvpshare4 dnvpshare5 nsfpshare1 nsfpshare2 nsfpshare3 nsfpshare4 nsfpshare5 spdshare1 spdshare2 spdshare3 spdshare4 spdshare5 zentrumshare1 zentrumshare2 zentrumshare3 zentrumshare4 zentrumshare5 /* 
*/ wkr*_* /*  
*/ i.yearDes, fe cluster(id) 
 
*Table Column 4 
 
outreg2 Nazi_share ss_nl_artf est save "Table3_replica.doc" using "Table3_replica.doc", append ctitle("", Nazi Vote Share,"",All parliamentary elections 1928-1933,"", Panel: OLS) keep(ss_nl_artf) addtext (Baseline controls interacted with time fixed effects, Yes, Baseline controls, No, District fixed effects, Yes, Time fixed effects, Yes) 
 
*Graph - edited in graph editor 
 
twoway qfitci Nazi_share ss_nl_artf 

//1
xtreg Nazi_share ss_artf pop_1-wkr35_1933 i.yearDes, fe cluster(id)
//2
xtreg Nazi_share ss_nl_artf pop_1-wkr35_1933 i.yearDes, fe cluster(id) 



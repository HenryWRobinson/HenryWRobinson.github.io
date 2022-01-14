clear all
set more off
capture log close 
cd "/Users/henryrobinson/Desktop/3rd year/AED/Stata"
use "FoxNewsFinalDataQJE.dta", clear
//first must drop observations to leave relevant ones
//1)multiple cable providers
drop if nocable2000>1 & foxnewsmix2000==1 & foxnews2000==.
//2)uncomparable if no CNN
drop if cnn2000!=1
//3)precint changes
gen precchange = (noprec2000-noprec1996)/noprec1996 
replace precchange = precchange * (-1) if precchange<0
drop if precchange>0.2 & state!="Mi" & state!="Nh" & state!="Ny" & state!="Oh" & state!="Ri" & state!="Ut" 
//4)vote changes
gen votechange = (totpresvotes2000-totpresvotes1996)/totpresvotes1996
replace votechange = votechange * (-1) if votechange<0
drop if votechange>1 

//(III)(1)
reg foxnews2000 reppresfv2p1996 totpreslvpop1996 [aweight=totpresvotes1996], cluster(account2000)

//(III)(2)
reg foxnews2000 reppresfv2p1996 totpreslvpop1996 /*
*/pop2000 hs2000 hsp2000 college2000 male2000 black2000 hisp2000 empl2000 unempl2000 married2000 income2000 urban2000 /*
*/pop00m90 hs00m90 hsp00m90 college00m90 male00m90 black00m90 hisp00m90 empl00m90 unempl00m90 married00m90 income00m90 urban00m90 [aweight=totpresvotes1996], cluster(account2000)

outreg2 using myreg1.doc, replace ctitle() keep(reppresfv2p1996 totpreslvpop1996) addtext(Census controls: 1990 and 2000, Yes,Cable system controls, No,U.S. House district fixed effects, No)


//(IV)(1)
reg reppresfv2p00m96 foxnews2000 [aweight=totpresvotes1996], cluster(account2000)

//(IV)(2)
reg reppresfv2p00m96 foxnews2000 /*
*/pop2000 hs2000 hsp2000 college2000 male2000 black2000 hisp2000 empl2000 unempl2000 married2000 income2000 urban2000 /*
*/pop00m90 hs00m90 hsp00m90 college00m90 male00m90 black00m90 hisp00m90 empl00m90 unempl00m90 married00m90 income00m90 urban00m90 [aweight=totpresvotes1996], cluster(account2000)
/*
*/ //

//(IV) (3)
reg reppresfv2p00m96 foxnews2000 /*
*/pop2000 hs2000 hsp2000 college2000 male2000 black2000 hisp2000 empl2000 unempl2000 married2000 income2000 urban2000 /*
*/pop00m90 hs00m90 hsp00m90 college00m90 male00m90 black00m90 hisp00m90 empl00m90 unempl00m90 married00m90 income00m90 urban00m90 /*
*/poptot2000d** noch2000d** [aweight=totpresvotes1996], cluster(account2000)

ta diststate, gen(housedum)

//(IV)(4)
reg reppresfv2p00m96 foxnews2000 /*
*/pop2000 hs2000 hsp2000 college2000 male2000 black2000 hisp2000 empl2000 unempl2000 married2000 income2000 urban2000 /*
*/pop00m90 hs00m90 hsp00m90 college00m90 male00m90 black00m90 hisp00m90 empl00m90 unempl00m90 married00m90 income00m90 urban00m90 /*
*/poptot2000d** noch2000d** housedum*** [aweight=totpresvotes1996], cluster(account2000)

//Swing State interaction
reg reppresfv2p00m96 foxnews2000 fox2000reppresfv2pwdstd22000 reppresfv2pwdstd22000 /*
*/pop2000 hs2000 hsp2000 college2000 male2000 black2000 hisp2000 empl2000 unempl2000 married2000 income2000 urban2000 /*
*/pop00m90 hs00m90 hsp00m90 college00m90 male00m90 black00m90 hisp00m90 empl00m90 unempl00m90 married00m90 income00m90 urban00m90 /*
*/poptot2000d** noch2000d** housedum*** [aweight=totpresvotes1996], cluster(account2000)

capture log close

clear all
set more off
capture log close 
cd "/Users/henryrobinson/Desktop/3rd year/DATA SCIENCE/StataDS"
insheet using "Week9RegCovCasebyPub.csv", comma names clear
drop v1 areatype areacode areaname
generate date1 = daily(date, "YMD")
format date1 %td
save "Week9RegCovCasebyPub.dta", replace
clear all
insheet using "Week9RegEasyJetStockPrice.csv", comma names clear
drop v vw o h l n
gen t1 = (t + 3.1562e+11)
gen date1 = dofC(t1)
format date1 %td
drop t t1
merge 1:1 date1 using "Week9RegCovCasebyPub.dta"
gen c1 = c*10
graph twoway (lfitci c1 newcasesbypublishdate) (scatter c1 newcasesbypublishdate), title("Regression of EasyJet Plc's share value and UK Covid Cases") xtitle("UK Covid Cases by Publish Date") ytitle("Closing Price for EasyJet Plc in pence")
graph export "/Users/henryrobinson/Desktop/3rd year/DATA SCIENCE/StataDS/Week9Regres
> siongraph.png", as(png) name("Graph")

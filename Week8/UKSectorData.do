clear all
set more off
capture log close 
cd "/Users/henryrobinson/Desktop/3rd year/DATA SCIENCE/StataDS"
insheet using "07247153-6f29-47c4-8410-0f52c4b22991_Data.csv", comma names clear
drop if CountryName != "United Kingdom"
drop CountryName
drop countrycode
drop seriescode
reshape long yr, i(seriesname) j(year)  
rename yr valueaddedGDP
///drop if year < 2010
replace seriesname = substr(seriesname, 1, strpos(seriesname,", value added (% of GDP)")-1)
export delimited using fullUKdatavaladdgdp.csv, replace

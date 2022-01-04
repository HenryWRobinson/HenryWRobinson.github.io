clear all
set more off
capture log close 
cd "/Users/henryrobinson/Desktop/3rd year/DATA SCIENCE/StataDS"
insheet using "aed62460-dedb-4d29-8823-8160231f040b_Data.csv", comma names clear
drop if CountryName != "United Kingdom"
drop CountryName
drop countrycode
drop seriescode
reshape long yr, i(seriesname) j(year)  
rename yr valueaddedGDP
drop if year < 2010
replace seriesname = substr(seriesname, 1, strpos(seriesname,", value added (% of GDP)")-1)
export delimited using UKdatavaladdgdp.csv, replace

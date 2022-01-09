clear


local filepath = "`/Users/henryrobinson/Desktop/3rd year/DATA SCIENCE/StataDS/datafianl/content'" 
di "`/Users/henryrobinson/Desktop/3rd year/DATA SCIENCE/StataDS/datafianl/content'" 

local files : dir "`filepath'" files "*.csv" 
di `"`files'"' 



tempfile master 
save `master', replace empty

foreach x of local files {
    di "`x'" 

	
	qui: import delimited "`x'", delimiter(",")  case(preserve) clear  file
	qui: gen id = subinstr("`x'", ".csv", "", .)	
	
	append using `master'
	save `master', replace
}


order id, first
sort id BNFCode
replace id = subinstr(id, "[", "", .) 
replace id = subinstr(id, "]", "", .) 
replace id = subinstr(id, ",", "", .) 
replace id = subinstr(id, "'", "", .) 
replace id = subinstr(id, "_", "", .)
replace id = subinstr(id, " ", "", .) 
replace id = subinstr(id, ".xlsx", "", .) 
replace id = subinstr(id, ".xls", "", .) 
replace id = subinstr(id, "%", "", .)  
replace id = subinstr(id, "2018", "18", .)  
replace id = subinstr(id, "2017", "17", .)  
replace id = substr(id,-5,.)

save "csv_combined.dta", replace

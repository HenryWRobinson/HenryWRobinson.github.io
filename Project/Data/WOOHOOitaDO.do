clear


local filepath = "`/Users/henryrobinson/Desktop/3rd year/DATA SCIENCE/StataDS/datafianl/content'" 
di "`/Users/henryrobinson/Desktop/3rd year/DATA SCIENCE/StataDS/datafianl/content'" 

local files : dir "`filepath'" files "*.csv" 
di `"`files'"' 



tempfile master 
save `master', replace empty

foreach x of local files {
    di "`x'" 

	
	qui: import delimited "`x'", delimiter(",")  case(preserve) clear
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
replace id = subinstr(id, "20", "2020", .)
replace id = subinstr(id, "08", "2008", .)
replace id = subinstr(id, "09", "2009", .)
replace id = subinstr(id, "10", "2010", .)
replace id = subinstr(id, "11", "2011", .)
replace id = subinstr(id, "12", "2012", .)
replace id = subinstr(id, "13", "2013", .)
replace id = subinstr(id, "14", "2014", .)
replace id = subinstr(id, "15", "2015", .)
replace id = subinstr(id, "16", "2016", .)
replace id = subinstr(id, "17", "2017", .)
replace id = subinstr(id, "18", "2018", .)
replace id = subinstr(id, "19", "2019", .)
replace id = subinstr(id, "21", "2021", .)
replace id = subinstr(id, "Jan", "January ", .)
replace id = subinstr(id, "Feb", "February ", .)
replace id = subinstr(id, "Mar", "March ", .)
replace id = subinstr(id, "Apr", "April ", .)
replace id = subinstr(id, "May", "May ", .)
replace id = subinstr(id, "Jun", "June ", .)
replace id = subinstr(id, "Jul", "July ", .)
replace id = subinstr(id, "Aug", "August ", .)
replace id = subinstr(id, "Sep", "September ", .)
replace id = subinstr(id, "Oct", "October ", .)
replace id = subinstr(id, "Nov", "November ", .)
replace id = subinstr(id, "Dec", "December ", .)
gen year = substr(id,-4,.)
gen month = id
replace month = subinstr(month, "0", "", .) 
replace month = subinstr(month, "1", "", .) 
replace month = subinstr(month, "2", "", .) 
replace month = subinstr(month, "3", "", .) 
replace month = subinstr(month, "4", "", .) 
replace month = subinstr(month, "5", "", .) 
replace month = subinstr(month, "6", "", .)
replace month = subinstr(month, "7", "", .)  
replace month = subinstr(month, "8", "", .) 
replace month = subinstr(month, "9", "", .) 
gen NIC = NetIngredientCostp / 100
replace NIC = NetIngredientCostÂ if NetIngredientCostÂ!=. 

save "csv_combined.dta", replace

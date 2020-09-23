/*==================================================
              1: Append databases
==================================================*/

cd "/Users/javierparada/Documents/Github/Prindex/"

* Create list of files
local filelist : dir "/Users/javierparada/Documents/Fellowship/Data/Prindex/country-data/" files "*.csv"
local filelist : list sort filelist

/* Append files  165,433 observations
clear all
save appended, emptyok replace
foreach file of local filelist {
	import delimited "country-data/`file'", clear
	gen source="`file'"
	append using appended.dta, force
	save appended.dta, replace	
}

save appended.dta, replace	


/*==================================================
              2: Create country names
==================================================*/

use  appended.dta, clear	

split source, p("_download_")
gen NAME_0 = subinstr(source1,"_"," ",.)
drop source1 source2
order prindex_unique_id source NAME_0 
	
replace gender=0 if gender==2

replace NAME_0="Republic of Congo" if NAME_0=="Congo Republic"
replace NAME_0="Cote d'Ivoire" if NAME_0=="Cote dIvoire"
replace NAME_0="Swaziland" if NAME_0=="Eswatini"
replace NAME_0="South Korea" if NAME_0=="Korea Republic"
replace NAME_0="Laos" if NAME_0=="Lao"
replace NAME_0="Macedonia" if NAME_0=="North Macedonia"
replace NAME_0="Russia" if NAME_0=="Russian Federation"
replace NAME_0="Taiwan" if NAME_0=="Taiwan Province of China"
replace NAME_0="United States" if NAME_0=="United States of America"
replace NAME_0="Vietnam" if NAME_0=="Viet Nam"

save appended.dta, replace	

*/

use  appended.dta, clear	

replace NAME_0="Mauritius" if NAME_0=="Mauritius"
replace NAME_0="Congo" if NAME_0=="Republic of Congo"
replace NAME_0="Singapore" if NAME_0=="Singapore"
replace NAME_0="eSwatini" if NAME_0=="Swaziland"
replace NAME_0="United States of America" if NAME_0=="United States"
replace NAME_0="Bosnia and Herz." if NAME_0=="Bosnia and Herzegovina"
replace NAME_0="Côte d'Ivoire" if NAME_0=="Cote d'Ivoire"
replace NAME_0="Dominican Rep." if NAME_0=="Dominican Republic"

save appended.dta, replace	

bysort NAME_0: gen n = _N
collapse (first) n, by(NAME_0)
rename  NAME_0 NAME
gen visited = 1 
save coverage.dta, replace	

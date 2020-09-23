/*==================================================
              1: Append databases
==================================================*/

cd "/Users/javierparada/Documents/Github/Prindex/country-data/"

* Create list of files
local filelist : dir "/Users/javierparada/Documents/Fellowship/Data/Prindex/country-data/" files "*.csv"
local filelist : list sort filelist

* Append files  165,433 observations
clear all
save appended, emptyok replace
foreach file of local filelist {
	import delimited `file', clear
	gen source="`file'"
	append using appended.dta, force
	save appended.dta, replace	
}

save appended.dta, replace	
*/

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

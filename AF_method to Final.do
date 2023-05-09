*****AF method********



clear all
set more off

**Material Deprivation

*d_wall d_floor d_elec d_water d_typtoi d_room  d_house d_floorarea d_tenure d_toil_f d_hhsatis d_hhadq d_tv d_mobile d_clothsat d_clothaqy d_clothbuy

**Socil capital
*d_Talk_rel d_meet_rel d_Talk_frd d_meet_frd d_Talk_neigb d_p_cerom d_p_trip d_p_social d_p_yceromol d_p_socities d_relation d_friend d_feeling1 d_feeling2 d_feeling4 d_feeling5 d_feeling6 d_feeling8 d_f_desci d_f_ideas d_f_relp d_f_dalyW d_f_family d_f_polit d_f_reli d_f_Hwork  d_f_marri d_f_travel

*Human Capital  Deprivation  
*d_edu d_emp d_helth d_ill d_carbo d_Livstk d_puls d_pro d_VitA d_leafy d_fruit d_fat d_food_adq  d_eat_green d_eat_fruit

cd "C:\Users\somji\OneDrive\Desktop\AF_Final"
use "C:\Users\somji\OneDrive\Desktop\AF_Final\Final_AF_imp_6.dta", clear
mdesc d_*
capture log using "Final_AF.smcl",replace

* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------
* UNCENSORED HEADCOUNT RATIOS
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------
global povlist1 "d_wall d_floor d_elec d_water d_typtoi d_room d_house d_floorarea d_tenure d_toil_f d_hhsatis d_hhadq d_tv d_mobile d_clothsat d_clothaqy d_clothbuy"

foreach var in $povlist1 {  

	sum  `var' [aw =finalweight]
	gen	uncen_H_`var' = r(mean)*100
	lab var uncen_H_`var'  "Uncensored Headcount Ratio: Percentage of people who are deprived in …"
	}
	
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------
* SETTING WEIGHTS 
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------

* Define vector 'w' of weights
* Change according to your specification. Remember the sum of weights MUST be 
* equal to 1 or 100%

    
foreach var in d_wall d_floor d_elec d_water d_typtoi d_room  d_house d_floorarea d_tenure d_toil_f d_hhsatis d_hhadq d_tv d_mobile d_clothsat d_clothaqy d_clothbuy {	
	
	gen	w_`var' = 1/17
	lab var w_`var' "Weight `var'"
	}

*gen	w_`var' = 1/42
foreach var in d_Talk_rel d_meet_rel d_Talk_frd d_meet_frd d_Talk_neigb d_p_cerom d_p_trip d_p_social d_p_yceromol d_p_socities d_relation d_friend d_feeling1 d_feeling2 d_feeling4 d_feeling5 d_feeling6 d_feeling8 d_f_desci d_f_ideas d_f_relp d_f_dalyW d_f_family d_f_polit d_f_reli d_f_Hwork  d_f_marri d_f_travel {	
	
	gen	w_`var' = 1/81
	lab var w_`var' "Weight `var'"
	}

*gen	w_`var' = 1/84
foreach var in d_edu d_emp d_helth d_ill d_carbo d_Livstk d_puls d_pro d_VitA d_leafy d_fruit d_fat d_food_adq  d_eat_green d_eat_fruit {	
	
	gen	w_`var' = 1/48
	lab var w_`var' "Weight `var'"
	}
	
	*gen	w_`var' = 1/45
	
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------
* WEIGTHED DEPRIVATION MATRIX 
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------

* The following commands multiply the deprivation matrix by the weight of each 
* indicator.  

foreach var in $povlist1{	

	gen	g0_w_`var' = `var' * w_`var'
	lab var g0_w_`var' "Weigthed Deprivation of `var'"
	}
*
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------
* COUNTING VECTOR
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------

* Generate the vector of individual weighted deprivation score, 'c'
set more off 
egen	c_vector = rowtotal(g0_w_*)
lab var c_vector "Counting Vector"
tab	c_vector [aw =finalweight], m

* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------
* IDENTIFICATION 
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------


* Using different poverty cut-offs (i.e. different k)

forvalue k = 1(1)100 {

	gen	multid_poor_`k' = (c_vector >= `k'/100)
	lab var multid_poor_`k' "Poverty Identification with k=`k'%"
	}

* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------
* CENSORED COUNTING VECTOR
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------

* Generate the censored vector of individual weighted deprivation score, 'c(k)',
* providing a score of zero if a person is not poor

forvalue k = 1(1)100 {

	gen	cens_c_vector_`k' = c_vector
	replace cens_c_vector_`k' = 0 if multid_poor_`k'==0 
	}	

* -----------------------------------------------------------------------------
* M0, H and A 
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------

/*( NOW WE CHOOSE A VALUE OF k )*/
local k = 40


* -----------------------------------------------------------------------------
* HEADCOUNT/INCIDENCE OF MULTIDIMENSIONAL POVERTY (H) 
* -----------------------------------------------------------------------------
*H
local k = 40
*local k = 40
sum	multid_poor_`k' [aw = finalweight]
gen	H = r(mean)*100
lab var H "Headcount Ratio (H): % Population in multidimensional poverty"


* -----------------------------------------------------------------------------
* INTENSITY OF POVERTY AMONG THE POOR(A)
* -----------------------------------------------------------------------------
local k = 40
*local k = 40
sum	cens_c_vector_`k' [aw = finalweight] if multid_poor_`k'==1
gen	A = r(mean)*100
lab var A  "Intensity of deprivation among the poor (A): Average % of weighted deprivations"


* -----------------------------------------------------------------------------
* ADJUSTED HEADCOUNT RATIO (M0)
* -----------------------------------------------------------------------------
local k=40
*local k = 40
sum	cens_c_vector_`k' [aw = finalweight]
gen	M0 = r(mean)
lab var M0 "Adjusted Headcount Ratio (M0 = H*A): Range 0 to 1"


**** 1. H A Mo 33***********
gen domaincode = (district * 10) + sector
svyset psu [pw = finalweight], strata(domaincode)
svy linearized : mean multid_poor_40
svy linearized, subpop(if multid_poor_40 ==1) : mean cens_c_vector_40
svy linearized : mean cens_c_vector_40

capture log close
end
	

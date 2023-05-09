*****Fuzzy Poverty analysis********
*Material Deprivation
clear all
set more off


cd "C:\Users\somji\OneDrive\Desktop\MaterialDep"
use "C:\Users\somji\OneDrive\Desktop\AF_Final\Fuzzy.dta", clear

keep if s1_d3>17

***See the individual fuzzy condidering respondent information in Uva******
capture log using "Fuzzy_Material_dip.smcl"

*--------------------
*Dimension 1
*---------------------
********Housing***********
gen Fzy_Housing_struc =(3- Housing_struc)/(3-1)

recode walls (0 =2) (1=3)
recode walls (2 = 1) (3=0),gen (Fzy_wall)
lab var Fzy_wall "Walls"
lab def Fzy_wall 1 "Semi permanent" 0 "Permanent"
lab val Fzy_wall Fzy_wall

recode  floor (0 =2) (1=3)
recode  floor (2 = 1) (3=0),gen (Fzy_floor)
lab var Fzy_floor " Floor"
lab def Fzy_floor 1 "Semi permanent" 0 "Permanent"
lab val Fzy_floor Fzy_floor

recode  roof (0 =2) (1=3)
recode  roof (2 = 1) (3=0),gen (Fzy_roof)
lab var Fzy_roof " Roof"
lab def Fzy_roof 1 "Semi permanent" 0 "Permanent"
lab val Fzy_roof Fzy_roof

gen room= HHs6_u3x 
gen Fzy_room=(5- room)/(5-0)
drop room

recode  floor_area (1 2 3 =1) (4=2) (5=3) (6 7 8 =4),gen (floorAre2)
gen  Fzy_Fl_area= (4- floorAre2)/(4-1)

gen Fzy_ownership =(5- ownership_h)/(5-1)

gen Fzy_elec=elec_poor
gen Fzy_safedw=safedrnkw
gen Fzy_cookF=cooking_fuel_poor

gen Fzy_Toiletuse =(7- Toilet_use)/(7-1)

gen Fzy_toiTp=toilet_type

gen Fzy_housing_satis =(5- housing_satis)/(5-1)
gen Fzy_Housing_adq =(4- Housing_adq)/(4-1)


*--------------------
*Dimension 2
*---------------------
*******Durable Goods******

recode   HHs8a_a1x (1 = 0) (2=1),gen (Fzy_radio)
recode   HHs8a_a2x (1 = 0) (2=1),gen (Fzy_tv)
recode   HHs8a_a3x (1 = 0) (2=1),gen (Fzy_washmach)
recode   HHs8a_a4x (1 = 0) (2=1),gen (Fzy_refrig)
recode   HHs8a_a5x (1 = 0) (2=1),gen (Fzy_cooker)
recode   HHs8a_a6x (1 = 0) (2=1),gen (Fzy_fan)
recode   HHs8a_a7x (1 = 0) (2=1),gen (Fzy_tel_land)
recode   HHs8a_a8x (1 = 0) (2=1),gen (Fzy_mobile)
recode   HHs8a_a9x (1 = 0) (2=1),gen (Fzy_comp_des)
recode   HHs8a_a10x (1 = 0) (2=1),gen (Fzy_laptop)
recode   HHs8a_a11x (1 = 0) (2=1),gen (Fzy_mo_cycle)
recode   HHs8a_a12x (1 = 0) (2=1),gen (Fzy_threw)
recode   HHs8a_a13x (1 = 0) (2=1),gen (Fzy_car)
recode   HHs8a_a14x (1 = 0) (2=1),gen (Fzy_bus)

*--------------------
*Dimension 3 ;Clothing
*---------------------
*********Basic requirement******
*food*
/*gen Fzy_food_adq= food_adq
gen Fzy_eat_fish =(6- eat_fish)/(6-1)
gen Fzy_eat_green =(6 - eat_green)/(6-1)
gen Fzy_eat_fruit =(6 - eat_fruit)/(6-1)
*/
*cloth*
gen Fzy_clodq=cloth_adq
gen Fzy_closaty  =(5- cloth_saty )/(5-1)
gen Fzy_buyclot  =(5- buy_cloth )/(5-1)

* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------
* RELEVANT SAMPLE
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------

* We construct a filter variable that identifies the observations with info for all relevant indicators 

gen sample = (Fzy_Housing_struc ~=. & Fzy_wall ~=. & Fzy_floor ~=. & Fzy_roof ~=. & Fzy_room ~=. & floorAre2 ~=. & Fzy_Fl_area ~=. & Fzy_ownership ~=. & Fzy_elec ~=. & Fzy_safedw~=. & /*
*/ Fzy_cookF ~=. &  Fzy_toiTp ~=. & Fzy_housing_satis ~=. &  Fzy_Housing_adq ~=. & Fzy_radio ~=. &  Fzy_tv ~=. &  Fzy_washmach ~=. & Fzy_refrig ~=. & Fzy_cooker~=. &  /*
*/Fzy_fan ~=. & Fzy_tel_land ~=. & Fzy_mobile ~=. & Fzy_comp_des ~=. & Fzy_laptop ~=. & Fzy_mo_cycle~=. &  Fzy_threw ~=. & Fzy_bus ~=. &  Fzy_clodq~=. &  Fzy_closaty~=. &  Fzy_buyclot~=.)

* This sample was use for relevant research
/*
gen sample = (Is_saving ~=. & debtness ~=. & employment_status ~=. &  job_satis ~=. & job_knowladge~=. &  health_status ~=. &/*
*/ Blindness~=. &  deafness~=.&  Muteness ~=. & mobility_im ~=. & physical_im ~=. & illness ~=. & health_dec ~=. & food_adq ~=. &/*
 */eat_fish ~=.& eat_green ~=.& eat_fruit ~=.& cloth_adq ~=.& cloth_saty ~=. &  buy_cloth ~=.&  Housing_struc~=.& walls ~=.& floor~=.& roof~=. & HHs6_u3x ~=. & floor_area~=. &/*
 */ownership_h ~=. & elec_poor ~=. & safedrnkw~=. & cooking_fuel_poor~=.& Toilet_use ~=. & toilet_type~=. & housing_satis~=. &/*
 */Housing_adq ~=. & BF_bus_dis ~=. & BF_supmkt_dis~=.&  BF_pre_sch_dis ~=.& BF_Gov_sch_dis~=. & BF_Gov_hosp_dis ~=. & BF_Gov_disp_dis ~=. & /*
 */BF_prvt_disp_dis ~=.  & BF_mcucpc_dis ~=. & BF_dso_dis~=. & BF_po_dis~=. & BF_bank_dis ~=. & BF_ago_dis ~=. & BF_moho_dis ~=. & BF_gno_dis ~=. &/*
 */BF_bus_tim ~=. & BF_supmkt_tim ~=.& BF_pre_sch_tim~=. & BF_Gov_sch_tim ~=. & BF_Gov_hosp_tim ~=. & BF_Gov_disp_tim ~=. & BF_prvt_disp_tim ~=. & /*
 */BF_mcucpc_tim ~=. &  BF_dso_tim~=. & BF_po_tim ~=. & BF_bank_tim ~=.& BF_ago_tim ~=.& BF_moho_tim ~=. & BF_gno_tim ~=. & /*
 */Radio ~=.  & TV ~=. & Wash_Mach ~=. & Refrig ~=. & cookers ~=. &  f_daily_affairs ~=. & f_family_memb ~=. & f_political~=. &  f_religion ~=. & /*
 */f_work ~=. & f_marriage ~=. & f_travelling~=. &  s_properties~=. &  s_forciably~=. &  s_physical~=. &  s_sexual~=. & s_kidnap~=. & /*
 */s_risk~=. & s_home~=. & s_village~=. & s_bus_stop~=. & s_travelling~=. & Exp_adqut~=. & HH_eco_condi~=. & fans~=. & D_telph~=. & /*
 */M_telph~=. & P_comp~=.& L_comp~=.& motor~=.& T_wheel~=.& car~=.& bus~=. & land_owner~=.& resp_sav~=. & socil_protec~=. & Talk_relatives~=. & /*
 */meet_relatives~=. &  Talk_friend~=. & meet_friend~=. & Talk_neighbours~=. & parti_cerom~=. & parti_trip~=. & parti_socialwork~=. & /*
 */parti_yearceromol~=. & parti_socities~=. & close_friend~=. & flood ~=. & drought~=. & earth_slips~=. & wild_animal~=. & other_damage~=. & /*
 */neighbours_noice~=.  & garbage~=. & cat_dog~=. & indus_waste~=. & other_waste~=. & climate~=. & ent_satisf~=. & living_evnt~=. & dignity_social~=. &/*
 */dignity_family~=. & respect~=. & peol_treat~=. & f_descion~=. & f_express_ideas~=. & f_relationship~=.)*/
 
 keep if sample==1
capture log using "Fuzzy_Material_dip.smcl",replace

*-----------------------------------------------------------------------------
* ANALYSIS OF THE MPI INDICATORS
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------


*** 1. MISSING VALUES

* Final check to see the total number of missing values we have for each variable 
* Variables should not have high proportion of missing values at this stage 
* The command might need to be installed: write "findit mdesc" in the command window, and install it
mdesc  Fzy_Housing_struc Fzy_wall Fzy_floor Fzy_roof Fzy_room floorAre2 Fzy_Fl_area Fzy_ownership Fzy_elec Fzy_safedw/*
*/ Fzy_cookF  Fzy_toiTp Fzy_housing_satis Fzy_Housing_adq Fzy_radio Fzy_tv Fzy_washmach Fzy_refrig Fzy_cooker /*
*/Fzy_fan Fzy_tel_land Fzy_mobile Fzy_comp_des Fzy_laptop Fzy_mo_cycle Fzy_threw Fzy_bus Fzy_clodq Fzy_closaty Fzy_buyclot 


*** 2. CRAMER's V

* Cramer's V describes the association among indicators. It ranges between 0 and 1: 
* - 0 for the lowest possible association between variables, and
* - 1 for the largest possible association. 

foreach x in  Fzy_wall Fzy_floor Fzy_roof  Fzy_elec Fzy_safedw/*
*/ Fzy_cookF Fzy_toiTp  Fzy_radio Fzy_tv Fzy_washmach Fzy_refrig Fzy_cooker /*
*/Fzy_fan Fzy_tel_land Fzy_mobile Fzy_comp_des Fzy_laptop Fzy_mo_cycle Fzy_threw Fzy_bus /*
*/ Fzy_clodq  {

	foreach y in  Fzy_wall Fzy_floor Fzy_roof  Fzy_elec Fzy_safedw/*
*/ Fzy_cookF Fzy_toiTp  Fzy_radio Fzy_tv Fzy_washmach Fzy_refrig Fzy_cooker /*
*/Fzy_fan Fzy_tel_land Fzy_mobile Fzy_comp_des Fzy_laptop Fzy_mo_cycle Fzy_threw Fzy_bus /*
*/ Fzy_clodq {
		
		if "`x'" != "`y'" {
			
			tab `x' `y' if sample==1, V
			}
		}
	}



*** 4. REDUNDANCY

* Describes redundancy among indicators. The coefficient P is defined as the ratio between:
* - the proportion of people with simultaneous deprivation in any two indicators, and
* - the lowest proportion of deprivation of those indicators independently.
* The coefficient P takes values:
* - 0% when no one is identified as deprived in both indicators being considered, and
* - 100% when every individual who is deprived in the indicator with the lowest incidence 
* of deprivation, is also deprived on the other indicator.

foreach var1 in Fzy_wall Fzy_floor Fzy_roof  Fzy_elec Fzy_safedw /*
*/Fzy_cookF Fzy_toiTp  Fzy_radio Fzy_tv Fzy_washmach Fzy_refrig Fzy_cooker /*
*/Fzy_fan Fzy_tel_land Fzy_mobile Fzy_comp_des Fzy_laptop Fzy_mo_cycle Fzy_threw Fzy_bus/*
*/ Fzy_clodq {

	foreach var2 in Fzy_wall Fzy_floor Fzy_roof  Fzy_elec Fzy_safedw /*
*/Fzy_cookF Fzy_toiTp  Fzy_radio Fzy_tv Fzy_washmach Fzy_refrig Fzy_cooker /*
*/Fzy_fan Fzy_tel_land Fzy_mobile Fzy_comp_des Fzy_laptop Fzy_mo_cycle Fzy_threw Fzy_bus /*
*/ Fzy_clodq {


		/* Temporal variables for the matches and mismatches of two variables */
		generate temp_1 = (`var1'==0 & `var2'==0) if sample==1
		sum temp_1 [aw =  finalweight]
		gen dd00 = r(mean)

		generate temp_2 = (`var1'==0 & `var2'==1) if sample==1
		sum temp_2 [aw =  finalweight]
		gen dd01 = r(mean)

		generate temp_3 = (`var1'==1 & `var2'==0) if sample==1
		sum temp_3 [aw =  finalweight]
		gen dd10 = r(mean)

		generate temp_4 = (`var1'==1 & `var2'==1) if sample==1
		sum temp_4 [aw =  finalweight]
		gen dd11 = r(mean)

		
		/* Compute uncensored headcount ratios */
		sum `var1' [aw =  finalweight] if sample==1
		gen h1_`var1' = r(mean)
		sum `var2' [aw =  finalweight] if sample==1
		gen h2_`var2' = r(mean)
		

		/* Compute redundancy (coefficient P) */
		egen h_min_`var1'_`var2' = rowmin(h1_`var1' h2_`var2')
		gen P_`var1'_`var2' = dd11 / h_min_`var1'_`var2'
		
		
		/* Alternative way to compute Cramer Vs (with weights) from these temporal variables*/ 
		gen CV_`var1'_`var2' = (dd00*dd11 - dd01 *dd10)/ sqrt(h1_`var1'*(1-h1_`var1')*h2_`var2'*(1-h2_`var2'))

		drop temp* dd* h1_* h2_* h_min* 
		
		}

	
	}	
	
	
	fsum P_* CV_*
	
drop CV_*
drop P_Fzy*

*-----------------------------
* correlation for continuous variables
*------------------------------


corr Fzy_room Fzy_Housing_struc Fzy_Fl_area Fzy_ownership Fzy_Toiletuse Fzy_housing_satis Fzy_Housing_adq Fzy_closaty Fzy_buyclot


*-----------------------------
* correlation for continuous variables and bivariables
*------------------------------
pbis Fzy_wall Fzy_room 
pbis Fzy_wall Fzy_Housing_struc
pbis Fzy_wall Fzy_Fl_area 
pbis Fzy_wall Fzy_ownership
pbis Fzy_wall Fzy_Toiletuse 
pbis Fzy_wall Fzy_Housing_adq
pbis Fzy_wall Fzy_closaty
pbis Fzy_wall Fzy_buyclot 
*pbis Fzy_wall Fzy_food_adq
 
pbis Fzy_floor Fzy_room 
pbis Fzy_floor Fzy_Housing_struc
pbis Fzy_floor Fzy_Fl_area 
pbis Fzy_floor Fzy_ownership
pbis Fzy_floor Fzy_Toiletuse 
pbis Fzy_floor Fzy_Housing_adq
pbis Fzy_floor Fzy_closaty
pbis Fzy_floor Fzy_buyclot 
*pbis Fzy_floor Fzy_food_adq 
 
pbis Fzy_roof Fzy_room 
pbis Fzy_roof Fzy_Housing_struc
pbis Fzy_roof Fzy_Fl_area 
pbis Fzy_roof Fzy_ownership
pbis Fzy_roof Fzy_Toiletuse 
pbis Fzy_roof Fzy_Housing_adq
pbis Fzy_roof Fzy_closaty
pbis Fzy_roof Fzy_buyclot 
*pbis Fzy_roof Fzy_food_adq   
 
pbis Fzy_elec Fzy_room 
pbis Fzy_elec Fzy_Housing_struc
pbis Fzy_elec Fzy_Fl_area 
pbis Fzy_elec Fzy_ownership
pbis Fzy_elec Fzy_Toiletuse 
pbis Fzy_elec Fzy_Housing_adq
pbis Fzy_elec Fzy_closaty
pbis Fzy_elec Fzy_buyclot 
*pbis Fzy_elec Fzy_food_adq 
   
pbis Fzy_safedw Fzy_room 
pbis Fzy_safedw Fzy_Housing_struc
pbis Fzy_safedw Fzy_Fl_area 
pbis Fzy_safedw Fzy_ownership
pbis Fzy_safedw Fzy_Toiletuse 
pbis Fzy_safedw Fzy_Housing_adq
pbis Fzy_safedw Fzy_closaty
pbis Fzy_safedw Fzy_buyclot 
*pbis Fzy_safedw Fzy_food_adq  
 
pbis Fzy_toiTp Fzy_room 
pbis Fzy_toiTp Fzy_Housing_struc
pbis Fzy_toiTp Fzy_Fl_area 
pbis Fzy_toiTp Fzy_ownership
pbis Fzy_toiTp Fzy_Toiletuse 
pbis Fzy_toiTp Fzy_Housing_adq
pbis Fzy_toiTp Fzy_closaty
pbis Fzy_toiTp Fzy_buyclot
*pbis Fzy_toiTp Fzy_food_adq   
 
pbis Fzy_radio Fzy_room 
pbis Fzy_radio Fzy_Housing_struc
pbis Fzy_radio Fzy_Fl_area 
pbis Fzy_radio Fzy_ownership
pbis Fzy_radio Fzy_Toiletuse 
pbis Fzy_radio Fzy_Housing_adq
pbis Fzy_radio Fzy_closaty
pbis Fzy_radio Fzy_buyclot 
*pbis Fzy_radio Fzy_food_adq   

pbis Fzy_mobile Fzy_room 
pbis Fzy_mobile Fzy_Housing_struc
pbis Fzy_mobile Fzy_Fl_area 
pbis Fzy_mobile Fzy_ownership
pbis Fzy_mobile Fzy_Toiletuse 
pbis Fzy_mobile Fzy_Housing_adq
pbis Fzy_mobile Fzy_closaty
pbis Fzy_mobile Fzy_buyclot 
*pbis Fzy_mobile Fzy_food_adq 

pbis Fzy_bus Fzy_room 
pbis Fzy_bus Fzy_Housing_struc
pbis Fzy_bus Fzy_Fl_area 
pbis Fzy_bus Fzy_ownership
pbis Fzy_bus Fzy_Toiletuse 
pbis Fzy_bus Fzy_Housing_adq
pbis Fzy_bus Fzy_closaty
pbis Fzy_bus Fzy_buyclot 
*pbis Fzy_bus Fzy_food_adq 

pbis Fzy_clodq Fzy_room 
pbis Fzy_clodq Fzy_Housing_struc
pbis Fzy_clodq Fzy_Fl_area 
pbis Fzy_clodq Fzy_ownership
pbis Fzy_clodq Fzy_Toiletuse 
pbis Fzy_clodq Fzy_Housing_adq
pbis Fzy_clodq Fzy_closaty
pbis Fzy_clodq Fzy_buyclot 
*pbis Fzy_clodq Fzy_food_adq 

pbis Fzy_tv Fzy_room 
pbis Fzy_tv Fzy_Housing_struc
pbis Fzy_tv Fzy_Fl_area 
pbis Fzy_tv Fzy_ownership
pbis Fzy_tv Fzy_Toiletuse 
pbis Fzy_tv Fzy_Housing_adq
pbis Fzy_tv Fzy_closaty
pbis Fzy_tv Fzy_buyclot 
*pbis Fzy_tv Fzy_food_adq 

pbis Fzy_washmach Fzy_room 
pbis Fzy_washmach Fzy_Housing_struc
pbis Fzy_washmach Fzy_Fl_area 
pbis Fzy_washmach Fzy_ownership
pbis Fzy_washmach Fzy_Toiletuse 
pbis Fzy_washmach Fzy_Housing_adq
pbis Fzy_washmach Fzy_closaty
pbis Fzy_washmach Fzy_buyclot 
*pbis Fzy_washmach Fzy_food_adq

pbis Fzy_refrig Fzy_room 
pbis Fzy_refrig Fzy_Housing_struc
pbis Fzy_refrig Fzy_Fl_area 
pbis Fzy_refrig Fzy_ownership
pbis Fzy_refrig Fzy_Toiletuse 
pbis Fzy_refrig Fzy_Housing_adq
pbis Fzy_refrig Fzy_closaty
pbis Fzy_refrig Fzy_buyclot 
*pbis Fzy_refrig Fzy_food_adq


*roof was removed because only 1 househols has semi permanent materials
*******************Frequancies of totaly poor /ln value calculation ********************

gen C_Fzy_wall = (Fzy_wall==1)
gen  TFC_wall= sum(C_Fzy_wall)
gen TTFC_wall= TFC_wall[_N]
gen ln_Feq_wall= ln(1/TTFC_wall)
drop C_Fzy_wall TFC_wall TTFC_wall

gen C_Fzy_floor = (Fzy_floor==1)
gen  TFC_floor= sum(C_Fzy_floor)
gen TTFC_floor= TFC_floor[_N]
gen ln_Feq_floor= ln(1/TTFC_floor)
drop C_Fzy_floor TFC_floor TTFC_floor

gen C_Fzy_elec = (Fzy_elec==1)
gen  TFC_elec= sum(C_Fzy_elec)
gen TTFC_elec= TFC_elec[_N]
gen ln_Feq_elec= ln(1/TTFC_elec)
drop C_Fzy_elec TFC_elec TTFC_elec

gen C_Fzy_safedw = (Fzy_safedw==1)
gen  TFC_safedw= sum(C_Fzy_safedw)
gen TTFC_safedw= TFC_safedw[_N]
gen ln_Feq_safedw= ln(1/TTFC_safedw)
drop C_Fzy_safedw TFC_safedw TTFC_safedw

gen C_Fzy_toiTp = (Fzy_toiTp==1)
gen  TFC_toiTp= sum(C_Fzy_toiTp)
gen TTFC_toiTp= TFC_toiTp[_N]
gen ln_Feq_toiTp= ln(1/TTFC_toiTp)
drop C_Fzy_toiTp TFC_toiTp TTFC_toiTp

gen C_Fzy_room = (Fzy_room==1)
gen  TFC_room= sum(C_Fzy_room)
gen TTFC_room= TFC_room[_N]
gen ln_Feq_room= ln(1/TTFC_room)
drop C_Fzy_room TFC_room TTFC_room

gen C_Fzy_Housing_struc = (Fzy_Housing_struc==1)
gen  TFC_Housing_struc= sum(C_Fzy_Housing_struc)
gen TTFC_Housing_struc= TFC_Housing_struc[_N]
gen ln_Feq_Housing_struc= ln(1/TTFC_Housing_struc)
drop C_Fzy_Housing_struc TFC_Housing_struc TTFC_Housing_struc

gen C_Fzy_Fl_area = (Fzy_Fl_area==1)
gen  TFC_Fl_area= sum(C_Fzy_Fl_area)
gen TTFC_Fl_area= TFC_Fl_area[_N]
gen ln_Feq_Fl_area= ln(1/TTFC_Fl_area)
drop C_Fzy_Fl_area TFC_Fl_area TTFC_Fl_area

gen C_Fzy_ownership = (Fzy_ownership==1)
gen  TFC_ownership= sum(C_Fzy_ownership)
gen TTFC_ownership= TFC_ownership[_N]
gen ln_Feq_ownership= ln(1/TTFC_ownership)
drop C_Fzy_ownership TFC_ownership TTFC_ownership

gen C_Fzy_Toiletuse = (Fzy_Toiletuse==1)
gen  TFC_Toiletuse= sum(C_Fzy_Toiletuse)
gen TTFC_Toiletuse= TFC_Toiletuse[_N]
gen ln_Feq_Toiletuse= ln(1/TTFC_Toiletuse)
drop C_Fzy_Toiletuse TFC_Toiletuse TTFC_Toiletuse

gen C_Fzy_housing_satis = (Fzy_housing_satis==1)
gen  TFC_housing_satis= sum(C_Fzy_housing_satis)
gen TTFC_housing_satis= TFC_housing_satis[_N]
gen ln_Feq_housing_satis= ln(1/TTFC_housing_satis)
drop C_Fzy_housing_satis TFC_housing_satis TTFC_housing_satis

gen C_Fzy_Housing_adq = (Fzy_Housing_adq==1)
gen TFC_Housing_adq= sum(C_Fzy_Housing_adq)
gen TTFC_Housing_adq= TFC_Housing_adq[_N]
gen ln_Feq_Housing_adq= ln(1/TTFC_Housing_adq)
drop C_Fzy_Housing_adq TFC_Housing_adq TTFC_Housing_adq


gen C_Fzy_radio = (Fzy_radio==1)
gen TFC_radio= sum(C_Fzy_radio)
gen TTFC_radio= TFC_radio[_N]
gen ln_Feq_radio= ln(1/TTFC_radio)
drop C_Fzy_radio TFC_radio TTFC_radio


gen C_Fzy_mobile = (Fzy_mobile==1)
gen TFC_mobile= sum(C_Fzy_mobile)
gen TTFC_mobile= TFC_mobile[_N]
gen ln_Feq_mobile= ln(1/TTFC_mobile)
drop C_Fzy_mobile TFC_mobile TTFC_mobile


gen C_Fzy_tv = (Fzy_tv==1)
gen TFC_tv= sum(C_Fzy_tv)
gen TTFC_tv= TFC_tv[_N]
gen ln_Feq_tv= ln(1/TTFC_tv)
drop C_Fzy_tv TFC_tv TTFC_tv


/*gen C_Fzy_roof = (Fzy_roof==1)
gen TFC_roof= sum(C_Fzy_roof)
gen TTFC_roof= TFC_roof[_N]
gen ln_Feq_roof= ln(1/TTFC_roof)
drop C_Fzy_roof TFC_roof TTFC_roof*/

/*gen C_Fzy_food_adq = (Fzy_food_adq==1)
gen TFC_food_adq= sum(C_Fzy_food_adq)
gen TTFC_food_adq= TFC_food_adq[_N]
gen ln_Feq_food_adq= ln(1/TTFC_eat_fish)
drop C_Fzy_food_adq TFC_food_adq TTFC_food_adq*/

gen C_Fzy_closaty = (Fzy_closaty==1)
gen TFC_closaty= sum(C_Fzy_closaty)
gen TTFC_closaty= TFC_closaty[_N]
gen ln_Feq_closaty= ln(1/TTFC_closaty)
drop C_Fzy_closaty TFC_closaty TTFC_closaty


gen C_Fzy_buyclot = (Fzy_buyclot==1)
gen TFC_buyclot= sum(C_Fzy_buyclot)
gen TTFC_buyclot= TFC_buyclot[_N]
gen ln_Feq_buyclot= ln(1/TTFC_buyclot)
drop C_Fzy_buyclot TFC_buyclot TTFC_buyclot


gen C_Fzy_clodq = (Fzy_clodq==1)
gen TFC_clodq= sum(C_Fzy_clodq)
gen TTFC_clodq= TFC_clodq[_N]
gen ln_Feq_clodq= ln(1/TTFC_clodq)
drop C_Fzy_clodq TFC_clodq TTFC_clodq


gen Tot_ln = ( ln_Feq_wall + ln_Feq_floor + ln_Feq_elec + ln_Feq_safedw + ln_Feq_toiTp +ln_Feq_Toiletuse+ ln_Feq_room /*
*/ +ln_Feq_Housing_struc + ln_Feq_Fl_area +ln_Feq_ownership + ln_Feq_housing_satis + ln_Feq_Housing_adq /*
*/+ln_Feq_radio  +ln_Feq_mobile + ln_Feq_closaty + ln_Feq_buyclot + ln_Feq_clodq)

************Weighted deprivation matrix of fuzzy_score****************

foreach var  in wall floor elec safedw toiTp room Housing_struc  Fl_area ownership Toiletuse housing_satis Housing_adq tv mobile closaty buyclot clodq{
gen TFW_`var'= 	ln_Feq_`var'/Tot_ln 
gen TF_`var'= TFW_`var'*Fzy_`var'
}

*

sum TFW_* 
fsum TF_* [aw =  finalweight]

svyset psu [pw = finalweight], strata(domaincode)
svy linearized : mean TF_*


/*gen TF_wall=(ln_Feq_wall* Fzy_wall)/Tot_ln
gen TF_floor=(ln_Feq_floor* Fzy_floor)/Tot_ln
gen TF_elec=(ln_Feq_elec* Fzy_elec)/Tot_ln
gen TF_safedw=(ln_Feq_safedw * Fzy_safedw)/Tot_ln
gen TF_toiTp=(ln_Feq_toiTp* Fzy_toiTp)/Tot_ln
gen TF_room=(ln_Feq_room * Fzy_room)/Tot_ln
gen TF_Housing_struc=(ln_Feq_Housing_struc* Fzy_Housing_struc)/Tot_ln
gen TF_Fl_area=(ln_Feq_Fl_area* Fzy_Fl_area)/Tot_ln
gen TF_ownership=(ln_Feq_ownership* Fzy_ownership)/Tot_ln
gen TF_Toiletuse=(ln_Feq_Toiletuse* Fzy_Toiletuse)/Tot_ln
gen TF_housing_satis=(ln_Feq_housing_satis* Fzy_housing_satis)/Tot_ln
gen TF_Housing_adq=(ln_Feq_Housing_adq* Fzy_Housing_adq)/Tot_ln
gen TF_tv=(ln_Feq_tv* Fzy_tv)/Tot_ln
gen TF_mobile=(ln_Feq_mobile* Fzy_mobile)/Tot_ln
gen TF_eat_fish=(ln_Feq_eat_fish* Fzy_eat_fish)/Tot_ln
gen TF_eat_green=(ln_Feq_eat_green* Fzy_eat_green)/Tot_ln
gen TF_eat_fruit=(ln_Feq_eat_fruit* Fzy_eat_fruit)/Tot_ln
gen TF_closaty=(ln_Feq_closaty* Fzy_closaty)/Tot_ln
gen TF_buyclot=(ln_Feq_buyclot* Fzy_buyclot)/Tot_ln
gen TF_clodq=(ln_Feq_clodq* Fzy_clodq)/Tot_ln*/



gen Total_Fuzzy = (TF_wall + TF_floor +TF_elec +TF_safedw +TF_toiTp +TF_room +TF_Housing_struc+ /*
*/TF_Fl_area+ TF_ownership+ TF_Toiletuse+ TF_housing_satis +TF_Housing_adq +TF_tv + TF_mobile + TF_closaty+ TF_buyclot+ TF_clodq)

egen Total_MD_WFS = rowtotal(TF_*)


fsum Total_Fuzzy [aw =  finalweight]
fsum TF_* [aw =  finalweight]

svyset psu [pw = finalweight], strata(domaincode)
svy: mean Total_Fuzzy
svy: mean TF_*

svyset psu [pw = finalweight], strata(domaincode)
svy: mean Total_MD_WFS


gen Hosing_D_Fuzzy=(TF_wall + TF_floor +TF_elec +TF_safedw +TF_toiTp +TF_room +TF_Housing_struc+ /*
*/TF_Fl_area+ TF_ownership+ TF_Toiletuse+ TF_housing_satis +TF_Housing_adq)
svyset psu [pw = finalweight], strata(domaincode)
svy: mean Hosing_D_Fuzzy

gen Durabal_D_Fuzzy=(TF_tv + TF_mobile)
svyset psu [pw = finalweight], strata(domaincode)
svy: mean Durabal_D_Fuzzy

gen Basic_D_Fuzzy=(TF_closaty+ TF_buyclot+ TF_clodq)
svyset psu [pw = finalweight], strata(domaincode)
svy: mean Basic_D_Fuzzy



forvalue k = 5(5)100 {

	gen	multid_Fzypoor_`k' = (Total_Fuzzy >= `k'/100)
	lab var multid_Fzypoor_`k' "FzyPoverty Identification with k=`k'%"
	}



forvalue k = 5(5)100 {

	gen	Fzy_c_vector_`k' = Total_Fuzzy
	replace Fzy_c_vector_`k' = 0 if multid_Fzypoor_`k'==0 
	}
	save "MD_Fuzzy.dta",replace

***to see the Fuzzy weight for all indicator

foreach var  in wall floor elec safedw toiTp room Housing_struc  Fl_area ownership Toiletuse housing_satis Housing_adq tv mobile closaty buyclot clodq{
gen fuzzy_w_`var'= 	ln_Feq_`var'/Tot_ln 
}
	
	
fsum fuzzy_w_*

gen MD_Tot_ln=Tot_ln
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------
* Head for   all the possible cutoffs so far
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------

* By sumarizing (obtaining the mean) of the identification fuzzy vector, the individual deprivation share, 
*  at any level of k we will obtain the Multidimensional Headcount 
* Ratio (H), the Intensity of Poverty among the Poor (A), and the Adjusted Headcount Ratio (M0), respectively.


*Headcount(H)**********
sum multid_Fzypoor_* [aw =  finalweight], sep(15)

*********Intencity(I)***********
forvalue k = 5(5)100 {
	sum Fzy_c_vector_`k' if multid_Fzypoor_`k'==1 [aw =  finalweight], sep(15)
	}
*  Mo=H*I
forvalue k = 5(5)100 {
	sum Fzy_c_vector_`k' [aw =  finalweight], sep(15)
	}


save "MD_Fuzzy.dta",replace
* -----------------------------------------------------------------------------
* RANK ROBUSTNESS COMPARISONS
* -----------------------------------------------------------------------------	
use "MD_Fuzzy.dta",clear
	
collapse (mean) multid_Fzypoor_* [aw = finalweight], by(ds)
ktau multid_Fzypoor_*, stats(taub se p)	
	

* -----------------------------------------------------------------------------
* DOMINANCE AMONG SUBNATIONAL REGIONS
* -----------------------------------------------------------------------------
use "MD_Fuzzy.dta",clear
* For MFzyMPI
collapse (mean) multid_Fzypoor_10 multid_Fzypoor_20 multid_Fzypoor_30 multid_Fzypoor_40	///
	      multid_Fzypoor_50 multid_Fzypoor_60 multid_Fzypoor_70 multid_Fzypoor_80	///
	      multid_Fzypoor_90 multid_Fzypoor_100 [aw = finalweight], by(domaincode)
		
reshape long multid_Fzypoor_, i(domaincode) j(k)

gen multid_Fzypoor_1 = multid_Fzypoor_ if domaincode==811
label var multid_Fzypoor_1 "Badulla urban"
gen multid_Fzypoor_2 = multid_Fzypoor_ if domaincode==812
label var multid_Fzypoor_2 "Badulla rural"
gen multid_Fzypoor_3 = multid_Fzypoor_ if domaincode==813
label var multid_Fzypoor_3 "Badulla estate"
gen multid_Fzypoor_4 = multid_Fzypoor_ if domaincode==822
label var multid_Fzypoor_4 "Moneragala rural"
gen multid_Fzypoor_5 = multid_Fzypoor_ if domaincode==823
label var multid_Fzypoor_5 "Moneragala estate"


graph twoway line multid_Fzypoor_1 k || line multid_Fzypoor_2 k || line multid_Fzypoor_3 k || line multid_Fzypoor_4 k || line multid_Fzypoor_5 k 
clear
use "MD_Fuzzy.dta"

/*collapse (mean) Fzy_c_vector_10 Fzy_c_vector_20 Fzy_c_vector_30 Fzy_c_vector_40	///
	      Fzy_c_vector_50 Fzy_c_vector_60 Fzy_c_vector_70 Fzy_c_vector_80	///
	      Fzy_c_vector_90 Fzy_c_vector_100 [aw = finalweight], by( SectorUR)
		
reshape long Fzy_c_vector_, i(SectorUR) j(k)

gen Fzy_c_vector_1 = Fzy_c_vector_ if SectorUR==1
label var Fzy_c_vector_1 "urban"
gen Fzy_c_vector_2 = Fzy_c_vector_ if SectorUR==2
label var Fzy_c_vector_2 " rural"



graph twoway line Fzy_c_vector_1 k || line Fzy_c_vector_2 k 

clear

use "Fuzzy.dta"

collapse (mean) Fzy_c_vector_10 Fzy_c_vector_20 Fzy_c_vector_30 Fzy_c_vector_40	///
	      Fzy_c_vector_50 Fzy_c_vector_60 Fzy_c_vector_70 Fzy_c_vector_80	///
	      Fzy_c_vector_90 Fzy_c_vector_100 [aw = finalweight], by(sector)
		
reshape long Fzy_c_vector_, i(sector) j(k)

gen Fzy_c_vector_1 = Fzy_c_vector_ if  sector==1
label var Fzy_c_vector_1 "urban"
gen Fzy_c_vector_2 = Fzy_c_vector_ if  sector==2
label var Fzy_c_vector_2 " rural"
gen Fzy_c_vector_3 = Fzy_c_vector_ if  sector==3
label var Fzy_c_vector_2 " Estate"


graph twoway line Fzy_c_vector_1 k || line Fzy_c_vector_2 k || line Fzy_c_vector_3 k 

clear

use "Fuzzy.dta"*/

* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------
* UNCENSORED HEADCOUNT RATIOS
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------

 foreach var in  TF_wall TF_floor TF_elec TF_safedw TF_toiTp TF_room TF_Housing_struc TF_Fl_area TF_ownership TF_Toiletuse TF_housing_satis TF_Housing_adq TF_tv TF_mobile TF_closaty TF_buyclot TF_clodq{
	sum `var' [aw = finalweight]
	gen	uncen_mean_TF_`var' = r(mean)
	lab var uncen_mean_TF_`var'  "Uncensored averge deprivation score for each indicator "
	}

* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------
*  H A and M0 for k = 40% 
* -----------------------------------------------------------------------------
* -----------------------------------------------------------------------------

* Counting vector:
egen c_vector = rowtotal(TF_*)
lab var c_vector "Counting Vector"
*tab	c_vector [aw = finalweight], m

* Identification, using poverty cutoff (k) = 40%

local k=40
gen	multid_poor_`k' = (c_vector >= `k'/100)
lab var multid_poor_`k' "Poverty Identification with k=`k'%"


* Censored counting vector:
gen	cens_c_vector_`k' = c_vector
replace cens_c_vector_`k' = 0 if multid_poor_`k'==0 


*Censored deprivation matrix:
local k=40
foreach var in  TF_wall TF_floor TF_elec TF_safedw TF_toiTp TF_room TF_Housing_struc TF_Fl_area TF_ownership TF_Toiletuse TF_housing_satis TF_Housing_adq TF_tv TF_mobile  TF_buyclot TF_clodq TF_closaty {
	gen	ind_cen_`k'_`var' = `var'
	replace ind_cen_`k'_`var' = 0 if multid_poor_`k'==0
	
	}

gen MD_multid_poor_40=multid_poor_40
*svyset psu [pw = finalweight], strata(domaincode)
*svy linearized  : mean MD_multid_poor_40

	
	*intencity(A) of each indicators
sum ind_cen_40_* [aw = finalweight] if multid_poor_40==1

******MO(MPI) for Uva province with CI at Uva and by indicators*********
svyset psu [pw = finalweight], strata(domaincode)
svy linearized  : mean cens_c_vector_40
svy linearized  : mean ind_cen_40_*


	
* H A and M0 for k = 40% for Uva province

sum	multid_poor_`k' [aw = finalweight]
gen	H = r(mean)
lab var H "Fuzzy Headcount Ratio (H): % Population in multidimensional fuzzy poverty"

sum	cens_c_vector_`k' [aw = finalweight] if multid_poor_`k'==1
gen	A = r(mean)
lab var A  "Intensity of Fuzzy deprivation among the poor (A): Average % of weighted deprivations"

sum	cens_c_vector_`k' [aw = finalweight]
gen	M0 = r(mean)
lab var M0 "Adjusted Fuzzy Headcount Ratio (M0 = (H)*A): Range 0 to 1"

sum H A M0

* H A and M0 for k = 40% for Badulla District

sum	multid_poor_`k' [aw = finalweight] if  district==81
gen	BH = r(mean)
lab var BH "Fuzzy Headcount Ratio (H): % Population in multidimensional fuzzy poverty in Badulla"

sum	cens_c_vector_`k' [aw = finalweight] if multid_poor_`k'==1 & district==81
gen	BA = r(mean)
lab var BA  "Intensity of Fuzzy deprivation among the poor (A): Average % of weighted deprivations in Badulla"

sum	cens_c_vector_`k' [aw = finalweight] if  district==81
gen	BM0 = r(mean)
lab var BM0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1 in Badulla"

sum BH BA BM0

* H A and M0 for k = 40% for Moneragala District

sum	multid_poor_`k' [aw = finalweight] if  district==82
gen	MH = r(mean)
lab var MH "Fuzzy Headcount Ratio (H): % Population in multidimensional fuzzy poverty in Moneragala"

sum	cens_c_vector_`k' [aw = finalweight] if multid_poor_`k'==1 &  district==82
gen	MA = r(mean)
lab var MA  "Intensity of Fuzzy deprivation among the poor (A): Average % of weighted deprivations in Moneragala"

sum	cens_c_vector_`k' [aw = finalweight] if  district==82
gen	MM0 = r(mean)
lab var BM0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1 in Moneragala"

sum MH MA MM0


* H A and M0 for k = 40% for Badulla Urban


local k=40
sum	multid_poor_`k' [aw = finalweight] if domaincode==811
gen	BU_H = r(mean)
lab var BU_H "Fuzzy Headcount Ratio (H): % Population in multidimensional fuzzy poverty in Badulla Urban"

sum	cens_c_vector_`k' [aw = finalweight] if multid_poor_`k'==1 & domaincode==811
gen	BU_A = r(mean)
lab var BU_A  "Intensity of Fuzzy deprivation among the poor (A): Average % of weighted deprivations in Badulla Urban"

sum	cens_c_vector_`k' [aw = finalweight] if domaincode==811
gen	BU_M0 = r(mean)
lab var BU_M0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1  in Badulla Urban "

sum BU_H BU_A BU_M0

* H A and M0 for k = 40% for Badulla Rural

local k=40
sum	multid_poor_`k' [aw = finalweight] if domaincode==812
gen	BR_H = r(mean) 
lab var BR_H "Fuzzy Headcount Ratio (H): % Population in multidimensional fuzzy poverty in Badulla Rural"

sum	cens_c_vector_`k' [aw = finalweight] if multid_poor_`k'==1 & domaincode==812
gen	BR_A = r(mean)
lab var BR_A  "Intensity of Fuzzy deprivation among the poor (A): Average % of weighted deprivations in Badulla Rural"

sum	cens_c_vector_`k' [aw = finalweight] if domaincode==812
gen	BR_M0 = r(mean)
lab var BR_M0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1  in Badulla Rural "

sum BR_H BR_A BR_M0

* H A and M0 for k = 40% for Badulla Estate

local k=40
sum	multid_poor_`k' [aw = finalweight] if domaincode==813

gen	BE_H = r(mean) 
lab var BE_H "Fuzzy Headcount Ratio (H): % Population in multidimensional fuzzy poverty in Badulla Estate"

sum	cens_c_vector_`k' [aw = finalweight] if multid_poor_`k'==1 & domaincode==813
gen	BE_A = r(mean)
lab var BE_A  "Intensity of Fuzzy deprivation among the poor (A): Average % of weighted deprivations in Badulla Estate"

sum	cens_c_vector_`k' [aw = finalweight] if domaincode==813
gen	BE_M0 = r(mean)
lab var BE_M0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1  in Badulla Estate"

sum BE_H BE_A BE_M0

* H A and M0 for k = 40% for Moneragala Rural

local k=40
sum	multid_poor_`k' [aw = finalweight] if domaincode==822
gen	MR_H = r(mean) 
lab var MR_H "Fuzzy Headcount Ratio (H): % Population in multidimensional fuzzy poverty in Moneragala Rural"

sum	cens_c_vector_`k' [aw = finalweight] if multid_poor_`k'==1 & domaincode==822
gen	MR_A = r(mean)
lab var MR_A  "Intensity of Fuzzy deprivation among the poor (A): Average % of weighted deprivations in Moneragala Rural"

sum	cens_c_vector_`k' [aw = finalweight] if domaincode==822
gen	MR_M0 = r(mean)
lab var MR_M0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1  in Moneragala Rural "

sum MR_H MR_A MR_M0

* H A and M0 for k = 40% for Moneragala Estate

local k=40
sum	multid_poor_`k' [aw = finalweight] if domaincode==823

gen	ME_H = r(mean)
lab var ME_H "Fuzzy Headcount Ratio (H): % Population in multidimensional fuzzy poverty in Moneragala Estate"

sum	cens_c_vector_`k' [aw = finalweight] if multid_poor_`k'==1 & domaincode==823
gen	ME_A = r(mean)
lab var ME_A  "Intensity of Fuzzy deprivation among the poor (A): Average % of weighted deprivations in Moneragala Estate"

sum	cens_c_vector_`k' [aw = finalweight] if domaincode==823
gen	ME_M0 = r(mean)
lab var ME_M0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1  in Moneragala Estate "

sum ME_H ME_A ME_M0

**************************************************
* H A and M0 for k = 40% for Plantation  Sector
**************************************************
********Plantation Are**********

gen plant_Are = sector==3 
svy linearized : mean multid_poor_40, over(plant_Are)

local k=40


sum	multid_poor_`k' [aw = finalweight] if plant_Are==1
gen	PL_H = r(mean)
lab var PL_H "Fuzzy Headcount Ratio (H): % Population in multidimensional fuzzy poverty in Plantation sector"

sum	cens_c_vector_`k' [aw = finalweight] if multid_poor_`k'==1 & plant_Are==1
gen	PL_A = r(mean)
lab var PL_A  "Intensity of Fuzzy deprivation among the poor (A): Average % of weighted deprivations in Plantation sector"

sum	cens_c_vector_`k' [aw = finalweight] if plant_Are==1
gen	PL_M0 = r(mean)
lab var PL_M0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1  in Plantation sector "

**************************************************
* H A and M0 for k = 40% for Non-Plantation  Sector
**************************************************
local k=40


sum	multid_poor_`k' [aw = finalweight] if plant_Are==0
gen	NPL_H = r(mean)
lab var NPL_H "Fuzzy Headcount Ratio (H): % Population in multidimensional fuzzy poverty in Plantation sector"

sum	cens_c_vector_`k' [aw = finalweight] if multid_poor_`k'==1 & plant_Are==0
gen	NPL_A = r(mean)
lab var NPL_A  "Intensity of Fuzzy deprivation among the poor (A): Average % of weighted deprivations in Plantation sector"

sum	cens_c_vector_`k' [aw = finalweight] if plant_Are==0
gen	NPL_M0 = r(mean)
lab var NPL_M0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1  in Non-Plantation sector "
************************************************


*Share of population MPI poor and deprived in Uva Province:(M0 for Uva )
svyset psu [pw = finalweight], strata(domaincode)
svy linearized : mean ind_cen_40_TF_*

sum ind_cen_40_TF_wall [aw=finalweight] 
gen S_Mo_wall=r(mean)

sum ind_cen_40_TF_floor [aw=finalweight] 
gen S_Mo_floor=r(mean)

sum ind_cen_40_TF_elec [aw=finalweight] 
gen S_Mo_elec=r(mean)

sum ind_cen_40_TF_safedw [aw=finalweight] 
gen S_Mo_safedw=r(mean)

sum ind_cen_40_TF_toiTp [aw=finalweight] 
gen S_Mo_toiTp=r(mean)

sum ind_cen_40_TF_room [aw=finalweight] 
gen S_Mo_room=r(mean)

sum ind_cen_40_TF_Housing_struc [aw=finalweight] 
gen S_Mo_Housing_struc=r(mean)

sum ind_cen_40_TF_Fl_area [aw=finalweight] 
gen S_Mo_Fl_area=r(mean)

sum ind_cen_40_TF_ownership [aw=finalweight] 
gen S_Mo_ownership=r(mean)

sum ind_cen_40_TF_Toiletuse [aw=finalweight] 
gen S_Mo_Toiletuse=r(mean)

sum ind_cen_40_TF_housing_satis [aw=finalweight] 
gen S_Mo_housing_satis=r(mean)

sum ind_cen_40_TF_Housing_adq[aw=finalweight] 
gen S_Mo_Housing_adq=r(mean)

sum ind_cen_40_TF_tv [aw=finalweight]  
gen S_Mo_tv=r(mean)

sum ind_cen_40_TF_mobile [aw=finalweight] 
gen S_Mo_mobile=r(mean)

sum ind_cen_40_TF_closaty [aw=finalweight] 
gen S_Mo_closaty=r(mean)

sum ind_cen_40_TF_buyclot [aw=finalweight] 
gen S_Mo_buyclot=r(mean)


sum ind_cen_40_TF_clodq [aw=finalweight] 
gen S_Mo_clodq=r(mean)

svyset psu [pw = finalweight], strata(domaincode)
svy:mean S_Mo_*
fsum  S_Mo_*

*Percentage Share of population MPI poor and deprived in :

foreach var in S_Mo_wall S_Mo_floor S_Mo_elec S_Mo_safedw S_Mo_toiTp S_Mo_room S_Mo_Housing_struc S_Mo_Fl_area S_Mo_ownership S_Mo_Toiletuse S_Mo_housing_satis S_Mo_Housing_adq S_Mo_tv S_Mo_mobile S_Mo_closaty S_Mo_buyclot S_Mo_clodq {	
	
	gen	P_`var' = (`var'/M0)*100
	lab var P_`var'   "Percentage contribution to "
	}
fsum   P_S_Mo_*	

/*Same as above. only have to multifly by 100
 
foreach var in wall floor elec safedw toiTp room Housing_struc  Fl_area ownership Toiletuse housing_satis Housing_adq tv mobile closaty buyclot clodq {	

	gen	perc_cont_`var' = (S_Mo_`var') / M0
	lab var perc_cont_`var' "Percentage contribution to M0"
	}

sum perc_cont_* [aw = finalweight], sep(15)
*/


*Share of population MPI poor and deprived in Badulla :(A0 for Badulla )

sum ind_cen_40_TF_wall [aw=finalweight] if district==81
gen B_S_Mo_wall=r(mean)

sum ind_cen_40_TF_floor [aw=finalweight] if district==81
gen B_S_Mo_floor=r(mean)

sum ind_cen_40_TF_elec [aw=finalweight] if district==81
gen B_S_Mo_elec=r(mean)

sum ind_cen_40_TF_safedw [aw=finalweight] if district==81
gen B_S_Mo_safedw=r(mean)

sum ind_cen_40_TF_toiTp [aw=finalweight] if district==81
gen B_S_Mo_toiTp=r(mean)

sum ind_cen_40_TF_room [aw=finalweight] if district==81
gen B_S_Mo_room=r(mean)

sum ind_cen_40_TF_Housing_struc [aw=finalweight] if district==81
gen B_S_Mo_Housing_struc=r(mean)

sum ind_cen_40_TF_Fl_area [aw=finalweight] if district==81
gen B_S_Mo_Fl_area=r(mean)

sum ind_cen_40_TF_ownership [aw=finalweight] if district==81
gen B_S_Mo_ownership=r(mean)

sum ind_cen_40_TF_Toiletuse [aw=finalweight] if district==81
gen B_S_Mo_Toiletuse=r(mean)

sum ind_cen_40_TF_housing_satis [aw=finalweight] if district==81
gen B_S_Mo_housing_satis=r(mean)

sum ind_cen_40_TF_Housing_adq[aw=finalweight] if district==81
gen B_S_Mo_Housing_adq=r(mean)

sum ind_cen_40_TF_tv [aw=finalweight] if district==81
gen B_S_Mo_tv=r(mean)

sum ind_cen_40_TF_mobile [aw=finalweight] if district==81
gen B_S_Mo_mobile=r(mean)

sum ind_cen_40_TF_closaty [aw=finalweight]if district==81
gen B_S_Mo_closaty=r(mean)

sum ind_cen_40_TF_buyclot [aw=finalweight] if district==81
gen B_S_Mo_buyclot=r(mean)

sum ind_cen_40_TF_clodq [aw=finalweight] if district==81
gen B_S_Mo_clodq=r(mean)

fsum  B_S_Mo_*

*Percentage Share of population MPI poor and deprived in  Badulla as a share of total MPI in badulla:

foreach var in B_S_Mo_wall B_S_Mo_floor B_S_Mo_elec B_S_Mo_safedw B_S_Mo_toiTp B_S_Mo_room B_S_Mo_Housing_struc B_S_Mo_Fl_area B_S_Mo_ownership B_S_Mo_Toiletuse B_S_Mo_housing_satis B_S_Mo_Housing_adq B_S_Mo_tv B_S_Mo_mobile B_S_Mo_closaty B_S_Mo_buyclot B_S_Mo_clodq {	
	
	gen	P_`var' = (`var'/BM0)*100
	lab var P_`var'   "Percentage contribution to "
	}


fsum  P_B_S_Mo_*

*Share of population MPI poor and deprived in Badulla urban :(A0 for Badulla urban )

sum ind_cen_40_TF_wall [aw=finalweight] if domaincode==811
gen BU_S_Mo_wall=r(mean)

sum ind_cen_40_TF_floor [aw=finalweight] if domaincode==811
gen BU_S_Mo_floor=r(mean)

sum ind_cen_40_TF_elec [aw=finalweight] if domaincode==811
gen BU_S_Mo_elec=r(mean)

sum ind_cen_40_TF_safedw [aw=finalweight] if domaincode==811
gen BU_S_Mo_safedw=r(mean)

sum ind_cen_40_TF_toiTp [aw=finalweight] if domaincode==811
gen BU_S_Mo_toiTp=r(mean)

sum ind_cen_40_TF_room [aw=finalweight] if domaincode==811
gen BU_S_Mo_room=r(mean)

sum ind_cen_40_TF_Housing_struc [aw=finalweight] if domaincode==811
gen BU_S_Mo_Housing_struc=r(mean)

sum ind_cen_40_TF_Fl_area [aw=finalweight] if domaincode==811
gen BU_S_Mo_Fl_area=r(mean)

sum ind_cen_40_TF_ownership [aw=finalweight] if domaincode==811
gen BU_S_Mo_ownership=r(mean)

sum ind_cen_40_TF_Toiletuse [aw=finalweight] if domaincode==811
gen BU_S_Mo_Toiletuse=r(mean)

sum ind_cen_40_TF_housing_satis [aw=finalweight] if domaincode==811
gen BU_S_Mo_housing_satis=r(mean)

sum ind_cen_40_TF_Housing_adq[aw=finalweight] if domaincode==811
gen BU_S_Mo_Housing_adq=r(mean)

sum ind_cen_40_TF_tv [aw=finalweight] if domaincode==811
gen BU_S_Mo_tv=r(mean)

sum ind_cen_40_TF_mobile [aw=finalweight] if domaincode==811
gen BU_S_Mo_mobile=r(mean)

sum ind_cen_40_TF_closaty [aw=finalweight]if domaincode==811
gen BU_S_Mo_closaty=r(mean)

sum ind_cen_40_TF_buyclot [aw=finalweight] if domaincode==811
gen BU_S_Mo_buyclot=r(mean)

sum ind_cen_40_TF_clodq [aw=finalweight] if domaincode==811
gen BU_S_Mo_clodq=r(mean)

fsum  BU_S_Mo_*

*Percentage Share of population MPI poor and deprived in Badulla urban:

foreach var in BU_S_Mo_wall BU_S_Mo_floor BU_S_Mo_elec BU_S_Mo_safedw BU_S_Mo_toiTp BU_S_Mo_room BU_S_Mo_Housing_struc BU_S_Mo_Fl_area BU_S_Mo_ownership BU_S_Mo_Toiletuse BU_S_Mo_housing_satis BU_S_Mo_Housing_adq BU_S_Mo_tv BU_S_Mo_mobile BU_S_Mo_closaty BU_S_Mo_buyclot BU_S_Mo_clodq {	
	
	gen	P_`var' = (`var'/BU_M0)*100
	lab var P_`var'   "Percentage contribution to "
	}


fsum  P_BU_S_Mo_*

svyset psu [pw = finalweight], strata(domaincode)
svy: mean BU_S_Mo_*

*Share of population MPI poor and deprived in Badulla rural :(A0 for Badulla rural )

sum ind_cen_40_TF_wall [aw=finalweight] if domaincode==812
gen BR_S_Mo_wall=r(mean)

sum ind_cen_40_TF_floor [aw=finalweight] if domaincode==812
gen BR_S_Mo_floor=r(mean)

sum ind_cen_40_TF_elec [aw=finalweight] if domaincode==812
gen BR_S_Mo_elec=r(mean)

sum ind_cen_40_TF_safedw [aw=finalweight] if domaincode==812
gen BR_S_Mo_safedw=r(mean)

sum ind_cen_40_TF_toiTp [aw=finalweight] if domaincode==812
gen BR_S_Mo_toiTp=r(mean)

sum ind_cen_40_TF_room [aw=finalweight] if domaincode==812
gen BR_S_Mo_room=r(mean)

sum ind_cen_40_TF_Housing_struc [aw=finalweight] if domaincode==812
gen BR_S_Mo_Housing_struc=r(mean)

sum ind_cen_40_TF_Fl_area [aw=finalweight] if domaincode==812
gen BR_S_Mo_Fl_area=r(mean)

sum ind_cen_40_TF_ownership [aw=finalweight] if domaincode==812
gen BR_S_Mo_ownership=r(mean)

sum ind_cen_40_TF_Toiletuse [aw=finalweight] if domaincode==812
gen BR_S_Mo_Toiletuse=r(mean)

sum ind_cen_40_TF_housing_satis [aw=finalweight] if domaincode==812
gen BR_S_Mo_housing_satis=r(mean)

sum ind_cen_40_TF_Housing_adq[aw=finalweight] if domaincode==812
gen BR_S_Mo_Housing_adq=r(mean)

sum ind_cen_40_TF_tv [aw=finalweight] if domaincode==812
gen BR_S_Mo_tv=r(mean)

sum ind_cen_40_TF_mobile [aw=finalweight] if domaincode==812
gen BR_S_Mo_mobile=r(mean)

sum ind_cen_40_TF_closaty [aw=finalweight]if domaincode==812
gen BR_S_Mo_closaty=r(mean)

sum ind_cen_40_TF_buyclot [aw=finalweight] if domaincode==812
gen BR_S_Mo_buyclot=r(mean)

sum ind_cen_40_TF_clodq [aw=finalweight] if domaincode==812
gen BR_S_Mo_clodq=r(mean)

*Percentage Share of population MPI poor and deprived in :

foreach var in BR_S_Mo_wall BR_S_Mo_floor BR_S_Mo_elec BR_S_Mo_safedw BR_S_Mo_toiTp BR_S_Mo_room BR_S_Mo_Housing_struc BR_S_Mo_Fl_area BR_S_Mo_ownership BR_S_Mo_Toiletuse BR_S_Mo_housing_satis BR_S_Mo_Housing_adq BR_S_Mo_tv BR_S_Mo_mobile BR_S_Mo_closaty BR_S_Mo_buyclot BR_S_Mo_clodq {	
	
	gen	P_`var' = (`var'/BR_M0)*100
	lab var P_`var'   "Percentage contribution to "
	}


fsum  P_BR_S_Mo_*

svyset psu [pw = finalweight], strata(domaincode)
svy: mean BR_S_Mo_*

*Share of population MPI poor and deprived in Badulla Estate :(A0 for Badulla Estate )

sum ind_cen_40_TF_wall [aw=finalweight] if domaincode==813
gen BE_S_Mo_wall=r(mean)

sum ind_cen_40_TF_floor [aw=finalweight] if domaincode==813
gen BE_S_Mo_floor=r(mean)

sum ind_cen_40_TF_elec [aw=finalweight] if domaincode==813
gen BE_S_Mo_elec=r(mean)

sum ind_cen_40_TF_safedw [aw=finalweight] if domaincode==813
gen BE_S_Mo_safedw=r(mean)

sum ind_cen_40_TF_toiTp [aw=finalweight] if domaincode==813
gen BE_S_Mo_toiTp=r(mean)

sum ind_cen_40_TF_room [aw=finalweight] if domaincode==813
gen BE_S_Mo_room=r(mean)

sum ind_cen_40_TF_Housing_struc [aw=finalweight] if domaincode==813
gen BE_S_Mo_Housing_struc=r(mean)

sum ind_cen_40_TF_Fl_area [aw=finalweight] if domaincode==813
gen BE_S_Mo_Fl_area=r(mean)

sum ind_cen_40_TF_ownership [aw=finalweight] if domaincode==813
gen BE_S_Mo_ownership=r(mean)

sum ind_cen_40_TF_Toiletuse [aw=finalweight] if domaincode==813
gen BE_S_Mo_Toiletuse=r(mean)

sum ind_cen_40_TF_housing_satis [aw=finalweight] if domaincode==813
gen BE_S_Mo_housing_satis=r(mean)

sum ind_cen_40_TF_Housing_adq[aw=finalweight] if domaincode==813
gen BE_S_Mo_Housing_adq=r(mean)

sum ind_cen_40_TF_tv [aw=finalweight] if domaincode==813
gen BE_S_Mo_tv=r(mean)

sum ind_cen_40_TF_mobile [aw=finalweight] if domaincode==813
gen BE_S_Mo_mobile=r(mean)

sum ind_cen_40_TF_closaty [aw=finalweight]if domaincode==813
gen BE_S_Mo_closaty=r(mean)

sum ind_cen_40_TF_buyclot [aw=finalweight] if domaincode==813
gen BE_S_Mo_buyclot=r(mean)

sum ind_cen_40_TF_clodq [aw=finalweight] if domaincode==813
gen BE_S_Mo_clodq=r(mean)

*Percentage Share of population MPI poor and deprived in :

foreach var in BE_S_Mo_wall BE_S_Mo_floor BE_S_Mo_elec BE_S_Mo_safedw BE_S_Mo_toiTp BE_S_Mo_room BE_S_Mo_Housing_struc BE_S_Mo_Fl_area BE_S_Mo_ownership BE_S_Mo_Toiletuse BE_S_Mo_housing_satis BE_S_Mo_Housing_adq BE_S_Mo_tv BE_S_Mo_mobile BE_S_Mo_closaty BE_S_Mo_buyclot BE_S_Mo_clodq {	
	
	gen	P_`var' = (`var'/BE_M0)*100
	lab var P_`var'   "Percentage contribution to "
	}


fsum  P_BE_S_Mo_*

svyset psu [pw = finalweight], strata(domaincode)
svy: mean BE_S_Mo_*

*Share of population MPI poor and deprived in Moneragala district:(A0 for Moneragala district )

sum ind_cen_40_TF_wall [aw=finalweight] if district==82
gen M_S_Mo_wall=r(mean)

sum ind_cen_40_TF_floor [aw=finalweight] if district==82
gen M_S_Mo_floor=r(mean)

sum ind_cen_40_TF_elec [aw=finalweight] if district==82
gen M_S_Mo_elec=r(mean)

sum ind_cen_40_TF_safedw [aw=finalweight] if district==82
gen M_S_Mo_safedw=r(mean)

sum ind_cen_40_TF_toiTp [aw=finalweight] if district==82
gen M_S_Mo_toiTp=r(mean)

sum ind_cen_40_TF_room [aw=finalweight] if district==82
gen M_S_Mo_room=r(mean)

sum ind_cen_40_TF_Housing_struc [aw=finalweight] if district==82
gen M_S_Mo_Housing_struc=r(mean)

sum ind_cen_40_TF_Fl_area [aw=finalweight] if district==82
gen M_S_Mo_Fl_area=r(mean)

sum ind_cen_40_TF_ownership [aw=finalweight] if district==82
gen M_S_Mo_ownership=r(mean)

sum ind_cen_40_TF_Toiletuse [aw=finalweight] if district==82
gen M_S_Mo_Toiletuse=r(mean)

sum ind_cen_40_TF_housing_satis [aw=finalweight] if district==82
gen M_S_Mo_housing_satis=r(mean)

sum ind_cen_40_TF_Housing_adq[aw=finalweight] if district==82
gen M_S_Mo_Housing_adq=r(mean)

sum ind_cen_40_TF_tv [aw=finalweight] if district==82
gen M_S_Mo_tv=r(mean)

sum ind_cen_40_TF_mobile [aw=finalweight] if district==82
gen M_S_Mo_mobile=r(mean)

sum ind_cen_40_TF_closaty [aw=finalweight]if district==82
gen M_S_Mo_closaty=r(mean)

sum ind_cen_40_TF_buyclot [aw=finalweight] if district==82
gen M_S_Mo_buyclot=r(mean)

sum ind_cen_40_TF_clodq [aw=finalweight] if district==82
gen M_S_Mo_clodq=r(mean)

*Percentage Share of population MPI poor and deprived in :

foreach var in M_S_Mo_wall M_S_Mo_floor M_S_Mo_elec M_S_Mo_safedw M_S_Mo_toiTp M_S_Mo_room M_S_Mo_Housing_struc M_S_Mo_Fl_area M_S_Mo_ownership M_S_Mo_Toiletuse M_S_Mo_housing_satis M_S_Mo_Housing_adq M_S_Mo_tv M_S_Mo_mobile M_S_Mo_closaty M_S_Mo_buyclot M_S_Mo_clodq {	
	
	gen	P_`var' = (`var'/MM0)*100
	lab var P_`var'   "Percentage contribution to "
	}


fsum  P_M_S_Mo_*


*Share of population MPI poor and deprived in Moneragala Rural :(A0 for Moneragala Rural )


sum ind_cen_40_TF_wall [aw=finalweight] if domaincode==822
gen MR_S_Mo_wall=r(mean)

sum ind_cen_40_TF_floor [aw=finalweight] if domaincode==822
gen MR_S_Mo_floor=r(mean)

sum ind_cen_40_TF_elec [aw=finalweight] if domaincode==822
gen MR_S_Mo_elec=r(mean)

sum ind_cen_40_TF_safedw [aw=finalweight] if domaincode==822
gen MR_S_Mo_safedw=r(mean)

sum ind_cen_40_TF_toiTp [aw=finalweight] if domaincode==822
gen MR_S_Mo_toiTp=r(mean)

sum ind_cen_40_TF_room [aw=finalweight] if domaincode==822
gen MR_S_Mo_room=r(mean)

sum ind_cen_40_TF_Housing_struc [aw=finalweight] if domaincode==822
gen MR_S_Mo_Housing_struc=r(mean)

sum ind_cen_40_TF_Fl_area [aw=finalweight] if domaincode==822
gen MR_S_Mo_Fl_area=r(mean)

sum ind_cen_40_TF_ownership [aw=finalweight] if domaincode==822
gen MR_S_Mo_ownership=r(mean)

sum ind_cen_40_TF_Toiletuse [aw=finalweight] if domaincode==822
gen MR_S_Mo_Toiletuse=r(mean)

sum ind_cen_40_TF_housing_satis [aw=finalweight] if domaincode==822
gen MR_S_Mo_housing_satis=r(mean)

sum ind_cen_40_TF_Housing_adq[aw=finalweight] if domaincode==822
gen MR_S_Mo_Housing_adq=r(mean)

sum ind_cen_40_TF_tv [aw=finalweight] if domaincode==822
gen MR_S_Mo_tv=r(mean)

sum ind_cen_40_TF_mobile [aw=finalweight] if domaincode==822
gen MR_S_Mo_mobile=r(mean)

sum ind_cen_40_TF_closaty [aw=finalweight]if domaincode==822
gen MR_S_Mo_closaty=r(mean)

sum ind_cen_40_TF_buyclot [aw=finalweight] if domaincode==822
gen MR_S_Mo_buyclot=r(mean)

sum ind_cen_40_TF_clodq [aw=finalweight] if domaincode==822
gen MR_S_Mo_clodq=r(mean)

*Percentage Share of population MPI poor and deprived in :

foreach var in MR_S_Mo_wall MR_S_Mo_floor MR_S_Mo_elec MR_S_Mo_safedw MR_S_Mo_toiTp MR_S_Mo_room MR_S_Mo_Housing_struc MR_S_Mo_Fl_area MR_S_Mo_ownership MR_S_Mo_Toiletuse MR_S_Mo_housing_satis MR_S_Mo_Housing_adq MR_S_Mo_tv MR_S_Mo_mobile MR_S_Mo_closaty MR_S_Mo_buyclot MR_S_Mo_clodq {	
	
	gen	P_`var' = (`var'/MR_M0)*100
	lab var P_`var'   "Percentage contribution to "
	}


fsum  P_MR_S_Mo_*

svyset psu [pw = finalweight], strata(domaincode)
svy: mean MR_S_Mo_*




*Share of population MPI poor and deprived in Moneragala Estate :(A0 for Moneragala Estate )


sum ind_cen_40_TF_wall [aw=finalweight] if domaincode==823
gen ME_S_Mo_wall=r(mean)

sum ind_cen_40_TF_floor [aw=finalweight] if domaincode==823
gen ME_S_Mo_floor=r(mean)

sum ind_cen_40_TF_elec [aw=finalweight] if domaincode==823
gen ME_S_Mo_elec=r(mean)

sum ind_cen_40_TF_safedw [aw=finalweight] if domaincode==823
gen ME_S_Mo_safedw=r(mean)

sum ind_cen_40_TF_toiTp [aw=finalweight] if domaincode==823
gen ME_S_Mo_toiTp=r(mean)

sum ind_cen_40_TF_room [aw=finalweight] if domaincode==823
gen ME_S_Mo_room=r(mean)

sum ind_cen_40_TF_Housing_struc [aw=finalweight] if domaincode==823
gen ME_S_Mo_Housing_struc=r(mean)

sum ind_cen_40_TF_Fl_area [aw=finalweight] if domaincode==823
gen ME_S_Mo_Fl_area=r(mean)

sum ind_cen_40_TF_ownership [aw=finalweight] if domaincode==823
gen ME_S_Mo_ownership=r(mean)

sum ind_cen_40_TF_Toiletuse [aw=finalweight] if domaincode==823
gen ME_S_Mo_Toiletuse=r(mean)

sum ind_cen_40_TF_housing_satis [aw=finalweight] if domaincode==823
gen ME_S_Mo_housing_satis=r(mean)

sum ind_cen_40_TF_Housing_adq[aw=finalweight] if domaincode==823
gen ME_S_Mo_Housing_adq=r(mean)

sum ind_cen_40_TF_tv [aw=finalweight] if domaincode==823
gen ME_S_Mo_tv=r(mean)

sum ind_cen_40_TF_mobile [aw=finalweight] if domaincode==823
gen ME_S_Mo_mobile=r(mean)

sum ind_cen_40_TF_closaty [aw=finalweight]if domaincode==823
gen ME_S_Mo_closaty=r(mean)

sum ind_cen_40_TF_buyclot [aw=finalweight] if domaincode==823
gen ME_S_Mo_buyclot=r(mean)

sum ind_cen_40_TF_clodq [aw=finalweight] if domaincode==823
gen ME_S_Mo_clodq=r(mean)

*Percentage Share of population MPI poor and deprived in :

foreach var in ME_S_Mo_wall ME_S_Mo_floor ME_S_Mo_elec ME_S_Mo_safedw ME_S_Mo_toiTp ME_S_Mo_room ME_S_Mo_Housing_struc ME_S_Mo_Fl_area ME_S_Mo_ownership ME_S_Mo_Toiletuse ME_S_Mo_housing_satis ME_S_Mo_Housing_adq ME_S_Mo_tv ME_S_Mo_mobile ME_S_Mo_closaty ME_S_Mo_buyclot ME_S_Mo_clodq {	
	
	gen	P_`var' = (`var'/ME_M0)*100
	lab var P_`var'   "Percentage contribution to "
	}


fsum  P_ME_S_Mo_*

svyset psu [pw = finalweight], strata(domaincode)
svy: mean ME_S_Mo_*

************************************************************
* PLANTATION AREA AND PLANTATION AREA
*************************************************************
*Share of population MPI poor and deprived in Plantation sector:(A0 for Plantation area )

********Plantation Are**********

sum ind_cen_40_TF_wall [aw=finalweight] if plant_Are==1
gen PL_S_Mo_wall=r(mean)

sum ind_cen_40_TF_floor [aw=finalweight] if plant_Are==1
gen PL_S_Mo_floor=r(mean)

sum ind_cen_40_TF_elec [aw=finalweight] if plant_Are==1
gen PL_S_Mo_elec=r(mean)

sum ind_cen_40_TF_safedw [aw=finalweight] if plant_Are==1
gen PL_S_Mo_safedw=r(mean)

sum ind_cen_40_TF_toiTp [aw=finalweight] if plant_Are==1
gen PL_S_Mo_toiTp=r(mean)

sum ind_cen_40_TF_room [aw=finalweight] if plant_Are==1
gen PL_S_Mo_room=r(mean)

sum ind_cen_40_TF_Housing_struc [aw=finalweight] if plant_Are==1
gen PL_S_Mo_Housing_struc=r(mean)

sum ind_cen_40_TF_Fl_area [aw=finalweight] if plant_Are==1
gen PL_S_Mo_Fl_area=r(mean)

sum ind_cen_40_TF_ownership [aw=finalweight] if plant_Are==1
gen PL_S_Mo_ownership=r(mean)

sum ind_cen_40_TF_Toiletuse [aw=finalweight] if plant_Are==1
gen PL_S_Mo_Toiletuse=r(mean)

sum ind_cen_40_TF_housing_satis [aw=finalweight] if plant_Are==1
gen PL_S_Mo_housing_satis=r(mean)

sum ind_cen_40_TF_Housing_adq[aw=finalweight] if plant_Are==1
gen PL_S_Mo_Housing_adq=r(mean)

sum ind_cen_40_TF_tv [aw=finalweight] if plant_Are==1
gen PL_S_Mo_tv=r(mean)

sum ind_cen_40_TF_mobile [aw=finalweight] if plant_Are==1
gen PL_S_Mo_mobile=r(mean)

sum ind_cen_40_TF_closaty [aw=finalweight]if plant_Are==1
gen PL_S_Mo_closaty=r(mean)

sum ind_cen_40_TF_buyclot [aw=finalweight] if plant_Are==1
gen PL_S_Mo_buyclot=r(mean)

sum ind_cen_40_TF_clodq [aw=finalweight] if plant_Are==1
gen PL_S_Mo_clodq=r(mean)

*Percentage Share of population MPI poor and deprived in :

foreach var in PL_S_Mo_wall PL_S_Mo_floor PL_S_Mo_elec PL_S_Mo_safedw PL_S_Mo_toiTp PL_S_Mo_room PL_S_Mo_Housing_struc PL_S_Mo_Fl_area PL_S_Mo_ownership PL_S_Mo_Toiletuse PL_S_Mo_housing_satis PL_S_Mo_Housing_adq PL_S_Mo_tv PL_S_Mo_mobile PL_S_Mo_closaty PL_S_Mo_buyclot PL_S_Mo_clodq {	
	
	gen	P_`var' = (`var'/PL_M0)*100
	lab var P_`var'   "Percentage contribution to "
	}


fsum  P_PL_S_Mo_*

svyset psu [pw = finalweight], strata(domaincode)
svy: mean PL_S_Mo_*

************************************************************
* PLANTATION AREA AND NON-PLANTATION AREA
*************************************************************
*Share of population MPI poor and deprived in Plantation sector:(A0 for Plantation area )


sum ind_cen_40_TF_wall [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_wall=r(mean)

sum ind_cen_40_TF_floor [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_floor=r(mean)

sum ind_cen_40_TF_elec [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_elec=r(mean)

sum ind_cen_40_TF_safedw [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_safedw=r(mean)

sum ind_cen_40_TF_toiTp [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_toiTp=r(mean)

sum ind_cen_40_TF_room [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_room=r(mean)

sum ind_cen_40_TF_Housing_struc [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_Housing_struc=r(mean)

sum ind_cen_40_TF_Fl_area [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_Fl_area=r(mean)

sum ind_cen_40_TF_ownership [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_ownership=r(mean)

sum ind_cen_40_TF_Toiletuse [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_Toiletuse=r(mean)

sum ind_cen_40_TF_housing_satis [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_housing_satis=r(mean)

sum ind_cen_40_TF_Housing_adq[aw=finalweight] if plant_Are==0
gen NPL_S_Mo_Housing_adq=r(mean)

sum ind_cen_40_TF_tv [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_tv=r(mean)

sum ind_cen_40_TF_mobile [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_mobile=r(mean)

sum ind_cen_40_TF_closaty [aw=finalweight]if plant_Are==0
gen NPL_S_Mo_closaty=r(mean)

sum ind_cen_40_TF_buyclot [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_buyclot=r(mean)

sum ind_cen_40_TF_clodq [aw=finalweight] if plant_Are==0
gen NPL_S_Mo_clodq=r(mean)

*Percentage Share of population MPI poor and deprived in :

foreach var in NPL_S_Mo_wall NPL_S_Mo_floor NPL_S_Mo_elec NPL_S_Mo_safedw NPL_S_Mo_toiTp NPL_S_Mo_room NPL_S_Mo_Housing_struc NPL_S_Mo_Fl_area NPL_S_Mo_ownership NPL_S_Mo_Toiletuse NPL_S_Mo_housing_satis NPL_S_Mo_Housing_adq NPL_S_Mo_tv NPL_S_Mo_mobile NPL_S_Mo_closaty NPL_S_Mo_buyclot NPL_S_Mo_clodq {	
	
	gen	P_`var' = (`var'/NPL_M0)*100
	lab var P_`var'   "Percentage contribution to "
	}


fsum  P_NPL_S_Mo_*

svyset psu [pw = finalweight], strata(domaincode)
svy: mean NPL_S_Mo_*

******Extra Tables*********
*mean of fuzzy score by indicators********
mean TF_* if  multid_Fzypoor_40==1

gen P_TF_wall=TF_wall*100
gen P_TF_floor=TF_floor*100
gen P_TF_elec=TF_elec*100
gen P_TF_safedw=TF_safedw*100
gen P_TF_toiTp=TF_toiTp*100
gen P_TF_room=TF_room*100
gen P_TF_Housing_struc=TF_Housing_struc*100
gen P_TF_Fl_area=TF_Fl_area*100
gen P_TF_ownership=TF_ownership*100
gen P_TF_Toiletuse=TF_Toiletuse*100
gen P_TF_housing_satis=TF_housing_satis*100
gen P_TF_Housing_adq=TF_Housing_adq*100
gen P_TF_tv=TF_tv*100
gen P_TF_mobile=TF_mobile*100
gen P_TF_closaty=TF_closaty*100
gen P_TF_buyclot=TF_buyclot*100
gen P_TF_clodq=TF_clodq*100

mean P_TF_* if multid_Fzypoor_40==1 
tabstat	P_TF_*[aweight=finalweight],statistics(	mean)by(domaincode)columns(variables)


**********Diamension Analysis**************
**********Housing, durable and basicrequirement *****************


* Counting vector:
egen D1_c_vector = rowtotal(TF_wall TF_floor TF_elec TF_safedw TF_toiTp TF_room TF_Housing_struc TF_Fl_area TF_ownership TF_Toiletuse TF_housing_satis TF_Housing_adq)
lab var D1_c_vector "Counting Vector for Housing Dimension"
*tab D1_c_vector [aw = finalweight], m

egen D2_c_vector = rowtotal( TF_tv TF_mobile)
lab var D2_c_vector "Counting Vector for Durable Goods"
*tab D2_c_vector [aw = finalweight], m

egen D3_c_vector = rowtotal(TF_closaty TF_buyclot TF_clodq)
lab var D3_c_vector "Counting Vector for Clothing"
*tab D3_c_vector [aw = finalweight], m


*Censored deprivation matrix:
local k=40

gen cen_D1_c_vector= D1_c_vector
replace cen_D1_c_vector=0  if multid_poor_`k'==0

gen cen_D2_c_vector= D2_c_vector
replace cen_D2_c_vector=0  if multid_poor_`k'==0

gen cen_D3_c_vector= D3_c_vector
replace cen_D3_c_vector=0  if multid_poor_`k'==0

****Ajusted deprivation index (MPI) for material deprivation by dimensions*************
svyset psu [pw = finalweight], strata(domaincode)
svy linearized  : mean cen_D1_c_vector
svy linearized  : mean cen_D2_c_vector
svy linearized  : mean cen_D3_c_vector

sum	cen_D1_c_vector [aw = finalweight]
gen	D1_M0 = r(mean)
lab var D1_M0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1 for Housing Amenities "

sum	cen_D2_c_vector [aw = finalweight]
gen	D2_M0 = r(mean)
lab var D2_M0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1 for Durable goods"

sum	cen_D3_c_vector [aw = finalweight]
gen	D3_M0 = r(mean)
lab var D3_M0 "Adjusted Fuzzy Headcount Ratio (M0 = H*A): Range 0 to 1 for Basic requirement "


sum  D1_M0 D2_M0 D3_M0 [aw = finalweight]

*Percentage Share of population MPI poor and deprived in :

foreach var in D1_M0 D2_M0 D3_M0 {	
	
	gen	P_`var' = (`var'/M0)*100
	lab var P_`var'   "Percentage dimensional contribution to M0"
	}


fsum  P_D1_M0  P_D2_M0 P_D3_M0

*Percentage Share of deprivation of indicatiors to Housing  :
foreach var in S_Mo_wall S_Mo_floor S_Mo_elec S_Mo_safedw S_Mo_toiTp S_Mo_room S_Mo_Housing_struc S_Mo_Fl_area S_Mo_ownership S_Mo_Toiletuse S_Mo_housing_satis S_Mo_Housing_adq {	
	
	gen	PD_D1_`var' =(`var'/D1_M0)*100
	lab var PD_D1_`var'   "Percentage dimensional contribution of housing indicator to total hosing diamention"
	}

fsum  PD_D1_* 


*Percentage Share of deprivation of indicatiors to Consumer Durables  :
foreach var in S_Mo_tv S_Mo_mobile{	
	
	gen	PD_D2_`var' =(`var'/D2_M0)*100
	lab var PD_D2_`var'   "Percentage dimensional contribution of housing indicator to total Consumer Durables"
	}

fsum  PD_D2_* 


*Percentage Share of deprivation of indicatiors to Basic Lifestyle   :

foreach var in S_Mo_closaty S_Mo_buyclot S_Mo_clodq{	
	
	gen	PD_D3_`var' =(`var'/D3_M0)*100
	lab var PD_D3_`var'   "Percentage dimensional contribution of housing indicator to total Basic Lifestyle "
	}

fsum  PD_D3_*



sort sector district psu ssu hhuno sno1	
save "MD_Fuzzy.dta",replace

capture log close



translate "Fuzzy_Material_dip.smcl" "Fuzzy_Material_dip.txt", replace

********Furthet analysis*******
*kdensity Total_Fuzzy


*******Normalized Deprivation Gap Index (SGI)
*cens_c_vector means weighted deprivation score
gen z=0.4
gen D_gap = cens_c_vector_ - z if multid_poor_40==1 
replace D_gap=0 if D_gap==.


gen N_D_gap =  D_gap/z
replace N_D_gap =0 if N_D_gap ==.
mean N_D_gap [aw = finalweight]

svyset psu [pw = finalweight], strata(domaincode)
svy: mean N_D_gap

sum	N_D_gap [aw = finalweight]  
gen	GI = r(mean)
lab var GI  "Normalized Deprivation Gap index "


svy: mean N_D_gap  if district==81
svy: mean N_D_gap  if domaincode==811
svy: mean N_D_gap  if domaincode==812
svy: mean N_D_gap  if domaincode==813
svy: mean N_D_gap  if district==82
svy: mean N_D_gap  if domaincode==822
svy: mean N_D_gap  if domaincode==823

***AJUSTED DEPRIVATION GAP INDEX (FM1)**************


gen FM1= H*A*GI
sum	FM1 [aw = finalweight]

svyset psu [pw = finalweight], strata(domaincode)
svy:mean FM1 

*Other way should be 
*not correct
*svyset psu [pw = finalweight], strata(domaincode)
*svy:mean N_D_gap 



*******Squared Normalized Deprivation Gap Index (SGI)

gen S_N_D_gap =N_D_gap^2 

replace S_N_D_gap =0 if S_N_D_gap ==.
mean S_N_D_gap [aw = finalweight]
svyset psu [pw = finalweight], strata(domaincode)
svy: mean S_N_D_gap



svy:mean S_N_D_gap  if district==81
svy:mean S_N_D_gap  if domaincode==811
svy:mean S_N_D_gap  if domaincode==812
svy:mean S_N_D_gap  if domaincode==813
svy:mean S_N_D_gap  if district==82
svy:mean S_N_D_gap  if domaincode==822
svy:mean S_N_D_gap  if domaincode==823


***AJUSTED SQURED DEPRIVATION GAP INDEX (FM2)**************
sum	S_N_D_gap [aw = finalweight] 
gen	SGI = r(mean)
lab var SGI  "Normalized Squred Deprivation Gap index "


gen FM2= H*A*SGI 
sum	FM2 [aw = finalweight]

svyset psu [pw = finalweight], strata(domaincode)
svy:mean FM2 

*Other way should be 
*not correct
*svyset psu [pw = finalweight], strata(domaincode)
*svy:mean S_N_D_gap 

*****************************************
*Uva  group analysis**
*doest not give correct CI as we have got means of estimates in a colum
*****************************************

svyset psu [pw = finalweight], strata(domaincode)
svy linearized: mean H A M0
svy: mean BH BA BM0
svy: mean MH MA MM0
svy: mean BU_H BU_A BU_M0
svy: mean BR_H BR_A BR_M0
svy: mean BE_H BE_A BE_M0
svy: mean MR_H MR_A MR_M0
svy: mean ME_H ME_A ME_M0

svyset psu [pw = finalweight], strata(domaincode)
svy linearized, subpop(if domaincode==811) : mean cens_c_vector_40, over(domaincode)
svy linearized, subpop(if domaincode==812) : mean cens_c_vector_40, over(domaincode)
svy linearized, subpop(if domaincode==813) : mean cens_c_vector_40, over(domaincode)
svy linearized, subpop(if domaincode==822) : mean cens_c_vector_40, over(domaincode)
svy linearized, subpop(if domaincode==823) : mean cens_c_vector_40, over(domaincode)




*****************************************
*Uva sub group analysis
*****************************************
*weighted fuzzy deprivation score

svyset psu [pw = finalweight], strata(domaincode)
svy linearized   : mean Total_Fuzzy
svy	linearized	:	mean TF_*
svy	linearized	:	mean D1_c_vector
svy	linearized	:	mean D2_c_vector
svy	linearized	:	mean D3_c_vecto

********Furthet analysis*******
*kdensity c_vector
*hist Total_Fuzzy, frequency kdensity



svyset psu [pw = finalweight], strata(domaincode)
svy linearized : mean Total_Fuzzy
svy linearized : mean Total_Fuzzy,over(plant_Are)
svy linearized : mean Total_Fuzzy,over(edulevel)
svy linearized : mean Total_Fuzzy,over(emp_status)
svy linearized : mean Total_Fuzzy,over(SectorUR)
svy linearized : mean Total_Fuzzy, over(agegroups)


*H for uva by ;
svyset psu [pw = finalweight], strata(domaincode)
svy linearized : mean multid_poor_40 
svy linearized : mean multid_poor_40, over(plant_Are)
svy linearized : mean multid_poor_40, over(edulevel)
svy linearized : mean multid_poor_40, over(emp_status)
svy linearized : mean multid_poor_40, over(SectorUR)
svy linearized : mean multid_poor_40, over(agegroups)

*A for uva by ;

svyset psu [pw = finalweight], strata(domaincode)
svy linearized, subpop(if multid_poor_40==1) : mean cens_c_vector_40
svy linearized, subpop(if multid_poor_40==1) : mean cens_c_vector_40, over(plant_Are)
svy linearized, subpop(if multid_poor_40==1) : mean cens_c_vector_40, over(edulevel)
svy linearized, subpop(if multid_poor_40==1) : mean cens_c_vector_40, over(emp_status)
svy linearized, subpop(if multid_poor_40==1) : mean cens_c_vector_40, over(SectorUR)
svy linearized, subpop(if multid_poor_40==1) : mean cens_c_vector_40, over(agegroups)


*M0 for uva by ;

svyset psu [pw = finalweight], strata(domaincode)
svy linearized : mean cens_c_vector_40
svy linearized : mean cens_c_vector_40, over(plant_Are)
svy linearized : mean cens_c_vector_40, over(edulevel)
svy linearized : mean cens_c_vector_40, over(emp_status)
svy linearized : mean cens_c_vector_40, over(SectorUR)
svy linearized : mean cens_c_vector_40, over(agegroups)


*******Normalized Deprivation Gap Index (FM1)
*
svyset psu [pw = finalweight], strata(domaincode)
svy linearized : mean N_D_gap
svy	linearized : mean N_D_gap,over(plant_Are)
svy	linearized : mean N_D_gap,over(sector)
svy	linearized : mean N_D_gap,over(edulevel)
svy	linearized : mean N_D_gap,over(emp_status)
svy	linearized : mean N_D_gap,over(agegroups)
svy	linearized : mean N_D_gap,over(mainind)

*******Squared Normalized Deprivation Gap Index (FM2

svy linearized : mean S_N_D_gap
svy	linearized : mean S_N_D_gap,over(plant_Are)
svy	linearized : mean S_N_D_gap,over(sector)
svy	linearized : mean S_N_D_gap,over(edulevel)
svy	linearized : mean S_N_D_gap,over(emp_status)
svy	linearized : mean S_N_D_gap,over(agegroups)
svy	linearized : mean S_N_D_gap,over(mainind)


*Percentage Share of population MPI poor and deprived in :

fsum   P_S_Mo_*	

svyset psu [pw = finalweight], strata(domaincode)
svy linearized : mean P_S_Mo_*	

*Percentage Share of population MPI poor and deprived in :

fsum  P_D1_M0  P_D2_M0 P_D3_M0

svyset psu [pw = finalweight], strata(domaincode)
svy linearized : mean (P_D1_M0  P_D2_M0 P_D3_M0)


**Adjusted headcount index M0 Uva*(if need CI need to analyse in this way )********

svyset psu [pw = finalweight], strata(domaincode)
svy linearized : mean cens_c_vector_40


**Adjusted headcount index M0 by indicator*********

svyset psu [pw = finalweight], strata(domaincode)
svy linearized : mean ind_cen_40_*	




**Adjusted headcount index M0 by diamension(D1,D2,D3)*********


sum	cen_D1_c_vector [aw = finalweight]
sum	cen_D2_c_vector [aw = finalweight]
sum	cen_D3_c_vector [aw = finalweight]

svyset psu [pw = finalweight], strata(domaincode)
svy linearized :mean cen_D1_c_vector	
svy linearized :mean cen_D2_c_vector
svy linearized :mean cen_D3_c_vector


******************TFR Approch****************
*variable Creation only for catogerical variables 
* run the frequancy distribution of each variable seperately in TFR_method do file and copied to Excel and assing to this file
*
recode Housing_struc (1 =3)(2=2)(3=1),gen (TFR_Hous)
replace TFR_Hous =0 if TFR_Hous==1
replace TFR_Hous =0.9932 if TFR_Hous==2
replace TFR_Hous =1 if TFR_Hous==3

recode floor_area (1 2 3 =4) (4=3) (5=2) (6 7 8 =1),gen (TFR_floorAre)
replace TFR_floorAre =0 if TFR_floorAre==1
replace TFR_floorAre =0.5364 if TFR_floorAre==2
replace TFR_floorAre =0.722 if TFR_floorAre==3
replace TFR_floorAre =1 if TFR_floorAre==4

*******************************
*ROBUSTNESS TEST FOR RANKING***
*******************************

tabstat	F_multid_Fzypoor_*,	statistics(mean)by(domaincode)



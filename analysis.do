* Load necessary packages
capture ssc install misstable

* Import demographics dataset and calculate household size
import delimited "demographics.csv", clear
egen household_size = count(IndividualID), by(HouseholdID)
save "demographics_processed.dta", replace

* Import assets dataset and handle missing values
import delimited "assets.csv", clear
bys AssetType: egen median_value = median(currentvalue)
replace currentvalue = median_value if missing(currentvalue)

* Create total monetary value for each observation
gen total_value = quantity * currentvalue

* Aggregate data at household-wave level
collapse (sum) total_value, by(HouseholdID Wave AssetType)
reshape wide total_value, i(HouseholdID Wave) j(AssetType) string
gen total_asset_value = total_value_Animals + total_value_Tools + total_value_DurableGoods
save "assets_processed.dta", replace

* Import depression data and construct Kessler score
import delimited "depression.csv", clear
egen kessler_score = rowtotal(q1 q2 q3 q4 q5 q6 q7 q8 q9 q10)
gen kessler_category = .
replace kessler_category = 1 if kessler_score <= 20
replace kessler_category = 2 if kessler_score > 20 & kessler_score <= 24
replace kessler_category = 3 if kessler_score > 24 & kessler_score <= 29
replace kessler_category = 4 if kessler_score > 29

label define kessler_lbl 1 "No Depression" 2 "Mild Depression" 3 "Moderate Depression" 4 "Severe Depression"
label values kessler_category kessler_lbl

* Handle missing values by taking the average of available scores
egen kessler_score_avg = rowmean(q1 q2 q3 q4 q5 q6 q7 q8 q9 q10)
save "depression_processed.dta", replace

* Combine all datasets into one
use "demographics_processed.dta", clear
merge 1:1 HouseholdID using "assets_processed.dta"
merge 1:1 HouseholdID IndividualID using "depression_processed.dta"
save "combined_data.dta", replace

* Exploratory analysis: Relationship between depression and household wealth
regress kessler_score total_asset_value if Wave == 1
predict residuals, resid
twoway scatter kessler_score total_asset_value || lfit kessler_score total_asset_value

* Relationship between depression and household size
regress kessler_score household_size if Wave == 1
predict residuals, resid
twoway scatter kessler_score household_size || lfit kessler_score household_size

* Evaluating the RCT: Effectiveness of GT sessions in reducing depression
regress kessler_score treatment if Wave == 2

* Effect of GT sessions by gender
regress kessler_score i.female##i.treatment if Wave == 2
margins female#treatment
marginsplot, xdimension(treatment) bydimension(female)

* Save final results
save "final_results.dta", replace


# Data Analysis with Stata

## Overview

This repository contains a Stata do-file that performs data preparation, analysis, and evaluation of randomized controlled trial (RCT) data. The tasks include importing data, handling missing values, constructing new variables, and conducting regression analysis.

## Contents

- `analysis.do`: Stata do-file containing the full code for data preparation and analysis.

## Instructions

1. **Setup**:
   - Ensure you have Stata installed on your machine.
   - Place the `analysis.do` file and the required CSV files (`demographics.csv`, `assets.csv`, `depression.csv`) in the same directory.

2. **Running the Do-File**:
   - Open Stata.
   - Set the working directory to the location of your data files using the `cd` command, for example:
     ```stata
     cd "C:\path\to\your\directory"
     ```
   - Run the do-file:
     ```stata
     do analysis.do
     ```

3. **Output**:
   - The do-file will generate several processed datasets and results, including:
     - `demographics_processed.dta`: Processed demographics data.
     - `assets_processed.dta`: Processed assets data.
     - `depression_processed.dta`: Processed depression data.
     - `combined_data.dta`: Combined dataset for further analysis.
     - `final_results.dta`: Final dataset with results from the analysis.

## Tasks Completed in the Do-File

### Data Preparation

1. **Import Demographics Data**: Calculate household size.
2. **Import Assets Data**: Handle missing values and create total monetary value for each observation.
3. **Aggregate Data**: Summarize assets data at the household-wave level and calculate total asset value.
4. **Import Depression Data**: Construct Kessler score and categorize depression levels.
5. **Combine Datasets**: Merge all datasets into one for further analysis.

### Exploratory Analysis

1. **Relationship Between Depression and Household Wealth**:
   - Regress Kessler score on total asset value.
   - Plot scatter plot with fitted line.

2. **Relationship Between Depression and Household Size**:
   - Regress Kessler score on household size.
   - Plot scatter plot with fitted line.

### Evaluating the RCT

1. **Effectiveness of GT Sessions in Reducing Depression**:
   - Regress Kessler score on treatment indicator.

2. **Effect of GT Sessions by Gender**:
   - Regress Kessler score on gender, treatment, and their interaction.
   - Plot marginal effects.

## License

This project is licensed under a custom license. See the [LICENSE](LICENSE) file for details.
---

© 2024 Meman Diaby. All rights reserved.

## Acknowledgments

- The data used in this analysis is a modified version of the Ghana Panel Survey data for educational purposes.

Feel free to explore and modify the do-file to suit your needs. If you have any questions or suggestions, please open an issue or submit a pull request.

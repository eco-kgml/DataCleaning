# **LakeBeD-US: Computer Science Edition**

LakeBeD-US Computer Science Edition is an extension of the LakeBeD-US (a.k.a. 
LakeBeD-US: Ecology Edition) dataset, originally created by Bennett McAfee at 
the University of Wisconsin-Madison, that is targeted to members of the machine 
learning community for use in lake ecology prediction tasks.

## **Difference Between LakeBeD-US Editions**

The original LakeBeD-US dataset is structured in a "long" format. In this 
format, columns representing different variables are stored in one column as 
multiple rows. This format makes the addition of new variables an easy process.

![Depiction of a long format dataset](https://www.statology.org/wp-content/uploads/2021/12/wideLong3-1.png)

However, machine learning tasks typically leverage a "wide" format.

LakeBeD-US: Computer Science Edition presents the original LakeBeD-US data in a 
tabular format where each column corresponds to a different variable and each 
row to a distinct observation.

![Depiction of a wide format dataset](https://www.statology.org/wp-content/uploads/2021/12/wideLong4.png)

## **LakeBeD-US: Computer Science Edition** Workflow

### Process

The data preprocessing script takes the following steps to transform the 
LakeBeD-US: Ecology Edition into the Computer Science Edition.

1. **Data Imputation**

	The original LakeBeD-US dataset contains missing values, specifically in 
	the `depth` and `flag` column. These occur in one-dimensional variables' 
	observations (because there is no notion of depth for these variables) and 
	observations that are not erroneous. This step imputes missing values for 
	`flag` by assuming observations that are reported without a value for 
	`flag` should have a value of '0'. It does not impute values for `depth` 
	because we wish to leave the decision of whether to impute values for 
	`depth` to the end user or to omit `depth` entirely from one-dimensional 
	variables.
2. **Data Formatting**
	
	This step converts the columns in the long format of the data to the 
	appropriate types. The typecasts are given as follows:

	| Column        | Typecast          |
	| ------------- | ----------------- |
	| `source`      | `str`             |
	| `datetime`    | `pandas.datetime` |
	| `lake_id`     | `str`             |
	| `depth`       | `float`           | 
	| `variable`    | `str`             | 
	| `unit`        | `str`             | 
	| `observation` | `float`           | 
	| `flag`        | `int`             |

3. **Data Cleaning**

	1. **Erroneous Observation Removal**

		Some observations are reported with depth values of "-99". We omit 
		these values. 
		
		*Note: Depth is measured positively from the surface of 
		the water downwards. Negative depth implies an observation above 
		surface level. Observations with negative depth values are not 
		necessarily erroneous. The surface level of the water changes over 
		time, leading to situations where the sensor may be above the water 
		level.*

	2. **Variable Renaming**

		Chlorophyll a (`chla`) is reported in two units: micrograms per liter 
		and relative fluoresence units. Since we omit the `unit` column from 
		the final dataset, we create two variables: `chla_ugl` and `chla_rfu` 
		depending on the unit a particular `chla` observation was measured in.

4. **Data Structuring**

	1. **Lake Splitting**

		A dataframe read from a single file in the distribution of the data, 
		could contain data from multiple lakes. We split this dataframe into 
		multiple dataframes each with their own lake.

	2. **Deduplication**

		For a given datetime, depth, if applicable, and flag, there could be 
		multiple observations for a variable. We aggregate these into a single 
		observation using a median aggregation function.

	3. **Separating Variables**

		We separate the data into two dataframes which contain one-dimensional 
		and two-dimensional variables, respectively.

	4. **Pivoting**

		We perform a pivot of the two dataframes after separation into a wide 
		format. We pivot on `datetime` and `flag` for one-dimensional variables 
		and `datetime`, `depth`, and `flag` for two-dimensional variables.
	
### **Usage**

To run the preprocessing scripts, simply unzip the original LakeBeD-US zip file 
into a directory and use the following command

```bash
$ python3 preprocess.py [LAKEBED-US DIRECTORY]/
```

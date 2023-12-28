# Modeling the Pandemic

## Overview



## Directories

| Directory | Description                                      |
| :-------- | :----------------------------------------------- |
| .config   | Configuration files                              |
| build     | Main working directory for analysis and modeling |
| data      | Raw data files and data processing scripts       |
| dep       | Dependence files for all projects                |
| doc       | Data dictionaries and reference tables           |
| res       | Static files (i.e., figures)                     |
| test      | Ongoing testing projects                         |

## Usage

1. Install GitHub Desktop from https://docs.github.com/en/desktop/installing-and-authenticating-to-github-desktop/installing-github-desktop
2. Clone this project to the user's desktop from https://github.com/cliandouble08/modeling-the-pandemic.git 
   * The cloned project can be updated by pulling updates from GitHub repository using GitHub Desktop. 
3. Open the cloned project from the cloning directory. 
4. Open "./modeling-the-pandemic.Rproj" before running files in the directory to avoid errors in readr functions. 
   * R package installation/loading script is embedded in "./build" files, please run the line `source("./dep/file-directory")` specific to each file to avoid unnecessary package installation and loading. 
   * R packages that are consistently loaded for all files are: `readr`, `tidyr`, `dplyr`, `ggplot2`
5. Open and run "./build/main.R" to load necessary data files and R packages.  
   * Alternative: load "./.RData" to access all history objects and packages. 

### Notes for specific files

* "./build/main.R" is the primary R file for data analysis post-data-cleaning. Please *only* visit this file if you do not intend to view anything other than the actual analysis. 
* "./dep/package-prep.R" is a generic R template for package installation/loading. You may use it by: 
  1. Download the R script to your directory. 
  2. Edit the package list `required_packages` to include your desired packages. 
  3. Load the packages by running/embedding `source(package-prep-script-directory)` in your code. 
  4. The script will automatically load the latest version for all listed R packages by default. If a package has not been installed, the script will detect and install the missing package automatically. 

## Roadmap

### 1. Data Collection

The project used the following data files from corresponding sources: 

| Data type   | Data                              | Source                                                       | Link                                                         |
| ----------- | --------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| COVID-19    | Cases and Deaths                  | New York Times                                               | https://github.com/nytimes/covid-19-data.git                 |
| COVID-19    | Hospital capacity                 |                                                              |                                                              |
| Policy      | Policy mapping                    | Katz, R., Toole, K., Robertson, H. *et al.* Open data for COVID-19 policy analysis and mapping. *Sci Data* **10**, 491 (2023). | https://doi.org/10.1038/s41597-023-02398-3                   |
| Demographic | Demographic and housing estimates | American Community Survey (ACS), U.S. Census Bureau          | https://data.census.gov/                                     |
| Demographic | Education attainments             | American Community Survey (ACS), U.S. Census Bureau          | https://data.census.gov/                                     |
| Demographic | Housing Price Index (HPI)         | Federal Housing Finance Agency                               | https://www.fhfa.gov/DataTools/Downloads/Pages/House-Price-Index-Datasets.aspx |
|             |                                   |                                                              |                                                              |

### 2. Data Processing



### 3. Preliminary Analysis



### 4. Modeling/Analysis



## Additional Toolkits

### Configure Git Large File Storage (LFS)

Large data files were uploaded through LFS. 

Visit https://docs.github.com/en/repositories/working-with-files/managing-large-files for further instructions. 

## Contact

Cameron Lian - liancame@grinnell.edu

Instructor: Prof. Shonda Kuiper - kuipers@grinnell.edu

Project Link: https://github.com/cliandouble08/modeling-the-pandemic.git

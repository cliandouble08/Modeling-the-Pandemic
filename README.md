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
5. Open and run "./build/main.R" to load necessary data files and R packages.  
   * Alternative: load "./.RData" to access all history objects and packages. 

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

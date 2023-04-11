# PortfolioProjects

COVID-19 Data Analysis Project

This project analyzes COVID-19 data using SQL queries.

The data is sourced from the Our World in Data website and contains information on COVID-19 cases, deaths, hospitalizations, and vaccinations from countries around the world.

Data
The data used in this project is stored in a CSV file named "owid-covid-data.csv". The CSV file is located in the "data" folder of this repository. The CSV file contains the following columns:

location: The name of the country or region
continent: The continent that the country or region belongs to
date: The date of the observation
total_cases: The total number of confirmed COVID-19 cases
new_cases: The number of new confirmed COVID-19 cases
total_deaths: The total number of confirmed COVID-19 deaths
new_deaths: The number of new confirmed COVID-19 deaths
total_vaccinations: The total number of COVID-19 vaccine doses administered
people_vaccinated: The number of people who have received at least one COVID-19 vaccine dose
people_fully_vaccinated: The number of people who have received all required COVID-19 vaccine doses
hospitalizations: The total number of COVID-19 hospitalizations
icu_patients: The total number of COVID-19 patients in intensive care units
median_age: The median age of the population
aged_65_older: The percentage of the population aged 65 or older
aged_70_older: The percentage of the population aged 70 or older
cardiovasc_death_rate: The cardiovascular death rate per 100,000 people
diabetes_prevalence: The percentage of the population with diabetes
female_smokers: The percentage of female smokers in the population
male_smokers: The percentage of male smokers in the population
handwashing_facilities: The percentage of the population with access to basic handwashing facilities
hospital_beds_per_thousand: The number of hospital beds per 1,000 people
life_expectancy: The life expectancy at birth in years
human_development_index: The Human Development Index (HDI), which is a composite index that measures the average achievements in a country in three basic dimensions of human development: a long and healthy life, access to knowledge, and a decent standard of living
excess_mortality_cumulative_absolute: The cumulative excess mortality during the pandemic, which is the difference between the observed number of deaths and the expected number of deaths based on historical trends
excess_mortality_cumulative: The excess mortality during the pandemic as a percentage of the expected mortality based on historical trends
excess_mortality: The excess mortality in the latest available week as a percentage of the expected mortality based on historical trends
excess_mortality_cumulative_per_million: The excess mortality during the pandemic as a percentage of the expected mortality based on historical trends, per million population
SQL Queries
This project includes a series of SQL queries that analyze the COVID-19 data in various ways. The queries are stored in a file named "covid_data_analysis.sql" and can be run on a SQL database that contains the COVID-19 data.

The queries include:

Total number of cases, deaths, and vaccinations by country
Countries with the highest number of cases and deaths
Vaccination rates by country
Hospitalizations and ICU admissions by country
Age distribution of cases and deaths by country
Case fatality rate by country
COVID-19 data analysis for African countries
Cardiovascular death rate, diabetes prevalence, smoking rates, handwashing facilities, and hospital beds per thousand by African countries
Excess mortality rate and cumulative excess mortality rate by African countries
The queries are written in T-SQL and executed on Microsoft SQL Server Management Studio (SSMS) using the open-source data set from Our World in Data, which provides daily updates on COVID-19 data across the world.

To use this project, follow these steps:

Download the SQL script file from the repository.
Open Microsoft SQL Server Management Studio and connect to a database server.
Open a new query window and execute the script.
The output for each query will be displayed in the results grid.

Make sure to download and use the latest version of the Our World in Data COVID-19 dataset for accurate results.

If you have any questions or feedback on this project, please don't hesitate to contact me.

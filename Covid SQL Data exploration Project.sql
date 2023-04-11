
Select *
From PortfolioProjects..['owid-covid-data$']
order by 3,4 

-- Data we are going to be using
Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProjects..['owid-covid-data$']
order by 1,2

--Total Cases vs Total deaths
-- Shows the likelihood of dying if you contract covid in this country
SELECT *
FROM PortfolioProjects..['owid-covid-data$']
WHERE TRY_CAST(total_cases AS float) IS NULL OR TRY_CAST(total_deaths AS float) IS NULL

-- Total cases vs population
-- Shows the population that got covid
SELECT *
FROM PortfolioProjects..['owid-covid-data$']
WHERE (TRY_CAST(total_cases AS float) IS NULL OR TRY_CAST(total_deaths AS float) IS NULL)
   OR (TRY_CAST(population AS float) IS NULL)

-- Max of the percentage population infected 
SELECT
    Location, 
    MAX((TRY_CAST(total_cases AS numeric(18,2)) * 100000.0) / NULLIF(TRY_CAST(population AS numeric(18,2)), 0)) AS max_percentage_infected
FROM 
    PortfolioProjects..['owid-covid-data$']
WHERE 
    location LIKE '%states%'
GROUP BY 
    Location;

-- Total covid infected
SELECT location, MAX(CAST(total_cases AS float)) AS max_total_cases, population,
       MAX(CAST(total_cases AS float)) / CAST(population AS float) * 100 AS max_percentage_infected
FROM PortfolioProjects..['owid-covid-data$']
WHERE location LIKE '%states%' AND TRY_CAST(total_cases AS float) IS NOT NULL AND TRY_CAST(population AS float) IS NOT NULL
GROUP BY location, population
ORDER BY max_percentage_infected DESC;

-- Total covid deaths 
SELECT 
    Location,
    MAX(TRY_CAST(total_deaths AS float)) AS max_total_deaths,
    TRY_CAST(population AS float) AS population_numeric,
    (MAX(TRY_CAST(total_deaths AS float)) * 100.0) / NULLIF(TRY_CAST(population AS float), 0) as max_death_percentage
FROM PortfolioProjects..['owid-covid-data$']
WHERE location LIKE '%states%' AND TRY_CAST(total_deaths AS float) IS NOT NULL AND TRY_CAST(population AS float) IS NOT NULL
GROUP BY Location, TRY_CAST(population AS float)
ORDER BY max_death_percentage DESC;

-- By continent

SELECT 
    Continent,
    MAX((TRY_CAST(total_cases AS float) / TRY_CAST(population AS float)) * 100) AS Max_percentage_population_infected,
    MAX((TRY_CAST(total_deaths AS float) / TRY_CAST(total_cases AS float)) * 100) AS Max_death_percentage
FROM PortfolioProjects..['owid-covid-data$']
WHERE Continent IS NOT NULL AND location NOT LIKE '%World%' AND location NOT LIKE '%International%'
GROUP BY Continent
ORDER BY Continent;

-- By location
SELECT 
    Location,
    MAX((TRY_CAST(total_cases AS float) / TRY_CAST(population AS float)) * 100) AS Max_percentage_population_infected,
    MAX((TRY_CAST(total_deaths AS float) / TRY_CAST(total_cases AS float)) * 100) AS Max_death_percentage
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL AND location NOT LIKE '%World%' AND location NOT LIKE '%International%'
GROUP BY Location
ORDER BY Location;

--Global Numbers
SELECT 
    'Global' AS Location,
    MAX((TRY_CAST(total_cases AS float) / TRY_CAST(population AS float)) * 100) AS Max_percentage_population_infected,
    MAX((TRY_CAST(total_deaths AS float) / TRY_CAST(total_cases AS float)) * 100) AS Max_death_percentage
FROM PortfolioProjects..['owid-covid-data$']

--Total covid deaths in Africa
SELECT 
    Location,
    MAX(TRY_CAST(total_deaths AS float)) AS max_total_deaths,
    TRY_CAST(population AS float) AS population_numeric,
    (MAX(TRY_CAST(total_deaths AS float)) * 100.0) / NULLIF(TRY_CAST(population AS float), 0) as max_death_percentage
FROM PortfolioProjects..['owid-covid-data$']
WHERE location LIKE '%Africa%' AND TRY_CAST(total_deaths AS float) IS NOT NULL AND TRY_CAST(population AS float) IS NOT NULL
GROUP BY Location, TRY_CAST(population AS float)
ORDER BY max_death_percentage DESC;

-- Max testing rate by location 

SELECT 
    location AS Location,
    MAX(TRY_CAST(total_tests AS float) / TRY_CAST(population AS float)) AS Max_testing_rate
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL AND location NOT LIKE '%World%' AND location NOT LIKE '%International%'
GROUP BY location
ORDER BY location;

-- Max vaccination rate by location
SELECT 
    location AS Location,
    MAX(TRY_CAST(people_vaccinated AS float) / TRY_CAST(population AS float)) AS Max_vaccination_rate
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL AND location NOT LIKE '%World%' AND location NOT LIKE '%International%'
GROUP BY location
ORDER BY location;

-- Age distribution of cases and deaths by location
SELECT 
    location AS Location,
    MAX((TRY_CAST(total_cases AS float) / TRY_CAST(population AS float)) * 100) AS Max_percentage_population_infected,
    MAX((TRY_CAST(total_deaths AS float) / TRY_CAST(total_cases AS float)) * 100) AS Max_death_percentage,
    MAX((TRY_CAST(total_tests AS float) / TRY_CAST(population AS float)) * 100) AS Testing_rate,
    MAX((TRY_CAST(total_vaccinations AS float) / TRY_CAST(population AS float)) * 100) AS Vaccination_rate,
    MAX(CASE WHEN median_age IS NOT NULL THEN TRY_CAST(median_age AS float) ELSE 0 END) AS Median_age,
    MAX(CASE WHEN aged_65_older IS NOT NULL THEN TRY_CAST(aged_65_older AS float) ELSE 0 END) AS Percentage_aged_65_older,
    MAX(CASE WHEN aged_70_older IS NOT NULL THEN TRY_CAST(aged_70_older AS float) ELSE 0 END) AS Percentage_aged_70_older,
    MAX(CASE WHEN new_cases IS NOT NULL THEN TRY_CAST(new_cases AS float) ELSE 0 END) AS New_cases,
    MAX(CASE WHEN new_deaths IS NOT NULL THEN TRY_CAST(new_deaths AS float) ELSE 0 END) AS New_deaths,
    MAX(CASE WHEN total_cases_per_million IS NOT NULL THEN TRY_CAST(total_cases_per_million AS float) ELSE 0 END) AS Cases_per_million,
    MAX(CASE WHEN total_deaths_per_million IS NOT NULL THEN TRY_CAST(total_deaths_per_million AS float) ELSE 0 END) AS Deaths_per_million
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL AND location NOT LIKE '%World%' AND location NOT LIKE '%International%'
GROUP BY Location
ORDER BY Location;

-- Case fatality rate
SELECT 
    location AS Location,
    MAX((TRY_CAST(total_cases AS float) / TRY_CAST(population AS float)) * 100) AS Max_percentage_population_infected,
    MAX((TRY_CAST(total_deaths AS float) / TRY_CAST(total_cases AS float)) * 100) AS Max_death_percentage,
    MAX((TRY_CAST(total_tests AS float) / TRY_CAST(population AS float)) * 100) AS Testing_rate,
    MAX((TRY_CAST(total_vaccinations AS float) / TRY_CAST(population AS float)) * 100) AS Vaccination_rate,
    MAX(CASE WHEN median_age IS NOT NULL THEN TRY_CAST(median_age AS float) ELSE 0 END) AS Median_age,
    MAX(CASE WHEN aged_65_older IS NOT NULL THEN TRY_CAST(aged_65_older AS float) ELSE 0 END) AS Percentage_aged_65_older,
    MAX(CASE WHEN aged_70_older IS NOT NULL THEN TRY_CAST(aged_70_older AS float) ELSE 0 END) AS Percentage_aged_70_older,
    MAX(CASE WHEN new_cases IS NOT NULL THEN TRY_CAST(new_cases AS float) ELSE 0 END) AS New_cases,
    MAX(CASE WHEN new_deaths IS NOT NULL THEN TRY_CAST(new_deaths AS float) ELSE 0 END) AS New_deaths,
    MAX(CASE WHEN total_cases_per_million IS NOT NULL THEN TRY_CAST(total_cases_per_million AS float) ELSE 0 END) AS Cases_per_million,
    MAX(CASE WHEN total_deaths_per_million IS NOT NULL THEN TRY_CAST(total_deaths_per_million AS float) ELSE 0 END) AS Deaths_per_million,
    MAX((TRY_CAST(total_deaths AS float) / TRY_CAST(total_cases AS float)) * 100) AS Case_fatality_rate
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL AND location NOT LIKE '%World%' AND location NOT LIKE '%International%'
GROUP BY Location
ORDER BY Location;

-- Case fatality rate in Africa

SELECT 
    location AS Location,
    MAX((TRY_CAST(total_cases AS float) / TRY_CAST(population AS float)) * 100) AS Max_percentage_population_infected,
    MAX((TRY_CAST(total_deaths AS float) / TRY_CAST(total_cases AS float)) * 100) AS Max_death_percentage,
    MAX((TRY_CAST(total_tests AS float) / TRY_CAST(population AS float)) * 100) AS Testing_rate,
    MAX((TRY_CAST(total_vaccinations AS float) / TRY_CAST(population AS float)) * 100) AS Vaccination_rate,
    MAX(CASE WHEN median_age IS NOT NULL THEN TRY_CAST(median_age AS float) ELSE 0 END) AS Median_age,
    MAX(CASE WHEN aged_65_older IS NOT NULL THEN TRY_CAST(aged_65_older AS float) ELSE 0 END) AS Percentage_aged_65_older,
    MAX(CASE WHEN aged_70_older IS NOT NULL THEN TRY_CAST(aged_70_older AS float) ELSE 0 END) AS Percentage_aged_70_older,
    MAX(CASE WHEN new_cases IS NOT NULL THEN TRY_CAST(new_cases AS float) ELSE 0 END) AS New_cases,
    MAX(CASE WHEN new_deaths IS NOT NULL THEN TRY_CAST(new_deaths AS float) ELSE 0 END) AS New_deaths,
    MAX(CASE WHEN total_cases_per_million IS NOT NULL THEN TRY_CAST(total_cases_per_million AS float) ELSE 0 END) AS Cases_per_million,
    MAX(CASE WHEN total_deaths_per_million IS NOT NULL THEN TRY_CAST(total_deaths_per_million AS float) ELSE 0 END) AS Deaths_per_million,
    MAX((TRY_CAST(total_deaths AS float) / TRY_CAST(total_cases AS float)) * 100) AS Case_fatality_rate
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL 
    AND location NOT LIKE '%World%' 
    AND location NOT LIKE '%International%'
    AND continent = 'Africa'
GROUP BY Location
ORDER BY Location;

-- Max cardiovasc_death_rate in africa
SELECT 
    MAX(CASE WHEN cardiovasc_death_rate IS NOT NULL THEN TRY_CAST(cardiovasc_death_rate AS float) ELSE 0 END) AS Cardiovasc_death_rate
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL 
    AND location NOT LIKE '%World%' 
    AND location NOT LIKE '%International%'
    AND continent = 'Africa';

-- Max diabetes_prevalence in africa
SELECT 
    MAX(CASE WHEN diabetes_prevalence IS NOT NULL THEN TRY_CAST(diabetes_prevalence AS float) ELSE 0 END) AS Diabetes_prevalence
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL 
    AND location NOT LIKE '%World%' 
    AND location NOT LIKE '%International%'
    AND continent = 'Africa';

-- Max female_smokers and male_smokers in Africa
SELECT 
    MAX(CASE WHEN female_smokers IS NOT NULL THEN TRY_CAST(female_smokers AS float) ELSE 0 END) AS Female_smokers,
    MAX(CASE WHEN male_smokers IS NOT NULL THEN TRY_CAST(male_smokers AS float) ELSE 0 END) AS Male_smokers
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL 
    AND location NOT LIKE '%World%' 
    AND location NOT LIKE '%International%'
    AND continent = 'Africa';

---Max handwashing_facilities in Africa
SELECT 
    MAX(CASE WHEN handwashing_facilities IS NOT NULL THEN TRY_CAST(handwashing_facilities AS float) ELSE 0 END) AS Handwashing_facilities
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL 
    AND location NOT LIKE '%World%' 
    AND location NOT LIKE '%International%'
    AND continent = 'Africa';

-- Max hospital_beds_per_thousand in africa
SELECT 
    MAX(CASE WHEN hospital_beds_per_thousand IS NOT NULL THEN TRY_CAST(hospital_beds_per_thousand AS float) ELSE 0 END) AS Hospital_beds_per_thousand
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL 
    AND location NOT LIKE '%World%' 
    AND location NOT LIKE '%International%'
    AND continent = 'Africa';

--- Max life_expectancy, human_development_index, and population in africa 
SELECT 
    MAX(CASE WHEN life_expectancy IS NOT NULL THEN TRY_CAST(life_expectancy AS float) ELSE 0 END) AS Life_expectancy,
    MAX(CASE WHEN human_development_index IS NOT NULL THEN TRY_CAST(human_development_index AS float) ELSE 0 END) AS Human_development_index,
    MAX(CASE WHEN population IS NOT NULL THEN TRY_CAST(population AS float) ELSE 0 END) AS Population
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL 
    AND location NOT LIKE '%World%' 
    AND location NOT LIKE '%International%'
    AND continent = 'Africa';

-- Max excess_mortality_cumulative_absolute, excess_mortality_cumulative and excess_mortality and excess_mortality_cumulative_per_million in africa 
SELECT 
    MAX(CASE WHEN excess_mortality_cumulative_absolute IS NOT NULL THEN TRY_CAST(excess_mortality_cumulative_absolute AS float) ELSE 0 END) AS Excess_mortality_cumulative_absolute,
    MAX(CASE WHEN excess_mortality_cumulative IS NOT NULL THEN TRY_CAST(excess_mortality_cumulative AS float) ELSE 0 END) AS Excess_mortality_cumulative,
    MAX(CASE WHEN excess_mortality IS NOT NULL THEN TRY_CAST(excess_mortality AS float) ELSE 0 END) AS Excess_mortality,
    MAX(CASE WHEN excess_mortality_cumulative_per_million IS NOT NULL THEN TRY_CAST(excess_mortality_cumulative_per_million AS float) ELSE 0 END) AS Excess_mortality_cumulative_per_million
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL 
    AND location NOT LIKE '%World%' 
    AND location NOT LIKE '%International%'
    AND continent = 'Africa';

-- Continents with the highest death count per population
SELECT 
    continent AS Continent,
    SUM(TRY_CAST(total_deaths AS float)) AS Total_deaths
FROM PortfolioProjects..['owid-covid-data$']
WHERE location IS NOT NULL 
    AND location NOT LIKE '%World%' 
    AND location NOT LIKE '%International%'
GROUP BY continent
ORDER BY Total_deaths DESC;


















































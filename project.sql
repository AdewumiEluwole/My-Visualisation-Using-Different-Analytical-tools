--The healthcare dataset
SELECT * FROM `winter-campus-378719.Healthcare_console.console_data`
 LIMIT 1000;

 --Retrieving all the countries in the dataset by status (developing and developed)
SELECT * FROM `winter-campus-378719.Healthcare_console.console_data`
WHERE Status = 'Developing';

SELECT * FROM `winter-campus-378719.Healthcare_console.console_data`
WHERE Status = 'Developed';

--Checking the distinct year the dataset covers
SELECT DISTINCT Year FROM `winter-campus-378719.Healthcare_console.console_data`
ORDER BY 1 DESC;

--Checking the distinct Continent in the dataset
SELECT DISTINCT Continent FROM `winter-campus-378719.Healthcare_console.console_data`;

--Checking the distinct Country in respect to continent in the dataset
SELECT DISTINCT Country, Continent FROM `winter-campus-378719.Healthcare_console.console_data`
ORDER BY 1 ASC;

--Comparing the sum of Adult mortality and sum of Under-five deaths in the developing and developed countries using Aggregate Function
SELECT Status, SUM(Adult_Mortality) AS TOTAL_ADULT_DEATH, 
SUM(Under_five_deaths) AS TOTAL_UNDER5_DEATH
FROM `winter-campus-378719.Healthcare_console.console_data`
WHERE Status IN ('Developing', 'Developed')
GROUP BY Status
ORDER BY 2;

--Comparing the sum of Adult Mortality and Under-five Deaths across continents to see the continent with highest deaths and lowest deaths
SELECT Continent, SUM(Adult_Mortality) AS TOTAL_ADULT_DEATH, 
SUM(Under_five_deaths) AS TOTAL_UNDER5_DEATH
FROM `winter-campus-378719.Healthcare_console.console_data`
GROUP BY Continent
ORDER BY TOTAL_ADULT_DEATH DESC;

--Calculating the Average reported cases of measles and the total alcohol intake in the developing and developed countries in respect to year
SELECT DISTINCT Year, Status, ROUND(AVG(Measles_reported),2) AS AVG_MEASLES_REPORTED, 
ROUND(SUM(Alcohol__Litres_),2) AS TOTAL_ALCOHOL_IN_LITRES
FROM `winter-campus-378719.Healthcare_console.console_data`
WHERE Status IN ('Developing', 'Developed')
GROUP BY Status, Year
ORDER BY AVG_MEASLES_REPORTED DESC;

--Calculating the Average reported cases of measles and the total alcohol intake in respect to continent and year
SELECT DISTINCT Year, Continent, ROUND(AVG(Measles_reported),2) AS AVG_MEASLES_REPORTED, 
ROUND(SUM(Alcohol__Litres_),2) AS TOTAL_ALCOHOL_IN_LITRES
FROM `winter-campus-378719.Healthcare_console.console_data`
GROUP BY Year, Continent
ORDER BY 3 DESC;

--Comparing the immunization intake by developed and developing countries
SELECT Status, SUM(Hepatitis_B_Immunization) AS TOTAL_HBI, 
SUM(Polio_immunization) AS TOTAL_PI
FROM `winter-campus-378719.Healthcare_console.console_data`
WHERE Status IN ('Developing','Developed')
GROUP BY Status
ORDER BY 2;

--Comparing the immunization intake in Asia, Africa and Europe in respect to year
SELECT Continent,Year, SUM(Hepatitis_B_Immunization) AS TOTAL_HBI, 
SUM(Polio_immunization) AS TOTAL_PI
FROM `winter-campus-378719.Healthcare_console.console_data`
WHERE Continent IN ('Asia', 'Africa', 'Europe')
GROUP BY Continent, Year
ORDER BY 2 DESC;

--Comparing the Minimum and maximum Life expectancy by Country
SELECT Country, Status, MIN(Life_Expectancy) AS Minimun_LE,
MAX(Life_Expectancy) AS Maximum_LE
FROM `winter-campus-378719.Healthcare_console.console_data`
GROUP BY Country, Status, Continent
ORDER BY 4 DESC;

--Comparing the Maximum and minimum Life expectancy by Continents
SELECT Continent, MAX(Life_Expectancy) AS Maximum_LE,
MIN(Life_Expectancy) AS Minimum_LE
FROM `winter-campus-378719.Healthcare_console.console_data`
GROUP BY Continent
ORDER BY 2 DESC;

--Categorising the body mass index between 2000 and 2015 in respect to country, status and continent by using CASE WHEN function
SELECT Country, Status,Continent,
CASE
WHEN Body_mass_index < 18.5 THEN 'UNDERWEIGHT'
WHEN Body_mass_index BETWEEN 18.5 AND 24.9 THEN 'NORMAL_WEIGHT'
WHEN Body_mass_index BETWEEN 25 AND 29.9 THEN 'OVERWEIGHT'
ELSE 'OBESE'
END AS BodyMassIndex,
MAX(Body_mass_index) AS BMI
FROM `winter-campus-378719.Healthcare_console.console_data`
WHERE Status IN ('Developed', 'Developing') AND Year BETWEEN 2000 AND 2015
GROUP BY Country, Status,Continent, BodyMassIndex
ORDER BY 5 DESC;

--Categorising the body mass index in respect across continent
SELECT Continent,
CASE
WHEN Body_mass_index < 18.5 THEN 'UNDERWEIGHT'
WHEN Body_mass_index BETWEEN 18.5 AND 24.9 THEN 'NORMAL_WEIGHT'
WHEN Body_mass_index BETWEEN 25 AND 29.9 THEN 'OVERWEIGHT'
ELSE 'OBESE'
END AS BodyMassIndex,
MAX(Body_mass_index) AS BMI
FROM `winter-campus-378719.Healthcare_console.console_data`
WHERE Status IN ('Developed', 'Developing') AND Year BETWEEN 2000 AND 2015
GROUP BY Continent, BodyMassIndex
ORDER BY 3 DESC;

--Checking out the relationship that exist between Life expectancy and the factors that affect it (adult mortality, under five death, avg-expenditure on health, education,Immunization)
SELECT Status, MAX(Life_Expectancy) AS Maximum_LE,
MIN(Life_Expectancy) AS Minimum_LE,
SUM(Adult_Mortality) AS Total_Adult_Mortality,
SUM(Under_five_deaths) AS Total_Under5_Deaths,
ROUND(AVG(Expenditure_on_Health_GDP_),2) AS AVG_Health_Exp,
MAX(Education) AS Max_Year_of_Education,
ROUND(AVG(Hepatitis_B_Immunization),1) AS AVG_Hept_B_Imm
FROM `winter-campus-378719.Healthcare_console.console_data`
GROUP BY Status
ORDER BY 2 DESC;

--Checking out how each continent proved the relationship between all the factors and life expectancy.
SELECT Continent, MAX(Life_Expectancy) AS Maximum_LE,
MIN(Life_Expectancy) AS Minimum_LE,
SUM(Adult_Mortality) AS Total_Adult_Mortality,
SUM(Under_five_deaths) AS Total_Under5_Deaths,
ROUND(AVG(Expenditure_on_Health_GDP_),2) AS AVG_Health_Exp,
MAX(Education) AS Max_Year_of_Education,
SUM(Hepatitis_B_Immunization) AS Total_HBI,
SUM(Polio_immunization) AS Total_PI
FROM `winter-campus-378719.Healthcare_console.console_data`
GROUP BY Continent
ORDER BY 2 DESC;

--RELATIONSHIP BETWEEN LIFE EXPECTANCY AND POPULATION
SELECT Continent, Country, ROUND(AVG(Life_Expectancy),1) AS AVG_LE,
 ROUND(MAX(Population), 1) AS MaxPopulation,
ROUND(SUM(Measles_reported),0) AS  TotalMeaslesReported,
ROUND(AVG(Expenditure_on_Health_GDP_),2) AS AvgExpOnHealth
FROM `winter-campus-378719.Healthcare_console.console_data`
GROUP BY Continent, Country
ORDER BY 2 DESC;

--Finding top 20 Countries and year where the life expectancy is greater than the average life expectancy using Subqueries
SELECT DISTINCT Country, Continent, Year, Life_Expectancy From `winter-campus-378719.Healthcare_console.console_data`
WHERE Life_Expectancy>=(SELECT ROUND(AVG(Life_Expectancy),2) FROM `winter-campus-378719.Healthcare_console.console_data`)
ORDER BY 3 DESC
LIMIT 20;

--Calculating the total percentage of death caused by adult mortality and under five deaths
SELECT DISTINCT Year, Country, Continent, Adult_Mortality, Under_five_deaths,
ROUND((Adult_Mortality/
SUM(Adult_Mortality) OVER (PARTITION BY Continent ORDER BY Continent DESC))*100,2) AS Percentage_AdultMort,
ROUND((Under_five_deaths/
SUM(Under_five_deaths) OVER (PARTITION BY Continent ORDER BY Continent DESC))*100,2) AS Percentage_U5death,
ROUND(ROUND((Adult_Mortality/
SUM(Adult_Mortality) OVER (PARTITION BY Continent ORDER BY Continent DESC))*100,2) +
ROUND((Under_five_deaths/
SUM(Under_five_deaths) OVER (PARTITION BY Continent ORDER BY Continent DESC))*100,2),2) AS TotalPercentagedeath
FROM `winter-campus-378719.Healthcare_console.console_data`
WHERE Year BETWEEN 2007 AND 2015
ORDER BY Year DESC;


SELECT * FROM CovidProject..[covid deaths]
where continent is not null
order by location,date;


SELECT location, date, total_cases, new_cases, total_deaths, population 
from CovidProject..[covid deaths]
order by location, date;

--I have added a new column to show the death rates against new cases for Nigeria
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS Death_Rate
from CovidProject..[covid deaths] 
where location = 'nigeria'
order by location, date;

--infection rate against population for Nigeria 
SELECT location, date, total_cases, population, (total_cases/population)*100 AS Infection_Rate
from CovidProject..[covid deaths] 
where location = 'nigeria'
order by location, date;

--Highest number of new cases recorded for all countries in a single day
SELECT location, population, max(new_cases) as highest_number_of_new_cases_recorded_in_a_single_day
from CovidProject..[covid deaths] 
where continent is not null
group by location, population
order by highest_number_of_new_cases_recorded_in_a_single_day desc;

--Highest number of deaths recorded for all countries in a single day
SELECT location, max(new_deaths) as highest_number_of_new_deaths_recorded_in_a_single_day
from CovidProject..[covid deaths] 
where continent is not null 
group by location, population
order by highest_number_of_new_deaths_recorded_in_a_single_day desc;

-- At this point, i'll join the covid deaths and covid vaccination tables
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations 
from CovidProject..[covid deaths] cd
join CovidProject..[covid vaccinations] cv
on cd.location = cv.location
and cd.date = cv.date
where cd.continent is not null
order by continent, location, date

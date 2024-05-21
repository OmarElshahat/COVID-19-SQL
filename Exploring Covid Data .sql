/*
Covid 19 Data Exploration 
*/

Select *
From covid19.coviddeaths


Select Location, date, total_cases, new_cases, total_deaths, population
From covid19.coviddeaths
Where continent is not null 
order by 1,2

-- Total Cases vs Total Deaths

Select Location,date , total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From covid19.coviddeaths
Where continent is not null 
order by 1,2 desc

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From covid19.CovidDeaths
Where location like '%apa%'
and continent is not null 
order by 1,2

-- Total Cases vs Population

Select Location, date, total_cases, Population,  (total_cases/population)*100 as PercentPopulationInfected
From covid19.CovidDeaths
Where location like '%apa%'
order by 1,2

-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestCasesCount,  Max((total_cases/population))*100 as Percent_Population_to_cases
From covid19.CovidDeaths
Group by Location, Population
order by Percent_Population_to_cases desc

-- Countries with Highest Death Count per Population

Select Location, Population, MAX(total_deaths ) as HighestDeathesCount,  Max((total_deaths/population))*100 as Percent_Population_to_deathes
From covid19.CovidDeaths
Where continent is not null 
Group by Location, Population
order by 3 desc 

-- GLOBAL ESTIMATE NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From covid19.CovidDeaths
where continent is not null 
order by 1,2

Select date,SUM(new_cases) as total_cases, SUM(new_deaths ) as total_deaths, SUM(new_deaths )/SUM(New_Cases)*100 as DeathPercentage
From covid19.CovidDeaths
where continent is not null 
Group By date
order by 1,2

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(v.new_vaccinations) OVER (Partition by d.Location Order by d.location, d.Date) as RunningPeopleVaccinatedtotal
From covid19.CovidDeaths d
Join covid19.CovidVaccinations v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null 
order by 2,3


Select *, (RunningPeopleVaccinatedtotal/Population)*100 as Percentage_vaccination_for_population
From(Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(v.new_vaccinations) OVER (Partition by d.Location Order by d.location, d.Date) as RunningPeopleVaccinatedtotal
From covid19.CovidDeaths d
Join covid19.CovidVaccinations v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null 
order by 2,3) AS DV










--Covid 19 Data Exploration 
--Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

--CHECKING THE DATA

SELECT* FROM COVID_DEATHS
ORDER BY 3,4

--SELECT* FROM COVID_VACCINATION
--ORDER BY 3,4

--Select data that will be used

-- Select Data that we are going to be starting with

Select Location, date_, total_cases, new_cases, total_deaths, population
From Covid_Deaths
Where continent is not null 
order by 1,2


-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date_, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Covid_Deaths
Where location like '%States%'
--and continent is not null 
order by 1,2

Select Location, date_, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Covid_Deaths
Where location like '%Nigeria%'
and continent is not null 
order by 1,2

Select Location, date_, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Covid_Deaths
Where location like '%Kingdom%'
and continent is not null 
order by 1,2

-- Total Cases vs Population
-- Shows what percentage of population infected with Covid (In United states, United Kingdom and Nigeria)

Select Location, date_, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From Covid_Deaths
Where location like '%States%'
order by 1,2

Select Location, date_, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From Covid_Deaths
Where location like '%Kingdom%'
order by 1,2

Select Location, date_, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From Covid_Deaths
Where location like '%Nigeria%'
order by 1,2


-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Covid_Deaths
Where location like '%States%'
Group by Location, Population
order by PercentPopulationInfected desc

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Covid_Deaths
Where location like '%Kingdom%'
Group by Location, Population
order by PercentPopulationInfected desc

-- Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Covid_Deaths
--Where location like '%States%'
Where continent is not null 
Group by Location
order by TotalDeathCount desc

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Covid_Deaths
--Where location like '%Kingdom%'
Where continent is not null 
Group by Location
order by TotalDeathCount desc

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Covid_Deaths
--Where location like '%states%'
Where continent is not null 
Group by continent
order by TotalDeathCount desc

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Covid_Deaths
--Where location like '%Kingdom%'
Where continent is not null 
Group by continent
order by TotalDeathCount desc


-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Covid_Deaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Covid_Deaths
--Where location like '%Kingdom%'
where continent is not null 
--Group By date
order by 1,2


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

--Select dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations
--, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date_) as RollingPeopleVaccinated
----, (RollingPeopleVaccinated/population)*100
--From Covid_Deaths dea
--Join Covid_Vaccination vac
--	On dea.location = vac.location
--	and dea.date_ = vac.date_
--where dea.continent is not null 
--order by 2,3

Select dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date_) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covid_Deaths dea
Join Covid_Vaccination vac
	On dea.location = vac.location
	and dea.date_ = vac.date_
where dea.continent is not null 
order by 2,3

-- Using CTE (Common Table Expression) to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date_, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date_) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100 
From Covid_Deaths dea
Join Covid_Vaccination vac
	On dea.location = vac.location
	and dea.date_ = vac.date_
where dea.continent is not null 
--order by 2,3
)
Select PopvsVac.* ,(RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query


Create Private Temporary Table ORA$PTT_PercentPopulationVaccinated
(
Continent varchar2(255),
Location varchar2(255),
Date_ timestamp,
Population number,
New_vaccinations number,
RollingPeopleVaccinated number
)
ON COMMIT PRESERVE DEFINITION;

Insert into ORA$PTT_PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date_) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covid_Deaths dea
Join Covid_Vaccination vac
	On dea.location = vac.location
	and dea.date_ = vac.date_
--where dea.continent is not null 
--order by 2,3

Select ORA$PTT_PercentPopulationVaccinated.*, (RollingPeopleVaccinated/Population)*100
From ORA$PTT_PercentPopulationVaccinated




-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date_, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (Partition by dea.Location Order by dea.location, dea.Date_) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Covid_Deaths dea
Join Covid_Vaccination vac
	On dea.location = vac.location
    where dea.continent is not null
    and dea.date_ = vac.date_
    
    Select * From PercentPopulationVaccinated
SELECT * FROM PortfolioProject..CovidDeaths
order by 3,4

-SELECT * FROM PortfolioProject..CovidVaccinations
-ORDER BY 3,4


SELECT Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Order by 1,2

---

SELECT Location, date, total_cases,total_deaths
FROM PortfolioProject..CovidDeaths
WHERE location like 'Bulgaria'
Order by 1,2

---

SELECT Location, population, MAX(total_cases) as HighestInfectionCount
FROM PortfolioProject..CovidDeaths
--WHERE location like 'Bulgaria'
Group by Location, population
Order by 1,2

---


SELECT Location, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
Group by location
Order by TotalDeathCount DESC

---


SELECT continent, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
Group by continent
Order by TotalDeathCount DESC


---


SELECT date, SUM(new_cases), SUM(cast(new_deaths as int))
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
Group by date
Order by 1,2

---

SELECT dea.continent, dea.location, dea.population, vac.new_vaccinations
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
    ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3

---

SELECT dea.continent, dea.location, dea.population, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location)
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
    ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3


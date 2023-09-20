# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
select * from city 
where name like "ping%"
order by population; 
#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
select * from city
where name like "ran%"
order by population desc;
#
#
# 3: Count all cities
select count(*) from city;
#
#
# 4: Get the average population of all cities
select avg(Population) from city; 
#
#
# 5: Get the biggest population found in any of the cities
select max(Population) from city; 
#
# 6: Get the smallest population found in any of the cities
select  min(Population) from city; 
#
# 7: Sum the population of all cities with a population below 10000
select sum(population) from city
where population < 10000;
#
# 8: Count the cities with the countrycodes MOZ and VNM
select count(*) from city
where countrycode in ("MOZ", "VNM");
#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
select countrycode, count(*) from city
where countrycode in ("MOZ", "VNM")
group by countrycode;

#
#
# 10: Get average population of cities in MOZ and VNM
select countrycode, avg(population) from city
where countrycode in ("MOZ", "VNM")
group by countrycode;
#
#
# 11: Get the countrycodes with more than 200 cities
select countrycode, count(*) from city
group by countrycode
having count(*) > 200;

#
#
# 12: Get the countrycodes with more than 200 cities ordered by city count
select countrycode, count(*) from city
group by countrycode
having count(*) > 200
order by count(*);

#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
select distinct countrylanguage.Language, city.name  from city
join countrylanguage on city.CountryCode = countrylanguage.CountryCode
where city.population between 400 and 500;

#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them

select distinct countrylanguage.Language, city.name  from city
join countrylanguage on city.CountryCode = countrylanguage.CountryCode
where city.population between 500 and 600;
#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
select name from city
where CountryCode = (select CountryCode from city where Population = 122199);

SELECT City.Name AS CityName, City.CountryCode, city.Population AS CountryCode
FROM City
JOIN City AS selected_city ON City.CountryCode = selected_city.CountryCode
WHERE selected_city.Population = 122199;
#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
SELECT City.Name AS CityName, City.CountryCode, city.Population AS CountryCode
FROM City
JOIN City AS selected_city ON City.CountryCode = selected_city.CountryCode
WHERE selected_city.Population = 122199
and city.Population != 122199;
#
# 17: What are the city names in the country where Luanda is capital?
select city.name, country.Name, city.id, country.Capital
from city
join country on country.Code = city.CountryCode
where country.Code = (select CountryCode from city where city.Name = 'Luanda' and city.id = country.Capital);

#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
select country.name as 'Country', city.name as 'City', city.id, country.region, country.Capital
from city 
join country on city.CountryCode = country.Code
where Country.Region = (select Region from country 
						join city on city.CountryCode = country.Code 
                        where city.name = "Yaren")
                        and city.id = country.Capital;

# 19: What unique languages are spoken in the countries in the same region as the city named Riga
select countrylanguage.Language, countrylanguage.IsOfficial, country.Name as Country, countrylanguage.Percentage
from country 
join countrylanguage on countrylanguage.CountryCode = country.Code
where Country.Region = (select Region from country 
						join city on city.CountryCode = country.Code 
                        where city.name = "Riga")
                        and countrylanguage.IsOfficial = 'F';

# 20: Get the name of the most populous city
select * 
from city
order by Population desc
limit 1;

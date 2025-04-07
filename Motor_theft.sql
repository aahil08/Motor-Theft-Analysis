use stolen_vehicles_db;

-- OBJECTIVE 1
-- Identify when vehicles are likely to be stolen

-- Find the number of vehicles stolen each year
SELECT YEAR(date_stolen) AS Year_Stolen,
    COUNT(*) AS Total_Stolen
FROM stolen_vehicles
GROUP BY YEAR(date_stolen)
ORDER BY YEAR(date_stolen);

-- Find the number of vehicles stolen each month
SELECT Month(date_stolen) as Month_stolen,
	count(*) as Total_stolen
from stolen_vehicles
group by Month(date_stolen)
order by Month(date_stolen);

-- Find the number of vehicles stolen each day of the week
SELECT dayofweek(date_stolen) as Day_stolen,
	count(*) as Total_stolen
from stolen_vehicles
group by dayofweek(date_stolen)
order by dayofweek(date_stolen);

SELECT 
    CASE DAYOFWEEK(date_stolen)
        WHEN 1 THEN 'Sunday'
        WHEN 2 THEN 'Monday'
        WHEN 3 THEN 'Tuesday'
        WHEN 4 THEN 'Wednesday'
        WHEN 5 THEN 'Thursday'
        WHEN 6 THEN 'Friday'
        ELSE 'Saturday'
    END AS DayName,
    COUNT(*) AS Total_Stolen
FROM stolen_vehicles
GROUP BY DAYOFWEEK(date_stolen), Dayname
ORDER BY DAYOFWEEK(date_stolen), Dayname;

-- Objective 2: Identify Which Vehicles Are Likely to Be Stolen

-- Find the vehicle types that are most often and least often stolen

(SELECT 'Most Often', vehicle_type,
    COUNT(*) AS total_stolen
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY total_stolen DESC
LIMIT 5)
UNION
(SELECT 'Least Often',
    vehicle_type,
    COUNT(*) AS total_stolen
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY total_stolen ASC
LIMIT 5); 

-- For each vehicle type, find the average age of the cars that are stolen
SELECT 
    vehicle_type,
    ROUND(AVG(YEAR(date_stolen) - model_year), 2) AS avg_vehicle_age
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY avg_vehicle_age DESC;

-- For each vehicle type, find the percent of vehicles stolen that are luxury versus standard
WITH lux_standard as (SELECT vehicle_type, CASE WHEN make_type = 'Luxury' THEN 1 ELSE 0 END AS luxury
FROM stolen_vehicles sv LEFT JOIN make_details md
	ON sv.make_id = md.make_id)

SELECT vehicle_type, ROUND(sum(luxury)/ COUNT(*) * 100, 2) as pct_lux
FROM lux_standard
GROUP BY vehicle_type
ORDER BY pct_lux DESC;

-- Create a table where the rows represent the top 10 vehicle types, the columns represent the top 7 vehicle colors
-- (plus 1 column for all other colors)
-- and the values are the number of vehicles stolen

SELECT color, COUNT(*) AS num_vehicles
FROM stolen_vehicles
GROUP BY color
ORDER BY num_vehicles DESC
LIMIT 7;

SELECT vehicle_type, COUNT(*) AS num_vehicles,
    SUM(CASE WHEN color = 'Silver' THEN 1 ELSE 0 END) AS Silver,
    SUM(CASE WHEN color = 'White'  THEN 1 ELSE 0 END) AS White,
    SUM(CASE WHEN color = 'Black'  THEN 1 ELSE 0 END) AS Black,
    SUM(CASE WHEN color = 'Blue'   THEN 1 ELSE 0 END) AS Blue,
    SUM(CASE WHEN color = 'Red'    THEN 1 ELSE 0 END) AS Red,
    SUM(CASE WHEN color = 'Grey'   THEN 1 ELSE 0 END) AS Grey,
    SUM(CASE WHEN color = 'Green'  THEN 1 ELSE 0 END) AS Green,
    -- 'Other' captures everything not in the top 7
    SUM(CASE WHEN color NOT IN ('Black','White','Silver','Red','Blue','Grey','Green') THEN 1 ELSE 0 END) AS Other_Colors
FROM stolen_vehicles 
GROUP BY vehicle_type
ORDER BY num_vehicles DESC
LIMIT 10; 


-- Objective 3:  Identify Where Vehicles Are Likely to Be Stolen

-- Find the number of vehicles that were stolen in each region
SELECT l.region, 
    COUNT(*) AS num_vehicles
FROM stolen_vehicles sv LEFT JOIN locations l
	ON sv.location_id = l.location_id
GROUP BY l.region
ORDER BY num_vehicles DESC;

-- Combine the previous output with the population and density statistics for each region

# Step 1 and 2: Count stolen vehicles by region and combine with population and density
SELECT 
    l.region,
    COUNT(sv.vehicle_id) AS vehicles_stolen,
    l.population,
    l.density
FROM stolen_vehicles sv LEFT JOIN locations l 
	ON sv.location_id = l.location_id
GROUP BY l.region, l.population, l.density
ORDER BY vehicles_stolen DESC;

-- Do the types of vehicles stolen in the three most dense regions differ from the three least dense regions?
SELECT 
    l.region,
    COUNT(sv.vehicle_id) AS vehicles_stolen,
    l.population,
    l.density
FROM stolen_vehicles sv LEFT JOIN locations l 
	ON sv.location_id = l.location_id
GROUP BY l.region, l.population, l.density
ORDER BY l.density DESC;

-- Types of vehicles stolen in most dense region
(SELECT 'High Density', 
    sv.vehicle_type,
    COUNT(sv.vehicle_id) AS vehicles_stolen
FROM stolen_vehicles sv LEFT JOIN locations l 
	ON sv.location_id = l.location_id
WHERE l.region IN ('Auckland', 'Nelson', "Wellington")
GROUP BY sv.vehicle_type
ORDER BY vehicles_stolen DESC
LIMIT 3)
UNION
-- Types of vehicles stolen in least dense region 
(SELECT 'Low Density',
    sv.vehicle_type,
    COUNT(sv.vehicle_id) AS vehicles_stolen
FROM stolen_vehicles sv LEFT JOIN locations l 
	ON sv.location_id = l.location_id
WHERE l.region IN ('Otago','Gisborne','Southland')
GROUP BY sv.vehicle_type
ORDER BY vehicles_stolen DESC
LIMIT 3);

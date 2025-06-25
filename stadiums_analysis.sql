---31.	Which stadium has the highest capacity?
SELECT name, capacity
FROM stadiums
ORDER BY capacity DESC
LIMIT 1;

---32.	How many stadiums are located in a ‘Russia’ country or ‘London’ city?
SELECT *
FROM stadiums
WHERE LOWER(country) = 'russia' OR LOWER(city) = 'london';

---33.	Which stadium hosted the most matches during a season?
SELECT season, stadium, COUNT(*) AS match_count
FROM matches
GROUP BY season, stadium
ORDER BY match_count DESC;

---34.	What is the average stadium capacity for teams participating in a each season?
SELECT m.season, ROUND(AVG(s.capacity), 2) AS avg_capacity
FROM matches m
JOIN stadiums s ON m.stadium = s.name
GROUP BY m.season;

---35.	How many teams play in stadiums with a capacity of more than 50,000?
SELECT DISTINCT t.team_name
FROM teams t
JOIN stadiums s ON t.home_stadium = s.name
WHERE s.capacity > 50000;

---36.	Which stadium had the highest attendance on average during a season?
SELECT season, stadium, ROUND(AVG(attendance), 2) AS avg_attendance
FROM matches
GROUP BY season, stadium
ORDER BY avg_attendance DESC;

---37.	What is the distribution of stadium capacities by country?
SELECT country, COUNT(*) AS stadiums,
ROUND(AVG(capacity), 2) AS avg_capacity
FROM stadiums
GROUP BY country
ORDER BY avg_capacity DESC;




















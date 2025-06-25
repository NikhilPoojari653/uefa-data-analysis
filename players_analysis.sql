SELECT * FROM players LIMIT 1;

---18.	Which players have the highest total goals scored (including assists)?
SELECT p.name AS player_name,
COUNT(DISTINCT g.goal_id) + COUNT(DISTINCT g2.goal_id) AS total_contribution
FROM players p
LEFT JOIN goals g ON p.pid = g.pid
LEFT JOIN goals g2 ON p.pid = g2.assist
GROUP BY player_name
ORDER BY total_contribution DESC
LIMIT 10;


---19.	What is the average height and weight of players per position?
SELECT position,
ROUND(AVG(height_cm), 2) AS avg_height,
ROUND(AVG(weight_kg), 2) AS avg_weight
FROM players
GROUP BY position;

---20.	Which player has the most goals scored with their left foot?
SELECT pid, COUNT(*) AS left_foot_goals
FROM goals
WHERE LOWER(goal_desc) LIKE '%left%'
GROUP BY pid
ORDER BY left_foot_goals DESC
LIMIT 1;

---21.	What is the average age of players per team?
SELECT team, ROUND(AVG(EXTRACT(YEAR FROM AGE(current_date, dob))), 2) AS avg_age
FROM players
GROUP BY team
ORDER BY avg_age DESC;

---22.	How many players are listed as playing for a each team in a season?
SELECT team, COUNT(*) AS player_count
FROM players
GROUP BY team
ORDER BY player_count DESC;

---23.	Which player has played in the most matches in the each season?
SELECT m.season, g.pid, 
COUNT(DISTINCT g.match_id) AS match_count
FROM goals g
JOIN matches m ON g.match_id = m.match_id
GROUP BY m.season, g.pid
ORDER BY m.season, match_count DESC;

---24.	What is the most common position for players across all teams?
SELECT position, COUNT(*) AS count
FROM players
GROUP BY position
ORDER BY count DESC
LIMIT 1;

---25.	Which players have never scored a goal?
SELECT * FROM players LIMIT 1;
SELECT pid, name
FROM players
WHERE pid NOT IN (SELECT DISTINCT pid FROM goals);


































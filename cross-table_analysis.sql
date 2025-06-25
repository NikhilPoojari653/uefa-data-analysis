---38.	Which players scored the most goals in matches held at a specific stadium?
SELECT p.name AS player_name,
COUNT(*) AS goals
FROM goals g
JOIN players p ON g.pid = p.pid
JOIN matches m ON g.match_id = m.match_id
WHERE m.stadium = 'Allianz Arena'
GROUP BY player_name
ORDER BY goals DESC;

---39.	Which team won the most home matches in the season 2021-2022 (based on match scores)?
SELECT home_team, COUNT(*) AS wins
FROM matches
WHERE season = '2021-2022'
AND home_team_score > away_team_score
GROUP BY home_team
ORDER BY wins DESC;

---40.	Which players played for a team that scored the most goals in the 2021-2022 season?
WITH top_team AS (
SELECT p.team
FROM players p
JOIN goals g ON p.pid = g.pid
JOIN matches m ON g.match_id = m.match_id
WHERE m.season = '2021-2022'
GROUP BY p.team
ORDER BY COUNT(*) DESC
LIMIT 1
)
SELECT DISTINCT p.name AS player_name
FROM players p
JOIN top_team tt ON p.team = tt.team;

---41.	How many goals were scored by home teams in matches where the attendance was above 50,000?
SELECT SUM(home_team_score) AS total_goals
FROM matches
WHERE attendance > 50000;

---42.	Which players played in matches where the score difference (home team score - away team score) was the highest?
WITH max_diff_match AS (
SELECT match_id, ABS(home_team_score - away_team_score) AS diff
FROM matches
ORDER BY diff DESC
LIMIT 1
)
SELECT DISTINCT p.name AS player_name
FROM goals g
JOIN players p ON g.pid = p.pid
JOIN max_diff_match md ON g.match_id = md.match_id;

---43.	How many goals did players score in matches that ended in penalty shootouts?
SELECT DISTINCT penalty_shoot_out FROM matches;
SELECT COUNT(*) AS total_goals
FROM goals g
JOIN matches m ON g.match_id = m.match_id
WHERE m.penalty_shoot_out = '1';

---44.	What is the distribution of home team wins vs away team wins by country for all seasons?
SELECT s.country,
SUM(CASE WHEN m.home_team_score > m.away_team_score THEN 1 ELSE 0 END) AS home_wins,
SUM(CASE WHEN m.away_team_score > m.home_team_score THEN 1 ELSE 0 END) AS away_wins
FROM matches m
JOIN stadiums s ON m.stadium = s.name
GROUP BY s.country;

---45.	Which team scored the most goals in the highest-attended matches?
WITH high_attendance_matches AS (
SELECT match_id
FROM matches
ORDER BY attendance DESC
LIMIT 10
)
SELECT p.team, COUNT(*) AS total_goals
FROM goals g
JOIN high_attendance_matches h ON g.match_id = h.match_id
JOIN players p ON g.pid = p.pid
GROUP BY p.team
ORDER BY total_goals DESC;

---46.	Which players assisted the most goals in matches where their team lost(you can include 3)?
SELECT p.name AS player_name,
COUNT(*) AS assists
FROM goals g
JOIN players p ON g.assist = p.pid
JOIN matches m ON g.match_id = m.match_id
WHERE ((p.team = m.home_team AND m.home_team_score < m.away_team_score)
 OR (p.team = m.away_team AND m.away_team_score < m.home_team_score)
)
GROUP BY player_name
ORDER BY assists DESC
LIMIT 3;

---47.	What is the total number of goals scored by players who are positioned as defenders?
SELECT COUNT(*) AS defender_goals
FROM goals g
JOIN players p ON g.pid = p.pid
WHERE LOWER(p.position) = 'defender';

---48.	Which players scored goals in matches that were held in stadiums with a capacity over 60,000?
SELECT DISTINCT p.name AS player_name
FROM goals g
JOIN players p ON g.pid = p.pid
JOIN matches m ON g.match_id = m.match_id
JOIN stadiums s ON m.stadium = s.name
WHERE s.capacity > 60000;

---49.	How many goals were scored in matches played in cities with specific stadiums in a season?
SELECT s.city, COUNT(*) AS goals
FROM goals g
JOIN matches m ON g.match_id = m.match_id
JOIN stadiums s ON m.stadium = s.name
WHERE m.season = '2021-2022'
GROUP BY s.city
ORDER BY goals DESC;

---50.	Which players scored goals in matches with the highest attendance (over 100,000)?
SELECT DISTINCT p.name AS player_name
FROM goals g
JOIN players p ON g.pid = p.pid
JOIN matches m ON g.match_id = m.match_id
WHERE m.attendance > 100000;
SELECT MAX(attendance), MIN(attendance)
FROM matches;

















































---26.	Which team has the largest home stadium in terms of capacity?
SELECT team_name, home_stadium, capacity
FROM teams t
JOIN stadiums s ON t.home_stadium = s.name
ORDER BY capacity DESC
LIMIT 1;

---27.	Which teams from a each country participated in the UEFA competition in a season?
SELECT DISTINCT t.country, t.team_name, m.season
FROM teams t
JOIN players p ON t.team_name = p.team
JOIN goals g ON p.pid = g.pid
JOIN matches m ON g.match_id = m.match_id;

---28.	Which team scored the most goals across home and away matches in a given season?
SELECT team, COUNT(*) AS total_goals
FROM players p
JOIN goals g ON p.pid = g.pid
JOIN matches m ON g.match_id = m.match_id
WHERE season = '2021-2022'
GROUP BY team
ORDER BY total_goals DESC
LIMIT 1;

---29.	How many teams have home stadiums in a each city or country?
SELECT s.country, COUNT(DISTINCT t.team_name) AS team_count
FROM teams t
JOIN stadiums s ON t.home_stadium = s.name
GROUP BY s.country
ORDER BY team_count DESC;

---30.	Which teams had the most home wins in the 2021-2022 season?
SELECT home_team, COUNT(*) AS home_wins
FROM matches WHERE season = '2021-2022'
 AND home_team_score > away_team_score
GROUP BY home_team
ORDER BY home_wins DESC;












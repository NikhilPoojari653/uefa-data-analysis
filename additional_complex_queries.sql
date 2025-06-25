---51.	What is the average number of goals scored by each team in the first 30 minutes of a match?
SELECT DISTINCT duration FROM goals;

SELECT p.team, 
ROUND(COUNT(*)::numeric / COUNT(DISTINCT g.match_id), 2) AS avg_goals
FROM goals g
JOIN players p ON g.pid = p.pid
WHERE g.duration::int <= 30
GROUP BY p.team
ORDER BY avg_goals DESC;

---52.	Which stadium had the highest average score difference between home and away teams?
SELECT stadium, ROUND(AVG(ABS(home_team_score - away_team_score)), 2) AS avg_diff
FROM matches
GROUP BY stadium
ORDER BY avg_diff DESC
LIMIT 1;

---53.	How many players scored in every match they played during a given season?
SELECT pid FROM goals g
JOIN matches m ON g.match_id = m.match_id
WHERE m.season = '2021-2022'
GROUP BY pid
HAVING COUNT(*) = COUNT(DISTINCT g.match_id);

---54.	Which teams won the most matches with a goal difference of 3 or more in the 2021-2022 season?
SELECT winning_team, COUNT(*) AS big_wins
FROM (SELECT
CASE WHEN home_team_score - away_team_score >= 3 THEN home_team
     WHEN away_team_score - home_team_score >= 3 THEN away_team
     END AS winning_team
FROM matches WHERE season = '2021-2022' AND ABS(home_team_score - away_team_score) >= 3
)
GROUP BY winning_team
ORDER BY big_wins DESC;

---55.	Which player from a specific country has the highest goals per match ratio?
SELECT p.name AS player_name,
ROUND(COUNT(g.goal_id)::decimal / COUNT(DISTINCT g.match_id), 2) AS goals_per_match
FROM players p
JOIN goals g ON p.pid = g.pid
WHERE p.nationality = 'Brazil'
GROUP BY player_name
ORDER BY goals_per_match DESC
LIMIT 1;









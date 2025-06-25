---10. What was the highest-scoring match in a particular season?
SELECT match_id, home_team, away_team, (home_team_score + away_team_score) AS total_goals
FROM matches
WHERE season = '2021-2022'
ORDER BY total_goals DESC
LIMIT 1;

---11. How many matches ended in a draw in a given season?
SELECT COUNT(*) AS draw_matches
FROM matches
WHERE season = '2021-2022'
AND home_team_score = away_team_score;

---12.Which team had the highest average score (home and away) in the season 2021-2022?
SELECT team, ROUND(AVG(score), 2) AS avg_score
FROM (
SELECT home_team AS team, home_team_score AS score
FROM matches
WHERE season = '2021-2022'
UNION ALL SELECT away_team AS team, away_team_score AS score
FROM matches
WHERE season = '2021-2022'
)
GROUP BY team
ORDER BY avg_score DESC
LIMIT 1;

---13.	How many penalty shootouts occurred in a each season?
SELECT DISTINCT penalty_shoot_out FROM matches;
SELECT season, COUNT(*) AS shootout_matches
FROM matches
WHERE penalty_shoot_out::int = 0
GROUP BY season
ORDER BY season;

---14.	What is the average attendance for home teams in the 2021-2022 season?
SELECT ROUND(AVG(attendance)) AS avg_attendance
FROM matches
WHERE season = '2021-2022';

---15.	Which stadium hosted the most matches in a each season?
SELECT season, stadium, COUNT(*) AS matches
FROM matches
GROUP BY season, stadium
ORDER BY season, matches DESC;

---16.	What is the distribution of matches played in different countries in a season?
SELECT s.country, COUNT(*) AS matches
FROM matches m
JOIN stadiums s ON m.stadium = s.name
WHERE season = '2021-2022'
GROUP BY s.country
ORDER BY matches DESC;

---17.	What was the most common result in matches (home win, away win, draw)?
SELECT result, COUNT(*) AS count
FROM (
SELECT CASE WHEN home_team_score > away_team_score THEN 'Home Win'
            WHEN home_team_score < away_team_score THEN 'Away Win'
ELSE 'Draw'
END AS result FROM matches
)
GROUP BY result
ORDER BY count DESC;































































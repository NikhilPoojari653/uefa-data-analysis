---1. Player who scored the most goals in each season?
SELECT season, pid, COUNT(*) AS goals
FROM goals g
JOIN matches m ON g.match_id = m.match_id
GROUP BY season, pid
ORDER BY season, goals DESC;

---2.How many goals did each player score in a given season?
SELECT pid, COUNT(*) AS goals
FROM goals g
JOIN matches m ON g.match_id = m.match_id
WHERE season = '2021-2022'
GROUP BY pid
ORDER BY goals DESC;

---3. What is the total number of goals scored in ‘mt403’ match?
SELECT COUNT(*) AS total_goals
FROM goals
WHERE match_id = 'mt403';

---4.Which player assisted the most goals in a each season?
SELECT season, assist, COUNT(*) AS total_assists
FROM goals g
JOIN matches m ON g.match_id = m.match_id
WHERE assist IS NOT NULL AND assist <> ''
GROUP BY season, assist
ORDER BY season, total_assists DESC;

---5. Which players have scored goals in more than 10 matches?
SELECT pid, COUNT(DISTINCT match_id) AS matches
FROM goals
GROUP BY pid
HAVING COUNT(DISTINCT match_id) > 10;

---6. What is the average number of goals scored per match in a given season?
SELECT season, ROUND(COUNT(g.goal_id)::numeric / COUNT(DISTINCT m.match_id), 2) AS avg_goals
FROM goals g
JOIN matches m ON g.match_id = m.match_id
GROUP BY season;

---7. Which player has the most goals in a single match?
SELECT match_id, pid, COUNT(*) AS goals
FROM goals
GROUP BY match_id, pid
ORDER BY goals DESC
LIMIT 1;

---8. Which team scored the most goals in the all seasons?
SELECT p.team, COUNT(*) AS total_goals
FROM goals g
JOIN players p ON g.pid = p.pid
GROUP BY p.team
ORDER BY total_goals DESC;

---9. Which stadium hosted the most goals scored in a single season?
SELECT season, stadium, COUNT(*) AS total_goals
FROM goals g
JOIN matches m ON g.match_id = m.match_id
GROUP BY season, stadium
ORDER BY total_goals DESC;






















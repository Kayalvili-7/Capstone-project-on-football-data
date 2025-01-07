use cproject;
select count(*)from appearances; -- The total number of appearances recorded in the dataset

select count(*)from game_events; -- The total number of game events logged in the dataset

select count(*)from game_lineups; -- The total number of game lineups captured in the dataset 

select count(*)from games; -- The total number of games documented in the dataset
select count(*)from players; -- The total number of players included in the dataset

select count(*)from footballclean_data;  -- The total number of records in the footballclean_data dataset

select * from footballclean_data;  -- returns all the records and fields from the footballclean_data dataset

describe games;
describe footballclean_data;

-- SPRINT 8 :a.) REFREE ANALYSIS

-- 1. How many yellow/red cards have been given by each referee?

SELECT referee, SUM(yellow_cards) AS total_yellow_cards, SUM(red_cards) AS total_red_cards
FROM footballclean_data
GROUP BY referee
ORDER BY total_yellow_cards desc;

-- INTERPRETATION: Referee Card Distribution: The analysis reveals that Felix Zwayer issued the highest number of yellow cards (16) and one red
-- card, while other referees like Dr. Felix Brych and Guido Winkmann issued 14 and 13 yellow cards, respectively, without any red cards

-- 2. Which referees officiated the most matches during the season?

SELECT referee, count(DISTINCT game_id) AS total_matches
FROM footballclean_data
GROUP BY referee
ORDER BY total_matches DESC limit 10;

-- INTERPRETATION: Match Officiation Count: Dr. Felix Brych officiated the highest number of matches, overseeing 62 games, 
-- followed closely by Felix Zwayer with 59 matches and Manuel Graofe with 58 matches, indicating their significant involvement in the season.

-- 3. What is the average number of fouls called per referee? (Assuming fouls : red and yellow cards)

SELECT referee, AVG(yellow_cards + red_cards) AS average_fouls
FROM footballclean_data
GROUP BY referee
ORDER BY average_fouls DESC ;

-- INTERPRETATION : Average Fouls per Referee: Cuneyt Cakır leads with an average of 1.25 fouls per match, 
-- indicating a slightly more active officiating style, while several referees, including Marcin Borski and Marijo Strahonja, 
-- average 1.00 foul per match.

-- 4. Which referees tend to officiate matches with the highest number of cards given?

SELECT referee, count(DISTINCT game_id) AS total_matches,SUM(yellow_cards + red_cards) AS total_cards
FROM footballclean_data
GROUP BY referee, game_id
ORDER BY  total_cards DESC;

-- INTERPRETATION: Card Distribution per Referee: Jonathan Moss officiated a match that resulted in the highest total of 6 cards followed by
-- Felix Zwayer and Bjorn Kuipers, each issuing 4 cards in their respective matches, indicating a propensity for high card issuance during certain games.


-- SPRINT 8 : b.) Substitution Patterns

-- 1. What is the average minute of the game when substitutions are made?

SELECT AVG(minute) AS average_substitution_minute
FROM footballclean_data
WHERE type = 'Substitutions';

-- INTERPRETATION : Average Timing of Substitutions: The substitutions are typically made at an average minute of approximately 68.5, 
-- suggesting that coaches often utilize this period to optimize player performance as the match approaches its final third.


-- 2. How does the number of substitutions vary between winning and losing teams?

SELECT 
    CASE 
        WHEN home_club_goals > away_club_goals THEN 'Home Team Wins'
        WHEN home_club_goals < away_club_goals THEN 'Away Team Wins'
        ELSE 'Draw'
    END AS match_result,
    COUNT(*) AS total_substitutions
FROM footballclean_data
WHERE type = 'Substitutions'
GROUP BY match_result;

-- INTERPRETATION: Substitution Trends by Match Outcome: Teams that win their matches tend to make the most substitutions, averaging 1,432 total
-- substitutions, compared to 1,012 for away teams that win and 770 during drawn matches, indicating a proactive strategy in securing victory.


-- 3. Which players are most frequently substituted during a match?

SELECT player_name, COUNT(*) AS substitution_count
FROM footballclean_data
WHERE type = 'Substitutions'
GROUP BY player_name
ORDER BY substitution_count DESC
LIMIT 10;

-- INTERPRETATION: Top Substituted Players: Fabian Johnson leads with 185 substitutions, indicating he is a key player frequently rotated 
-- during matches, followed by Timothy Chandler and John Anthony Brooks, who have 175 and 162 substitutions, respectively.

-- 4. What is the distribution of substitutions made by position (e.g., attackers, midfielders)?

SELECT position, COUNT(*) AS substitution_count
FROM footballclean_data
WHERE type = 'Substitutions'
GROUP BY position
ORDER BY substitution_count DESC;

-- INTERPRETATION: Substitution Distribution by Position: The data reveals that attackers are the most frequently substituted players,
-- with a total of 1,027 substitutions, followed closely by defenders at 965, while midfielders and goalkeepers have lower substitution counts 
-- of 828 and 394, respectively.


-- SPRINT 8 : c.)  Event Analysis

-- 1. What is the distribution of events such as goals, cards, and substitutions across a match?

SELECT game_id, minute,
    COUNT(CASE WHEN goals > 0 THEN 1 END) AS total_goals,
    COUNT(CASE WHEN yellow_cards > 0 THEN 1 END) AS total_yellow_cards,
    COUNT(CASE WHEN red_cards > 0 THEN 1 END) AS total_red_cards,
    COUNT(CASE WHEN type = 'Substitutions' THEN 1 END) AS total_substitutions
FROM footballclean_data
GROUP BY game_id,minute
ORDER BY total_substitutions desc limit 10;

-- INTERPRETATION: The query shows that the matches with the most substitutions (up to 3 per game) often have no recorded goals or cards, 
-- indicating instances where teams made tactical changes without significant events affecting the scoreline.

-- 2. Which types of events (goals, assists, cards) are most common in specific time intervals (e.g., first 15 minutes, last 10 minutes)?

SELECT 
    CASE 
        WHEN minute <= 15 THEN 'First 15 Minutes'
        WHEN minute BETWEEN 75 AND 90 THEN 'Last 15 Minutes'
        ELSE 'Other Intervals'
    END AS time_interval,
    COUNT(CASE WHEN goals > 0 THEN 1 END) AS total_goals,
    COUNT(CASE WHEN assists > 0 THEN 1 END) AS total_assists,
    COUNT(CASE WHEN yellow_cards > 0 THEN 1 END) AS total_yellow_cards,
    COUNT(CASE WHEN red_cards > 0 THEN 1 END) AS total_red_cards
FROM footballclean_data
GROUP BY time_interval
ORDER BY time_interval; 

-- INTERPRETATION: The analysis reveals that the last 15 minutes of matches see a significant increase in activity, with 132 goals and
-- 106 yellow cards, compared to just 44 goals and 16 yellow cards in the first 15 minutes, indicating heightened urgency as matches
-- approach their conclusion.

-- 3. How do event occurrences vary between teams in home vs. away games?

SELECT 
    club_name,
    home_away,
    SUM(goals > 0) AS total_goals,
    SUM(yellow_cards > 0) AS total_yellow_cards,
    SUM(red_cards > 0) AS total_red_cards,
    SUM(CASE WHEN type = 'Substitutions' THEN 1 ELSE 0 END) AS total_substitutions
FROM (
    SELECT 
        home_club_name AS club_name, 'Home' AS home_away, goals, yellow_cards, red_cards, type
    FROM footballclean_data
    UNION ALL
    SELECT 
        away_club_name AS club_name, 'Away' AS home_away, goals, yellow_cards, red_cards, type
    FROM footballclean_data
) AS combined_data
GROUP BY club_name, home_away
ORDER BY total_substitutions desc;

-- INTERPRETATIONS: Home Advantage in Event Counts: The data indicates that Borussia Verein für Leibesübung 1900 e.V. had the highest number
-- of events while playing at home, with 47 goals and 192 substitutions, suggesting a strong performance in home matches that likely contributes 
-- to their overall success.
-- Comparative Trends: In contrast, Borussia Dortmund scored 22 goals in away matches while achieving a notable 161 substitutions, 
-- which may reflect their tactical approach to adapt and manage game dynamics more aggressively in away games compared to their home performances.



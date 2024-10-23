-- Step 1: Create the new table at the start
CREATE OR REPLACE TABLE `looker-tickets.zendesk.confidence_score` AS

WITH agent_stats AS (
  -- Step 2: Calculate agent-level metrics including standard deviation of sentiment
  SELECT 
    agent_name,
    COUNT(Ticket_ID) AS tickets,  -- Total number of tickets
    ROUND(AVG(Sentiment_Integer), 1) AS avg_sentiment_integer,  -- Avg sentiment score
    STDDEV(Sentiment_Integer) AS stddev_sentiment  -- Variability in sentiment score
  FROM `looker-tickets.zendesk.tickets_update`
  GROUP BY agent_name
),

-- Step 3: Calculate Confidence Score for each agent
confidence_calc AS (
  SELECT
    agent_name,
    tickets,
    avg_sentiment_integer,
    stddev_sentiment,
    -- Refined confidence score formula:
    -- Higher tickets increase confidence, and higher stddev reduces it more significantly.
    CASE 
      WHEN stddev_sentiment IS NULL THEN 0  -- Handle cases with no standard deviation
      ELSE ROUND(1 / (1 + (LOG(1 + stddev_sentiment) / SQRT(tickets))), 2)  -- Refined confidence score formula
    END AS confidence_score  -- Higher tickets and lower stddev lead to higher confidence
  FROM agent_stats
)

-- Step 4: Select the final output
SELECT 
  agent_name,
  tickets,
  avg_sentiment_integer,
  confidence_score
FROM confidence_calc
ORDER BY tickets DESC, confidence_score DESC;
CREATE OR REPLACE TABLE `looker-tickets.zendesk.comment_stats` AS
SELECT
  Ticket_ID,
  SUM(Comment_Length) AS total_comment_length,
  COUNT(Comment_ID) AS comment_count,
  TIMESTAMP_DIFF(MAX(Comment_Created_Time), MIN(Comment_Created_Time), DAY) AS conversation_duration_days
FROM
  `looker-tickets.zendesk.new_comments`
GROUP BY
  Ticket_ID;
CREATE OR REPLACE TABLE `looker-tickets.zendesk.conversations` AS
SELECT
  Ticket_ID,
  STRING_AGG(CONCAT('Comment by ', Commenter_Name, ': ', Comment_Body), ' ' ORDER BY Comment_Created_Time ASC) AS conversation_text
FROM
  `looker-tickets.zendesk.new_comments`
GROUP BY
  Ticket_ID;
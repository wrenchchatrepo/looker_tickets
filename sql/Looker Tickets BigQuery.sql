DELETE FROM
  `looker-tickets.zendesk.new_tickets`
WHERE
  Ticket_ID IN (
    217540, 216533, 211801, 108944, 173627, 107391, 115120, 115706, 
    211797, 211779, 164168, 130804, 202143, 219786, 108551, 212517, 215930
  )
  AND RND_T < (
    SELECT
      MAX(RND_T)
    FROM
      `looker-tickets.zendesk.new_tickets` AS t2
    WHERE
      t2.Ticket_ID = `looker-tickets.zendesk.new_tickets`.Ticket_ID
  );
CREATE OR REPLACE TABLE `looker-tickets.zendesk.new_comments` AS
SELECT
  `Tickets Ticket ID` AS Ticket_ID,
  `Tickets Subject` AS Subject_STRING,
  `Ticket Comment Comment Created Time` AS Comment_Created_Time,
  `Ticket Comment ID` AS Comment_ID,
  `Ticket Comment User ID` AS Comment_User_ID,
  `Ticket Comment Commenter Name` AS Commenter_Name,
  `Ticket Comment Public _Yes _ No_` AS Is_Comment_Public,
  `Ticket Comment Commenter Is Doit Employee _Yes _ No_` AS Is_Doit_Employee,
  `Ticket Comment Commenter Is Doit Support Bot _Yes _ No_` AS Is_Doit_Support_Bot,
  `CommentLength` AS Comment_Length,
  `Ticket Comment Body` AS Comment_Body,
  `Ticket Comment Comment Count` AS Comment_Count
FROM
  `looker-tickets.zendesk.comments`;
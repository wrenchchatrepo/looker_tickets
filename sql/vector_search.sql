-- Create or Replace a new table with best matches for Issue and Resolution using embeddings and ML.DISTANCE
CREATE OR REPLACE TABLE `looker-tickets.zendesk.tickets_with_matches` AS
WITH AvaKeyWords_Embeddings AS (
    SELECT
        AK.Name,
        AK.Type,
        AK.Embedding
    FROM
        `looker-tickets.zendesk.AvaKeyWords` AS AK
),
-- Use ML.DISTANCE for matching issues
IssueMatches AS (
    SELECT
        conv.ticket_id,
        ARRAY_AGG(STRUCT(AKE.Name, ML.DISTANCE(conv.embeddings, AKE.Embedding, 'COSINE') AS distance)
            ORDER BY ML.DISTANCE(conv.embeddings, AKE.Embedding, 'COSINE') ASC
            LIMIT 1)[OFFSET(0)] AS best_match
    FROM
        `looker-tickets.zendesk.conversations_update_deduped_clean` AS conv
    CROSS JOIN
        AvaKeyWords_Embeddings AS AKE
    WHERE
        AKE.Type = 'Issue'
    GROUP BY
        conv.ticket_id
),
-- Use ML.DISTANCE for matching resolutions
ResolutionMatches AS (
    SELECT
        conv.ticket_id,
        ARRAY_AGG(STRUCT(AKE.Name, ML.DISTANCE(conv.embeddings, AKE.Embedding, 'COSINE') AS distance)
            ORDER BY ML.DISTANCE(conv.embeddings, AKE.Embedding, 'COSINE') ASC
            LIMIT 1)[OFFSET(0)] AS best_match
    FROM
        `looker-tickets.zendesk.conversations_update_deduped_clean` AS conv
    CROSS JOIN
        AvaKeyWords_Embeddings AS AKE
    WHERE
        AKE.Type = 'Resolution'
    GROUP BY
        conv.ticket_id
)
SELECT
    T.Ticket_ID,
    IM.best_match.Name AS Matched_Issue,
    IM.best_match.distance AS Issue_Similarity_Score,
    RM.best_match.Name AS Matched_Resolution,
    RM.best_match.distance AS Resolution_Similarity_Score,
    T.Priority,
    T.Status
FROM
    `looker-tickets.zendesk.tickets_update` AS T
LEFT JOIN IssueMatches AS IM ON T.Ticket_ID = IM.ticket_id
LEFT JOIN ResolutionMatches AS RM ON T.Ticket_ID = RM.ticket_id;

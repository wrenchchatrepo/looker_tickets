## Analysis Summary of Looker-Google Drive-OAuth Tickets
### Dion Edge
### October 21, 2024
---
## Objective: 

To identify and quantify support tickets related to authentication issues involving OAuth, Looker, and Google Drive on the Google Cloud platform within the past 12 months. 

This analysis aims to understand the prevalence and nature of these specific issues to inform potential improvements in product integration, documentation, or support processes.

## Method: 

We employed a dual-pronged approach to identify relevant tickets:

### Cosine Similarity Search (Semantic Analysis):

1. Utilized a pre-trained embedding model to generate vector representations of ticket content.

2. Performed a cosine similarity search to find tickets semantically similar to the issue description.

3. Set a similarity threshold to identify the most relevant tickets.

### SQL Keyword Search (Syntactic Analysis):

1. Queried the ticket database for comments containing specific keyword combinations: 

	a) Both "looker" and "oauth" 
	
	b) Both "google drive" and "looker"

2. This method captures tickets explicitly mentioning the key terms related to the issue.

### Additional Filtering Criteria:

+ Limited results to tickets associated with Google Cloud platform.
+ Included only tickets created after October 1, 2023, to focus on recent issues.
+ The results from both methods were combined into a single table for analysis.

## Results: 

Our analysis identified a total of 27 tickets meeting the specified criteria:

### Cosine Similarity Search: 

**4 tickets** These tickets are semantically related to the authentication issues involving OAuth, Looker, and Google Drive, even if they don't explicitly mention all keywords.

### SQL Keyword Search: 

**23 tickets** These tickets explicitly mention the key terms related to the issue in their comments.

## Key Findings:

The keyword search identified significantly more tickets (23) than the semantic search (4), suggesting that most relevant issues are explicitly mentioning the key terms.

The total of 27 tickets over approximately 12 months indicates that this is a recurring issue, averaging about 2-3 tickets per month.

The discrepancy between semantic and keyword search results suggests that: 

	a) The issue is often described using specific technical terms, making keyword search effective. 
	
	b) There might be related issues that don't use the exact terminology but are semantically similar, captured by the cosine similarity search.

These results provide a clear indication that authentication issues involving OAuth, Looker, and Google Drive on the Google Cloud platform are a persistent concern for users. This data can be used to prioritize improvements in integration, enhance documentation, or develop targeted support resources to address these recurring issues.

## Enclosed Documents
+ Analysis_Summary_Looker_Google_Drive_OAuth.md
+ Combined Search Results.csv
+ Combined search results.sql
+ looker-tickets_zendesk_schema.md
+ README_Zendesk_Tickets.md
+ README_zendesk_ticket_similarity_search.md
+ Zendesk_Embedding_App.md
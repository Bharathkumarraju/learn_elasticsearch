1. Master Node - Manages cluster wide changes and maintains the metadata.
2. Data Node - Responsible for storing and indexing the data also handles search and aggregation.
3. Data Cotent
4. Data Hot - Stores frequently accessed data.
5. Data Warm - Balances storage efficiency and performance for moderately accessed data.
6. Data Cold - Stores infrequently accessed data, cost-optimized over performance
7. Data Frozen - Holds rarely accessed data, prioritizing cost efficiency with high latency
8. Data Ingest - Pre-processes documents via ingest pipelines before indexing.
9. ML Node  - Handling machine learning tasks like anomaly detection.
10. Transform - Executes data transfermations.
11. Remote Cluster Client - Access Gateway for cross cluster searches

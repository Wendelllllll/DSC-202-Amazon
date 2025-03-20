# DSC-202-Amazon
List of our group members:

Hao Wang

Tianxiang Wang

Tianhao Zhou

Presentation: Presentation_with_Demo.mp4

Powerpoint: Amazon Product Co-Purchasing Analysis.pdf

Need to download PostgresSQL (Datagrip), Neo4j, Mongo DB and Redis

# Neo4j Graph Database
In Relational Database (PostgreSQL). Run "trimming_data_for_neo.sql", export "amazon_products_for_neo.csv", "co_purchased.csv", "trim_category.csv". 

Inport above three files into Neo4j Graph DBMS. Run the Cypher script "construct_graph_database_in_neo" in Neo4j Browser. 


!!! The default Neo4j memory settings are too small for this dataset !!!

Example Memory Settings Modification

dbms.memory.heap.initial_size=4g

dbms.memory.heap.max_size=6g

dbms.memory.pagecache.size=3g

dbms.backup.enabled=false

dbms.jvm.additional=-Dlog4j2.formatMsgNoLookups=true

dbms.memory.transaction.global_max_size=4g

dbms.memory.transaction.max_size=4g

dbms.memory.transaction.total.max=4g



# Final Recommendation System

Run the notebook named "Recommendation System with Demo.ipynb" (original environment in Jupyter lab)

!!! You need to repalce your PostgreSQL/Neo4j connection username and password with your own !!!

Run the first cells to check if your database is connected successfully, you can test the recommendation system with the final simple UI with any input.

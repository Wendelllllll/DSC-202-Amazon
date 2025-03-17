# DSC-202-Amazon


# Neo4j Graph Database
In Relational Database (PostgreSQL). Run "trimming_data_for_neo.sql", export "amazon_products_for_neo.csv", "co_purchased.csv", "trim_category.csv". 

Inport above three files into Neo4j Graph DBMS. Run the Cypher script "construct_graph_database_in_neo" in Neo4j Browser. 


**The default Neo4j memory settings are too small for this dataset. 
**Example Memory Settings Modification
dbms.memory.heap.initial_size=4g

dbms.memory.heap.max_size=6g

dbms.memory.pagecache.size=3g

dbms.backup.enabled=false

dbms.jvm.additional=-Dlog4j2.formatMsgNoLookups=true

dbms.memory.transaction.global_max_size=4g

dbms.memory.transaction.max_size=4g

dbms.memory.transaction.total.max=4g



# Recommendation System(combined relational+graph data)

Run the notebook named "recommnedationsystem(1).ipynb"

!!! You need to repalce your PostgreSQL/Neo4j connection username and poassword with you own information.

Run the first two cells to check if your database is connected successfully, then you can test the recommendation system maybe using some more cases.

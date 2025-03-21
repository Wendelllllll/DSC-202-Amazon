# DSC-202-Amazon
List of our group members:

Hao Wang

Tianxiang Wang

Tianhao Zhou

Presentation: Presentation_with_Demo.mp4

Powerpoint: Amazon Product Co-Purchasing Analysis.pdf

# Databases setup for Recommendations System 
Need to download PostgresSQL (Datagrip), Neo4j, Mongo DB and Redis.

Download Node.js for UI if you are using Windows system.

The link to our original dataset: [Amazon product co-purchasing network metadata](https://snap.stanford.edu/data/amazon-meta.html)

# PostgresSQL Relational Database
_(Optional) Run "Txt_to_csv.ipynb" in python to parse the original dataset into two importable csv files: "amazon_products.csv" and "amazon_reviews.csv" (resulting csv files are already downloadable in data folder)_

Run "import_preprocesing_relational.sql" table schemas part to create "amazon_prodcuts" table and "amazon_reviews" table. Import these two csv files from the data folder to corresponding tables: "amazon_products.csv" and "amazon_reviews.csv". Run the rest of "import_preprocesing_relational.sql" in Datagrip for table cleaning and preprocessing.


# Neo4j Graph Database
_(Optional) In Relational Database (PostgreSQL). Run "trimming_data_for_neo.sql" to export "amazon_products_for_neo.csv", "co_purchased.csv", "trim_category.csv". (resulting csv files are already downloadable in data folder)_

Inport above three csv files into Neo4j Graph DBMS. Run the Cypher script "construct_graph_database_in_neo" in Neo4j Browser. 


!!! You will need two plugins in your Neo4j Database: APOC and Graph Data Science Library !!! 

!!! The default Neo4j memory settings are too small for this dataset, you might want to add the followings to your DBMS settings !!!

Example Memory Settings Modification
```diff
dbms.memory.heap.initial_size=4g

dbms.memory.heap.max_size=6g

dbms.memory.pagecache.size=3g

dbms.backup.enabled=false

dbms.jvm.additional=-Dlog4j2.formatMsgNoLookups=true

dbms.memory.transaction.global_max_size=4g

dbms.memory.transaction.max_size=4g

dbms.memory.transaction.total.max=4g
```

# Key-value database
Download and run Mongo DB and Redis on local environment

# Final Recommendation System

Run the notebook named "Recommendation System with Demo.ipynb" (original environment in Jupyter lab)

!!! You need to repalce all your PostgreSQL/Neo4j connection information （username，password，database name）with your own !!!

Run the first two cells to check if your databases is connected successfully, you can test the recommendation system using the last cell's UI with any word or ASIN input.

!!! For Windows system to display the UI, need to download node.js at https://nodejs.org !!!

if the UI still not displaying, try running the followings in your jupyter notebook:

```diff
!pip install ipywidgets --upgrade

!jupyter labextension install @jupyter-widgets/jupyterlab-manager

!pip install --upgrade jupyter ipywidgets jupyterlab_widgets jupyter_nbextensions_configurator
```



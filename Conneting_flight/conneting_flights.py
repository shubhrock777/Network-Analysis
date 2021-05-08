import pandas as pd
import numpy as np
import networkx as nx 


# Degree Centrality
conneting_route = pd.read_csv("D:/BLR10AM/Assi/11.network analysis/Datasets_Network Analytics/connecting_routes.csv",header=None)

########3.	Data Cleaning

#droping empty column
conneting_route.drop([6],axis=1,inplace=True)

# changing index cols with name() 
conneting_route.columns = ["flights", " ID", "main Airport" , "main Airport ID", "Destination","Destination  ID","haults","machinary"]


"""2.1 Make a table as shown above and provide information about the features such as its 
Data type and its relevance to the model building, if not relevant provide reasons and 
provide description of the feature"""

#######feature of the dataset to create a data dictionary
description  = ["Flights type",
                "Flight ID",
                "Departure airport name",
                 "Departure airport ID",
                 "Destination airport name",
                 "Destination airport ID",
                  "Numbers of haults",
                 "Type of flight"]

d_types =["nominal","nominal","nominal","nominal","nominal","nominal","nominal","nominal"]

data_details =pd.DataFrame({"column name":conneting_route.columns,
                "description":description,
                "data types ":d_types,
                "data format":conneting_route.dtypes})



########3.	Data Cleaning


conneting_route.nunique()

conneting_route.isnull().sum()

# for Mean,Meadian,Mode imputation we can use Simple Imputer or df.fillna()
from sklearn.impute import SimpleImputer

# Mode Imputer
mode_imputer = SimpleImputer(missing_values=np.nan, strategy='most_frequent')
conneting_route["machinary"] = pd.DataFrame(mode_imputer.fit_transform(conneting_route[["machinary"]]))
conneting_route.isnull().sum()  


"""4.	Model Building
5.1	Perform Network analytics on the given datasets
5.2Briefly explain the model output in the documentation """

g_data = nx.Graph()

g_data = nx.from_pandas_edgelist(conneting_route, source = 'main Airport', target = 'Destination')

print(nx.info(g_data))

d_c = nx.degree_centrality(g_data)  # Degree Centrality
print(d_c) 
#top 10  Degree Centrality
top_10_dc= sorted(d_c, key=d_c.get, reverse=True)[:10]
top_10_dc


#for graph 
pos = nx.spring_layout(g_data, k = 0.15)
nx.draw_networkx(g_data, pos, node_size = 50, node_color = 'pink')


# closeness centrality
closeness = nx.closeness_centrality(g_data)
print(closeness)
#top 10 closeness centrality
top_10_cc= sorted(closeness, key=closeness.get, reverse=True)[:10]
top_10_cc



## Betweeness Centrality 
b_c = nx.betweenness_centrality(g_data) # Betweeness_Centrality
print(b_c)
#top 10 Betweeness Centrality
top_10_bc= sorted(b_c, key=b_c.get, reverse=True)[:10]
top_10_bc



## Eigen-Vector Centrality
evg = nx.eigenvector_centrality(g_data) # Eigen vector centrality
print(evg)
#top 10 Eigen vector centrality
top_10_evg= sorted(evg, key=evg.get, reverse=True)[:10]
top_10_evg



# cluster coefficient
cluster_coeff = nx.clustering(g_data)
print(cluster_coeff)

# Average clustering
a_c = nx.average_clustering(g_data) 
print(a_c)

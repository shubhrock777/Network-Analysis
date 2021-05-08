import pandas as pd
import numpy as np
import networkx as nx 


# Degree Centrality
flight_hault = pd.read_csv("D:/BLR10AM/Assi/11.network analysis/Datasets_Network Analytics/flight_hault.csv",header=None)



# changing index cols with name() 
flight_hault.columns = ["ID","Name","City","Country","IATA_FAA","ICAO","Latitude","Longitude","Altitude","Time","DST","Tz database time"]


"""2.1 Make a table as shown above and provide information about the features such as its 
Data type and its relevance to the model building, if not relevant provide reasons and 
provide description of the feature"""

#######feature of the dataset to create a data dictionary
description  = ["ID is nothing just index",
                "name of place",
                "name of city",
                 "country name",
                 "Departure airport name",
                 "Destination airport name"
                 ,"latitude","longitude","altitude","one clock time for whole",
                  "dst",
                 "time Zone"]

d_types =["count","nominal","nominal","nominal","nominal","nominal","ratio","ratio","ratio","Interval","nominal","nominal"]

data_details =pd.DataFrame({"column name":flight_hault.columns,
                "description":description,
                "data types ":d_types,
                "data format":flight_hault.dtypes})



########3.	Data Cleaning

#droping empty column
flight_hault.drop(['ID'],axis=1,inplace=True)


flight_hault.nunique()

flight_hault.isnull().sum()

# making new data frame with dropped NA values  
flight_hault_1 = flight_hault.dropna(axis = 0, how ='any')

flight_hault_1.isnull().sum()



"""4.	Model Building
5.1	Perform Network analytics on the given datasets
5.2Briefly explain the model output in the documentation """

g_data = nx.Graph()

g_data = nx.from_pandas_edgelist(flight_hault_1, source = 'IATA_FAA', target = 'ICAO')

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
evg =  nx.eigenvector_centrality(g_data)  # Eigen vector centrality
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



library("igraph")
library("readr")

flight_hault <- read.csv("D:/BLR10AM/Assi/11.network analysis/Datasets_Network Analytics/flight_hault.csv", header = FALSE)
colnames(flight_hault) <- c("ID","Name","City","Country","IATA_FAA","ICAO","Latitude","Longitude","Altitude","Time","DST","Tz database time")
head(flight_hault)


#droping roe in 5,6 columns has null value for 

flight_hault1 <- flight_hault[-which(flight_hault$IATA_FAA == ""), ]
flight_hault2 <- flight_hault1[-which(flight_hault1$ICAO == ""), ]

graph_data <- graph.edgelist(as.matrix(flight_hault2[, c(5, 6)]), directed = TRUE)
plot(graph_data)

## How many airports are there in the network?

vcount(graph_data)

## How many connections are there in the network?
ecount(graph_data)

# Which airport has most flights coming in, and how many?
indegree <- degree(graph_data, mode = "in")
max(indegree)
index <- which(indegree == max(indegree))
index
indegree[index]



# Which airport has most flights going out of, and how many?
outdegree <- degree(graph_data, mode = "out")
max(outdegree)
index <- which(outdegree == max(outdegree))
outdegree[index]
which(flight_hault2$IATA_FAA == "BFT")
which(flight_hault2$IATA_FAA == "ZYA")

# Which airport is close to most of the airports (in terms of number of flights)

closeness_in <- closeness(graph_data, mode = "in", normalized = TRUE)
max(closeness_in)
index <- which(closeness_in == max(closeness_in))
index
flight_hault2[578,]


# Which airport comes in between most of the routes and hence is an important international hub?

btwn <- betweenness(graph_data, normalized = TRUE)
max(btwn)
index <- which(btwn == max(btwn))
index



# Degree, closeness, and betweenness centralities together
centralities <- cbind(indegree, outdegree, closeness_in, btwn)
colnames(centralities) <- c("inDegree","outDegree","closenessIn","betweenness")
head(centralities)

# correlations of the centralities
cor(centralities)

# Any pair with low correlation?
plot(centralities[, "closenessIn"], centralities[, "betweenness"])




# Which is one of the most important airport in the world (the Google way)?

eigenv <- eigen_centrality(graph_data, directed = TRUE, scale = FALSE, weights = NULL)
eigenv$vector
max(eigenv$vector)
index <- which(eigenv$vector == max(eigenv$vector))
index
flight_hault[7848,]



pg_rank <- page_rank(graph_data, damping = 0.999) # do not put damping=1; the solution not necessarily converges; put a value close to 1.
pg_rank$vector
max(pg_rank$vector)
index <- which(pg_rank$vector == max(pg_rank$vector))
pg_rank$vector[index]


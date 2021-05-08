

library("igraph")
library("readr")

connecting_routes <- read.csv("D:/BLR10AM/Assi/11.network analysis/Datasets_Network Analytics/connecting_routes.csv", header=FALSE)
colnames(connecting_routes) <- c("flights", " ID", "main_Airport" , "main Airport ID", "Destination","Destination  ID","blanks","haults","machinary")
head(connecting_routes)

graph_data <- graph.edgelist(as.matrix(connecting_routes[, c(3, 5)]), directed = TRUE)
plot(graph_data)

## How many airports are there in the network?
vcount(graph_data)

## How many connections are there in the network?
ecount(graph_data)

# Which airport has most flights coming in, and how many?

indegree <- degree(graph_data, mode = "in")
max(indegree)
index <- which(indegree == max(indegree))
indegree[index]
which(connecting_routes$main_Airport == "ATL")


# Which airport has most flights going out of, and how many?
outdegree <- degree(graph_data, mode = "out")
max(outdegree)
index <- which(outdegree == max(outdegree))
outdegree[index]
which(connecting_routes$main_Airport == "ATL")


# Which airport is close to most of the airports (in terms of number of flights)

closeness_in <- closeness(graph_data, mode = "in", normalized = TRUE)
max(closeness_in)
index <- which(closeness_in == max(closeness_in))
closeness_in[index]
which(connecting_routes$main_Airport == "FRA")


# Which airport comes in between most of the routes and hence is an important international hub?

btwn <- betweenness(graph_data, normalized = TRUE)
max(btwn)
index <- which(btwn == max(btwn))
btwn[index]
which(connecting_routes$main_Airport == "LAX")


# Degree, closeness, and betweenness centralities together
centralities <- cbind(indegree, outdegree, closeness_in, btwn)
colnames(centralities) <- c("inDegree","outDegree","closenessIn","betweenness")
head(centralities)

# correlations of the centralities
cor(centralities)

# Any pair with low correlation?
plot(centralities[, "closenessIn"], centralities[, "betweenness"])

subset(centralities, (centralities[,"closenessIn"] > 0.015) & (centralities[,"betweenness"] > 0.06))
connecting_routes[which(connecting_routes$main_Airport == "LAX"), ]
connecting_routes[which(connecting_routes$main_Airport == "CDG"), ]
connecting_routes[which(connecting_routes$main_Airport == "ANC"), ]

subset(centralities, (centralities[, "closenessIn"] < 0.005) & (centralities[, "betweenness"] < 0.02))


# Which is one of the most important airport in the world (the Google way)?

eigenv <- eigen_centrality(graph_data, directed = TRUE, scale = FALSE, weights = NULL)
eigenv$vector
max(eigenv$vector)
index <- which(eigenv$vector == max(eigenv$vector))
eigenv$vector[index]
which(connecting_routes$main_Airport == "ATL")


pg_rank <- page_rank(graph_data, damping = 0.999) # do not put damping=1; the solution not necessarily converges; put a value close to 1.
pg_rank$vector
max(pg_rank$vector)
index <- which(pg_rank$vector == max(pg_rank$vector))
pg_rank$vector[index]
which(connecting_routes$main_Airport == "ATL")


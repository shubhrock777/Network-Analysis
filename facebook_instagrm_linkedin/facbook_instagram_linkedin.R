

###################  Network construction and visulaization   ################################################
library("igraph")

#######################facebook 




# Load  the facebook csv file
facebook <- read.csv("D:/BLR10AM/Assi/11.network analysis/Datasets_Network Analytics/facebook.csv")
head(facebook) 

# create a newtwork using adjacency matrix
graph_data <- graph.adjacency(as.matrix(facebook), mode = "undirected", weighted = TRUE)
plot(graph_data)




#####################       Instagram

# Load  the Instagram csv file

insta <- read.csv("D:/BLR10AM/Assi/11.network analysis/Datasets_Network Analytics/instagram.csv")
head(insta) 

# create a newtwork using adjacency matrix
graph_data <- graph.adjacency(as.matrix(insta), mode = "undirected", weighted = TRUE)
plot(graph_data)




####################       linkedin


# Load  the linkedin csv file
lnkedin <- read.csv("D:/BLR10AM/Assi/11.network analysis/Datasets_Network Analytics/linkedin.csv")
head(lnkedin) 

# create a newtwork using adjacency matrix
graph_data <- graph.adjacency(as.matrix(lnkedin), mode = "undirected", weighted = TRUE)
plot(graph_data)





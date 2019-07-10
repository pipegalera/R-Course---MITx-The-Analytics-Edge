# Homework 7 - Visualizing Network Data 

rm(list = ls())

# Problem 1 - Summarizing the Data

edges <- read.csv("edges.csv")
users <- read.csv("users.csv")
nrow(edges)*2/nrow(users)
table(users$gender, users$school)

# Problem 2 - Creating a Network

install.packages("igraph")
library(igraph)

?graph.data.frame
g = graph.data.frame(edges, FALSE, users) 
plot(g, vertex.size=5, vertex.label=NA)
sum(degree(g) >=10)

V(g)$size = degree(g)/2+2
plot(g, vertex.label=NA)
table(V(g)$size)

# Problem 3 - Coloring Vertices

V(g)$color = "black"
V(g)$color[V(g)$school == "A"] = "red"
V(g)$color[V(g)$school == "B"] = "gray"
V(g)$color[V(g)$school == "AB"] = "green"
plot(g, vertex.label=NA)

V(g)$color = "black"
V(g)$color[V(g)$locales == "A"] = "red"
V(g)$color[V(g)$locale == "B"] = "green"
plot(g, vertex.label=NA)

# Problem 4 - Other Plotting Options

?igraph.plotting



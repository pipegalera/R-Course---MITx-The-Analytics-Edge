#Homework 6 - Daily Kos

# Problem 1 - Hierarchical Clustering
dailykos<- read.csv("dailykos.csv")
dim(dailykos)
kosDist<- dist(dailykos,method="euclidean")
kosHierClust<- hclust(kosDist, method="ward.D")
plot(kosHierClust)
hierGroups<-cutree(kosHierClust, k=7)
HierCluster1 = subset(dailykos, hierGroups == 1)
table(hierGroups)
HierCluster = split(dailykos, hierGroups)
sapply(HierCluster, nrow)

# Problem 2 - K-Means Clustering

set.seed(1000)
KmeansCluster <- kmeans(dailykos, centers=7)
str(KmeansCluster)
KmeansClusterspl<-split(dailykos, KmeansCluster$cluster)
sapply(KmeansClusterspl, nrow)




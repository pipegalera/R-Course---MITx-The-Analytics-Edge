# Unit6_Recitation

rm(list = ls())

flower <-  read.csv("flower.csv", header = F)
str(flower)
flowermatrix <- as.matrix(flower)
str(flowermatrix)
flowerVector <- as.vector(flowermatrix)
str(flowerVector)
flowerVector2 <- as.vector(flower)
str(flowerVector2)
distance <- dist(flowerVector, method = "euclidean")
clusterIntensity <- hclust(distance, method = "ward")
plot(clusterIntensity)
rect.hclust(clusterIntensity, k=3, border = "red")
flowerClusters <- cutree(clusterIntensity, k=3)
flowerClusters
tapply(flowerVector, flowerClusters, mean)
dim(flowerClusters) <-  c(50,50)
image(flowerClusters, axes = F)
image(flowermatrix, axes = F, col = grey(seq(0,1,length=256)))

rm(list = ls())

healthy <- read.csv("healthy.csv", header = F)
healthyMatrix  <-  as.matrix(healthy)
str(healthyMatrix)
image(healthyMatrix, axes = F, col = grey(seq(0,1,length = 256)) )
healthyVector <- as.vector(healthyMatrix)
str(healthyVector)
k <-  5
set.seed(1)
KMC <- kmeans(healthyVector, centers=k, iter.max = 1000)
str(KMC)
healthyClusters <- KMC$cluster
KMC$centers[2]
dim(healthyClusters) = c(nrow(healthyMatrix), ncol(healthyMatrix))
image(healthyClusters, axes = F, col = rainbow(k))

tumor <- read.csv("tumor.csv", header = F)
tumorMatrix <- as.matrix(tumor)
tumorVector <- as.vector(tumorMatrix)
install.packages("flexclust")
library(flexclust)
KMC.kcca <- as.kcca(KMC, healthyVector)
tumorCluster <- predict(KMC.kcca, newdata = tumorVector)
dim(tumorCluster) = c(nrow(tumorMatrix), ncol(tumorMatrix))
image(tumorCluster, axes = F, col = rainbow(k))

#绘制采样地图
library(ggplot2)
library(OpenStreetMap)
map<-openmap(c(70,-179),c(-70,179),zoom=3,type="stamen-terrain")#openmap(c(70,-179),c(-70,179),type="esri")
map<-openproj(map)
autoplot(map)
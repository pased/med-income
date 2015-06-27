# Данные для карты
library(raster)
library(ggplot2)

russia <- getData('GADM', country='RUS', level=1) # get the data from gadm

russia_projection <- CRS("+init=epsg:3413 +lon_0=105")  # create a projection to fix Kamchatka
russia <- spTransform(russia, russia_projection)

gpclibPermit()

russia_map <- fortify(russia, region = "ID_1")
russia_map <- merge(russia_map, russia, by.x = "id", by.y = "ID_1")

save(russia_map, file="./data/russia_map.rda")

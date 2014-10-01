## Second generation sykkelplotter2

## Establish perfect Oslo mapview and basemap with single-dataset view
## Figure out how to routinize this

## get_map usage:
# get_map(location = c(lon = 10.750, lat = 59.91),
#         zoom = "auto", scale = "auto",
#         maptype = c("terrain", "satellite", "roadmap", "hybrid", "toner", "watercolor"),
#         messaging = FALSE, urlonly = FALSE,
#         filename = "ggmapTemp", crop = TRUE,
#         color = c("color", "bw"),
#         source = c("google", "osm", "stamen", "buttmade"),
#         api_key)


library(ggplot2)
library(ggmap)
library(spatial)
library(mosaic)
library(scales)
## One time loading of the basemap
# d <- data.frame(lat=c(50.659631, 50.607213, 50.608129),
#                   lon=c(3.09319, 3.011473, 3.031529))
oslomap <- get_map(location = c(lon = 10.729, lat = 59.915),
                   zoom = 13, scale = "auto",
                   maptype = "roadmap",
                   messaging = FALSE, urlonly = FALSE,
                   filename = "ggmapTemp", crop = TRUE,
                   color = "bw",
                   source = "google",
                   api_key)

p <- ggmap(oslomap)
p

## One time load of lat/long reference
reference = read.csv("referencelist.1.csv")

## Begin routine code for collecting snapshot bike counts
givenpath = 'week36/compositecsv/'
minute_index = list.files(givenpath)

## Also try (i in seq(0, 10, 2)) with 2 being time resolution so to speak
# for (i in seq(0, length(minute_index), 2)) {
for (i in seq(1, length(minute_index), 20)) {   ## One map per dataset (change to 1:length(minute_index))
  csvfile <- minute_index[i]  ## Reset to i 
  csvdata <- read.csv(file=paste(givenpath, csvfile, sep=""))
  csvdata$id = as.numeric(csvdata$id)
  sorted = csvdata[order(csvdata$id),] 
  sorted = head(sorted, -5)
  ref_with_bikes = reference
  ref_with_bikes$bikesready = sorted$bikesready
  
  ## Diagnostics to be printed in title
  sum = sum(ref_with_bikes$bikesready) 
  
  ## Time math stripped from filename stamp
  z <- strptime(substr(csvfile,start=0,stop=14), "%Y%m%d%H%M%S")
  z <- z + 7200 ## +2hr change to Norway time from GMT
  
  p <- ggmap(oslomap)
  p <- p + ggtitle(paste("Oslo Bysykkel (bikeshare) Parked Bikes\n","Total Bikes Parked:",sum,"\n",z))
  p <- p + theme(plot.title=element_text(family="Helvetica", face="bold", size=20))
  p <- p + geom_point(data=ref_with_bikes, aes(x=long, y=lat),color="#CC0000",size=1)
  p <- p + geom_point(data=ref_with_bikes, aes(x=long, y=lat, color=bikesready),size=ref_with_bikes$bikesready)
  png(paste("png/", csvfile, ".png", sep=""), width=800, height=800)
  print(p <- p + scale_colour_gradient(limits=c(0, 30), low="black", high="lightblue"))
  dev.off()
}
p <- ggmap(oslomap)
p <- p + ggtitle(paste("Plant growth with\n","Total Bikes Parked:",sum))
p <- p + geom_point(data=ref_with_bikes, aes(x=long, y=lat, color=bikesready),size=ref_with_bikes$bikesready)

p

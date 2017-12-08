## this script converts the swiss coordinates of the ggswissmaps plotting map shp_df[["g1k15"]] to 
## latitude and longitude values, using an algorithm from 
## view-source:http://www.giangrandi.ch/soft/swissgrid/swissgrid.shtml and 
## the PDF found in /doc : ch1903wgs84_f.pdf

library(tidyverse)
library(ggswissmaps)

reduced_g1k15 <- shp_df[["g1k15"]] %>% select(order, long, lat, group, id, KTNR)

convert_long <- function(long){
        y_prime <- (long- 600000)/1000000
        lambda_prime <- 2.6779094 + (4.728982*y_prime) + (0.791484 * y_prime * x_prime) + 
                (0.1306*y_prime*x_prime^2) - (0.0436*y_prime^3)
        lambda = lambda_prime* (100/36)
        lambda
}

convert_lat <- function(lat){
        x_prime <-  (lat - 200000)/1000000
        phi_prime = 16.9023892 + (3.238272*x_prime) -(0.270978 * y_prime^2) - (0.002528 * x_prime^2) -
                (0.0447*(y_prime^2)*x_prime) - (0.0140*x_prime^3)
        phi = phi_prime*(100/36)
        phi
}

lat_coords<- sapply(reduced_g1k15$lat, convert_lat)
long_coords <- sapply(reduced_g1k15$long, convert_long)

reduced_g1k15$lat_coords <- lat_coords
reduced_g1k15$long_coords <- long_coords

readr::write_csv(reduced_g1k15, "../data/clean_data/shpdfg1k15_adjustedcoords.csv")

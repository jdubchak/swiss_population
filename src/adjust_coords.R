#!/usr/bin/env Rscript

## Jordan Dubchak, Dec 2017

## this script converts the swiss coordinates of the ggswissmaps plotting map shp_df[["g1k15"]] to
## latitude and longitude values, using an algorithm from
## view-source:http://www.giangrandi.ch/soft/swissgrid/swissgrid.shtml and
## the PDF found in /doc : ch1903wgs84_f.pdf

packrat::restore()

suppressMessages({
  library(tidyverse, quietly = TRUE)
  library(ggswissmaps, quietly = TRUE)
})

 args <- commandArgs(trailingOnly = TRUE)
 output_path <- args[1]

 reduced_g1k15 <- shp_df[["g1k15"]] %>% select(order, long, lat, group, id, KTNR)

 convert_long <- function(lat, long = reduced_g1k15$long){
         y_prime <- (long- 600000)/1000000
         x_prime <-  (lat - 200000)/1000000
         lambda_prime <- 2.6779094 + (4.728982*y_prime) + (0.791484 * y_prime * x_prime) +
                 (0.1306*y_prime*x_prime^2) - (0.0436*y_prime^3)
         lambda = lambda_prime* (100/36)
         lambda
 }

 convert_lat <- function(lat, long = reduced_g1k15$long){
         y_prime <- (long- 600000)/1000000
         x_prime <-  (lat - 200000)/1000000
         phi_prime = 16.9023892 + (3.238272*x_prime) -(0.270978 * y_prime^2) - (0.002528 * x_prime^2) -
                 (0.0447*(y_prime^2)*x_prime) - (0.0140*x_prime^3)
         phi = phi_prime*(100/36)
         phi
 }

 lat_coords<- sapply(reduced_g1k15$lat, convert_lat)
 long_coords <- sapply(reduced_g1k15$lat, convert_long)

 reduced_g1k15$lat_coords <- lat_coords
 reduced_g1k15$long_coords <- long_coords

 ## input: "../data/clean_data/shpdfg1k15_adjustedcoords.csv"
 readr::write_csv(reduced_g1k15, output_path)

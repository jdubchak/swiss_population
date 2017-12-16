## JD Dec 2017 
## this script generates all visualizations for milestone 2 

library(ggplot2)
library(ggswissmaps)
library(tidyverse)
library(ggplot2)

#print("very start of file")

args <- commandArgs(trailingOnly = TRUE)
nonperm_all_in <- args[1] ## "../data/clean_data/reduced_g1k15_canton_nonperm_canadians.csv"
nonperm_all_out <- args[2] ## "../results/nonperm_Canadian_percentages_by_canton_w5large_text.png"

perm_all_in <- args[3] ## "../data/clean_data/reduced_g1k15_canton_perm_canadians.csv"
perm_all_out <- args[4] ## "../results/perm_Canadian_percentages_by_canton_w5large_text.png"

nonperm_can_in <- args[5] ## "../data/clean_data/reduced_g1k15_canton_nonperm_canadians_total.csv"
nonperm_can_out <- args[6] ## "../results/nonperm_all_Canadians_by_canton_w5large_text.png"

perm_can_in <- args[7] ## "../data/clean_data/reduced_g1k15_canton_perm_canadians_total.csv"
perm_can_out <- args[8] ## "../results/perm_all_canadians_by_canton_w5large_text.png"


## specify all lat/longs for plotting of the 5 major cities 
large_cities <- c("Zurich", "Geneva", "Basel", "Lausanne", "Bern")
lat_coords <- c(247926, 117821, 267665, 152363, 199657)
long_coords <- c(683304, 500016, 611288, 538125, 600667)
large_cities_df <- data_frame(large_cities, lat_coords, long_coords)

print("before read in 1")

## Percentage of all non permanent residents who were born in Canada 
canton_nonperm_Canadians_bornabroad <- readr::read_csv(nonperm_all_in)
colnames(canton_nonperm_Canadians_bornabroad)[11:12] <- c("Percent", "Proportion")

neuchatel_mean_latlong <- canton_nonperm_Canadians_bornabroad %>% 
  filter(cantons == 'Neuchatel') %>% 
  summarize(max_lat = max(lat), max_long = max(long))

nonperm_Canadian_percentages_by_canton <- ggplot(canton_nonperm_Canadians_bornabroad, aes(x=long, y=lat, group=group)) +
  geom_path(colour="red") +
  geom_polygon(aes(fill=Proportion), colour="red") +
  scale_fill_gradient(low="white", high="red") +
  labs(title= "Percentage of All Non Permanent Residents Living in Switzerland Who Were Born in Canada") +
  theme_minimal() +
  theme_white_f() +
  theme(plot.title = element_text(hjust = 0.65)) +
  guides(fill=guide_legend(title="Percentage of all\nNon Permanent\nResidents")) 

nonperm_Canadian_percentages_by_canton_w5large <- nonperm_Canadian_percentages_by_canton + geom_point(data=large_cities_df, aes(long_coords[1], lat_coords[1], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[2], lat_coords[2], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[3], lat_coords[3], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[4], lat_coords[4], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[5], lat_coords[5], group=large_cities)) 

nonperm_Canadian_percentages_by_canton_w5large_text <- nonperm_Canadian_percentages_by_canton_w5large + annotate("text", x=large_cities_df$long_coords[1]+8000, y =large_cities_df$lat_coords[1],
                                                          label=large_cities_df$large_cities[1]) +
  annotate("text", x=large_cities_df$long_coords[2]+11000, y =large_cities_df$lat_coords[2],
           label=large_cities_df$large_cities[2]) +
  annotate("text", x=large_cities_df$long_coords[3]+8000, y =large_cities_df$lat_coords[3],
           label=large_cities_df$large_cities[3]) +
  annotate("text", x=large_cities_df$long_coords[4]+12000, y =large_cities_df$lat_coords[4],
           label=large_cities_df$large_cities[4]) +
  annotate("text", x=large_cities_df$long_coords[5]+8000, y =large_cities_df$lat_coords[5],
           label=large_cities_df$large_cities[5]) 

nonperm_Canadian_percentages_by_canton_w5large_text2 <- nonperm_Canadian_percentages_by_canton_w5large_text +
  annotate("text", x=neuchatel_mean_latlong$max_long-50000, y=neuchatel_mean_latlong$max_lat-10000, 
         label="Canton of\nNeuchatel 0.049%") 

ggsave(plot = nonperm_Canadian_percentages_by_canton_w5large_text2, "/results/nonperm_Canadian_percentages_by_canton_annotated.png", width = 14, height = 7)
ggsave(plot = nonperm_Canadian_percentages_by_canton_w5large_text, nonperm_all_out, width = 14, height = 7)

print("about to read in 2")

## Percentage of all permanent residents of Switzerland born in Canada 
canton_perm_Canadians_bornabroad <- readr::read_csv(perm_all_in)
colnames(canton_perm_Canadians_bornabroad)[11:12] <- c("Percent", "Proportion")

geneva_stats <- canton_perm_Canadians_bornabroad %>% 
  filter(cantons=="Geneve") %>% 
  summarize(percent=max(Percent), max_lat = max(lat), max_long = max(long))

vaud_stats <- canton_perm_Canadians_bornabroad %>% 
  filter(cantons=="Vaud") %>% 
  summarize(percent=max(Percent), mean_lat = mean(lat), mean_long = mean(long))

perm_Canadian_percentages_by_canton <- ggplot(canton_perm_Canadians_bornabroad, aes(x=long, y=lat, group=group)) +
  geom_path() +
  geom_polygon(aes(fill=Percent), colour="red") +
  scale_fill_gradient(low="white", high="red") +
  labs(title= "Percentage of All Permanent Residents Living in Switzerland Who Were Born in Canada") +
  theme_minimal() +
  theme_white_f() +
  theme(plot.title = element_text(hjust = 0.65)) +
  guides(fill=guide_legend(title="Percentage of all\nPermanent\nResidents")) 

perm_Canadian_percentages_by_canton_w5large <- perm_Canadian_percentages_by_canton + geom_point(data=large_cities_df, aes(long_coords[1], lat_coords[1], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[2], lat_coords[2], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[3], lat_coords[3], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[4], lat_coords[4], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[5], lat_coords[5], group=large_cities)) 

perm_Canadian_percentages_by_canton_w5large_text <- perm_Canadian_percentages_by_canton_w5large + annotate("text", x=large_cities_df$long_coords[1]+8000, y =large_cities_df$lat_coords[1],
                                                                                                                 label=large_cities_df$large_cities[1]) +
  annotate("text", x=large_cities_df$long_coords[2]+11000, y =large_cities_df$lat_coords[2],
           label=large_cities_df$large_cities[2]) +
  annotate("text", x=large_cities_df$long_coords[3]+8000, y =large_cities_df$lat_coords[3],
           label=large_cities_df$large_cities[3]) +
  annotate("text", x=large_cities_df$long_coords[4]+12000, y =large_cities_df$lat_coords[4],
           label=large_cities_df$large_cities[4]) +
  annotate("text", x=large_cities_df$long_coords[5]+8000, y =large_cities_df$lat_coords[5],
           label=large_cities_df$large_cities[5]) 

perm_Canadian_percentages_by_canton_w5large_text2 <- perm_Canadian_percentages_by_canton_w5large_text + 
  annotate("text", x=geneva_stats$max_long-19000, y=geneva_stats$max_lat-31000, label="Canton of\nGeneva 0.546%") +
  annotate("text", x=vaud_stats$mean_long-20000, y=vaud_stats$mean_lat, label="Canton of\nVaud 0.565%") 


ggsave(plot = perm_Canadian_percentages_by_canton_w5large_text2, "/results/perm_Canadian_percentages_by_canton_annotated.png", width = 14, height = 7)
ggsave(plot = perm_Canadian_percentages_by_canton_w5large_text, perm_all_out, width = 14, height = 7)

print("read in 3")

## Percentage Canadian non permanent residents per canton  
Canadians_per_canton_nonperm <- readr::read_csv(nonperm_can_in)
colnames(Canadians_per_canton_nonperm)[11:12] <- c("Percent", "Proportion")

zurich_stats <- Canadians_per_canton_nonperm %>% 
  filter(cantons=="Zurich") %>% 
  summarize(percent=max(Percent), max_lat = mean(lat), max_long = mean(long))

nonperm_Canadian_percentages_by_canton <- ggplot(Canadians_per_canton_nonperm, aes(x=long, y=lat, group=group)) +
  geom_path(colour="red") +
  geom_polygon(aes(fill=Percent), colour="red") +
  scale_fill_gradient(low="white", high="red") +
  labs(title= "Percentage of Canadian Non Permanent Residents in Switzerland by Canton ") +
  theme_minimal() +
  theme_white_f() +
  theme(plot.title = element_text(hjust = 0.65)) +
  guides(fill=guide_legend(title="Percentage of all\nCanadian\nNon Permanent\nResidents")) 

nonperm_Canadian_percentages_by_canton_w5large <- nonperm_Canadian_percentages_by_canton + geom_point(data=large_cities_df, aes(long_coords[1], lat_coords[1], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[2], lat_coords[2], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[3], lat_coords[3], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[4], lat_coords[4], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[5], lat_coords[5], group=large_cities)) 

nonperm_Canadian_percentages_by_canton_w5large_text <- nonperm_Canadian_percentages_by_canton_w5large + annotate("text", x=large_cities_df$long_coords[1]+8000, y =large_cities_df$lat_coords[1],
                                                                                                                 label=large_cities_df$large_cities[1]) +
  annotate("text", x=large_cities_df$long_coords[2]+11000, y =large_cities_df$lat_coords[2],
           label=large_cities_df$large_cities[2]) +
  annotate("text", x=large_cities_df$long_coords[3]+8000, y =large_cities_df$lat_coords[3],
           label=large_cities_df$large_cities[3]) +
  annotate("text", x=large_cities_df$long_coords[4]+12000, y =large_cities_df$lat_coords[4],
           label=large_cities_df$large_cities[4]) +
  annotate("text", x=large_cities_df$long_coords[5]+8000, y =large_cities_df$lat_coords[5],
           label=large_cities_df$large_cities[5]) 

nonperm_Canadian_percentages_by_canton_w5large_text2 <- nonperm_Canadian_percentages_by_canton_w5large_text +
  annotate("text", x=zurich_stats$max_long, y=zurich_stats$max_lat+5000, 
           label="Canton of\nZurich 21.22%") +
  annotate("text", x=vaud_stats$mean_long-20000, y=vaud_stats$mean_lat, 
           label="Canton of\nVaud 22.65%") 
  

ggsave(plot = nonperm_Canadian_percentages_by_canton_w5large_text2, "/results/nonperm_all_Canadians_by_canton_annotated.png", width = 14, height = 7)
ggsave(plot = nonperm_Canadian_percentages_by_canton_w5large_text, nonperm_can_out, width = 14, height = 7)

print("read in 4")

## Percentage Canadian permanent residents per canton  
Canadians_per_canton_perm <- readr::read_csv(perm_can_in)
colnames(Canadians_per_canton_perm)[11:12] <- c("Percent", "Proportion")

zurich_stats <- Canadians_per_canton_perm %>% 
  filter(cantons=="Zurich") %>% 
  summarize(percent=max(Percent), max_lat = mean(lat), max_long = mean(long))

vaud_stats2 <- Canadians_per_canton_perm %>% 
  filter(cantons=="Vaud") %>% 
  summarize(percent=max(Percent), max_lat = mean(lat), max_long = mean(long))

geneva_stats2 <- Canadians_per_canton_perm %>% 
  filter(cantons=="Geneve") %>% 
  summarize(percent=max(Percent), max_lat = mean(lat), max_long = mean(long))


perm_Canadian_percentages_by_canton <- ggplot(Canadians_per_canton_perm, aes(x=long, y=lat, group=group)) +
  geom_path(colour="red") +
  geom_polygon(aes(fill=Percent), colour="red") +
  scale_fill_gradient(low="white", high="red") +
  labs(title= "Percentage of Canadian Permanent Residents in Switzerland by Canton ") +
  guides(fill=guide_legend(title="Percentage of all\nCanadian\nPermanent\nResidents")) +
  theme_minimal() +
  theme_white_f() +
  theme(plot.title = element_text(hjust = 0.65)) 

perm_Canadian_percentages_by_canton_w5large <- perm_Canadian_percentages_by_canton + geom_point(data=large_cities_df, aes(long_coords[1], lat_coords[1], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[2], lat_coords[2], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[3], lat_coords[3], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[4], lat_coords[4], group=large_cities)) +
  geom_point(data=large_cities_df, aes(long_coords[5], lat_coords[5], group=large_cities)) 

perm_Canadian_percentages_by_canton_w5large_text <- perm_Canadian_percentages_by_canton_w5large + annotate("text", x=large_cities_df$long_coords[1]+8000, y =large_cities_df$lat_coords[1],
                                                                                                                 label=large_cities_df$large_cities[1]) +
  annotate("text", x=large_cities_df$long_coords[2]+11000, y =large_cities_df$lat_coords[2],
           label=large_cities_df$large_cities[2]) +
  annotate("text", x=large_cities_df$long_coords[3]+8000, y =large_cities_df$lat_coords[3],
           label=large_cities_df$large_cities[3]) +
  annotate("text", x=large_cities_df$long_coords[4]+12000, y =large_cities_df$lat_coords[4],
           label=large_cities_df$large_cities[4]) +
  annotate("text", x=large_cities_df$long_coords[5]+8000, y =large_cities_df$lat_coords[5],
           label=large_cities_df$large_cities[5]) 

perm_Canadian_percentages_by_canton_w5large_text2 <- perm_Canadian_percentages_by_canton_w5large_text +
  annotate("text", x=zurich_stats$max_long, y=zurich_stats$max_lat+5000, 
           label="Canton of\nZurich 15.48%") +
  annotate("text", x=vaud_stats2$max_long-20000, y=vaud_stats2$max_lat, 
           label="Canton of\nVaud 28.56%") +
  annotate("text", x=geneva_stats2$max_long-2000, y=geneva_stats2$max_lat-20000, 
           label="Canton of\nGeneva 21.72%")

ggsave(plot = perm_Canadian_percentages_by_canton_w5large_text2, "/results/perm_all_canadians_by_canton_annotated.png", width = 14, height = 7)
ggsave(plot = perm_Canadian_percentages_by_canton_w5large_text, perm_can_out, width = 14, height = 7)


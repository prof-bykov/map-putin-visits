# How to make maps in R & RStudio
# Countries visited by Putin as President or Prime-Minister in 1999-2024
# Author: ILYA BYKOV https://prof-bykov.blogspot.com/ 
# Based on Felix Analityx https://youtu.be/FoqiFR5ZCic?si=Rj0jPvs1eF_tMYSJ 

# Part 1. Preparing

# Install R packages if necessary 
install.packages("sf", dependencies = TRUE) # sf is Simple Features for geographical data
install.packages("tidyverse", dependencies = TRUE) # packages like ggplot2, dplyr, stringr, etc.
install.packages("rnaturalearth", dependencies = TRUE) # world data from from Natural Earth
install.packages("countrycode", dependencies = TRUE) # ISO codes for countries
install.packages("ggrepel", dependencies = TRUE) # extension for ggplot2 to overlap text labels  

# Load R packages 
library("sf")
library("tidyverse")
library("rnaturalearth")
library("countrycode")
library("ggrepel")

# Part 2. Preparubg map

# Get world data
world <- ne_countries(scale = "small", returnclass = "sf") 
# ne_countries contains the data from rnaturalearth package 
# small is for minimizing variables
# returnclass is for simple features

# Check world data if necessary 
view(world)

# Simple world map
world %>%
  ggplot() +
  geom_sf()

# How to change map projection 
# List of projections: https://proj.org/operations/projections/ 
world %>%
  st_transform(crs = "+proj=robin") %>% 
  ggplot() +
  geom_sf() +
  theme_minimal()
# crs is Coordinate Reference System  
# +proj=robin is Robinson projection

# Mercator projection (example) 
world %>%
  st_transform(crs = "+proj=merc") %>% 
  ggplot() +
  geom_sf() +
  theme_minimal()

# Wintri projection (example) 
world %>%
  st_transform(crs = "+proj=wintri") %>% 
  ggplot() +
  geom_sf() +
  theme_minimal()

# Wintri projection (corrected) 
world %>%
  st_transform(crs = "+proj=wintri") %>% 
  ggplot() +
  geom_sf() +
  coord_sf(datum = NA) + # No graticule
  theme_minimal()

# Basic map of the World
world %>%
  st_transform(crs = "+proj=robin") %>% 
  ggplot() +
  geom_sf() +
  theme_minimal()

# Preparing data

# Check working directory
getwd()

# Get data
data_raw <- read.csv("C:/Users/user/Documents/putin_visits.csv")
# Available at ...  
# Based on https://en.wikipedia.org/wiki/List_of_international_presidential_trips_made_by_Vladimir_Putin
# Based on https://en.wikipedia.org/wiki/List_of_international_prime_ministerial_trips_made_by_Vladimir_Putin 

# Check visits data if necessary 
View(data_raw)

# Simple map of visits
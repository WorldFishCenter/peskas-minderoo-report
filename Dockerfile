FROM rocker/geospatial:4.0.3

# Extra R packages
RUN install2.r targets here janitor skimr brms ggdist inspectdf tarchetypes

RUN install2.r --error --skipinstalled \
  googleCloudStorageR config ggdist ggtext

# Rstudio interface preferences
COPY rstudio-prefs.json /home/rstudio/.config/rstudio/rstudio-prefs.json

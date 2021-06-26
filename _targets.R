# Prepare workspace -------------------------------------------------------

library(targets)
library(tarchetypes)

# load functions
f <- lapply(list.files(path = here::here("R"), full.names = TRUE,
                       include.dirs = TRUE, pattern = "*.R"), source)

# Authenticate
googleCloudStorageR::gcs_auth(json_file = "auth/gcp-sa-peskas_ingestion-key.json")

# Read configuration
config <- config::get()

# Load files --------------------------------------------------------------

load_files <- list(
  tar_target(
    name = landings,
    command = read_rds_gc(config$landings, config$bucket_name)
  ),
  tar_target(
     name = pds_trips,
     command = read_csv_gc(config$pds_trips, config$bucket_name)
  ),
  tar_target(
    name = sites_url,
    command = readLines("auth/sites-url")#peskdat sites-sheet gdrive url
  ),
  tar_target(
    name = species_url,
    command = readLines("auth/species-url")#peskdat species-sheet gdrive url
  ))

# Generate report ---------------------------------------------------------

gen_report <- list(
  tar_render(
    name = report,
    path = "reports/minderoo_figures.Rmd",
    output_format = 'all'
  )
)
# Plan analysis ------------------------------------------------------------

list(
  load_files,
  gen_report
)


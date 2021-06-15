# Prepare workspace -------------------------------------------------------

library(targets)

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
  )
)

# Plan analysis ------------------------------------------------------------

list(
  load_files
)


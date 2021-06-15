read_csv_gc <- function(object_name, bucket){
  path <- tempfile()
  on.exit(file.remove(path))

  googleCloudStorageR::gcs_get_object(
    object_name = object_name,
    bucket = bucket,
    saveToDisk = path,
    overwrite = TRUE
  )

  readr::read_csv(path, col_types = readr::cols(.default = readr::col_character()))
}

read_rds_gc <- function(object_name, bucket){
  path <- tempfile()
  on.exit(file.remove(path))

  googleCloudStorageR::gcs_get_object(
    object_name = object_name,
    bucket = bucket,
    saveToDisk = path,
    overwrite = TRUE
  )

  readr::read_rds(path)
}


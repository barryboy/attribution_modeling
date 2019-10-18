library(here)
library(stringr)
library(data.table)
library(googleCloudStorageR)

gcs_auth(here('AUTH/mcw-play-217608-68fe7c152472.json'))

gcs_global_bucket("play-automation")

gcs_prefix <- 'CJ/SEPTEMBER_2019_2/WIDE_DATASET'
files <- gcs_list_objects(prefix = gcs_prefix)

for (i in 2:nrow(files)) {
  gcs_get_object(paste0('gs://', gcs_get_global_bucket(), '/', files[i,'name']), saveToDisk = here('DATA', str_remove(files[i,'name'], gcs_prefix)))
  }

local_files <- list.files(here('DATA'), full.names = T)

dfs <- lapply(local_files, data.table::fread)
df <- rbindlist( dfs )

rm(dfs,files, gcs_prefix, i, local_files)

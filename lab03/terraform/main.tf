resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.dataset_id
  friendly_name               = "Lab 03 Dataset"
  description                 = "Dataset creado para el Laboratorio 3 del Curso de BigQuery"
  location                    = "US"
  default_table_expiration_ms = 3600000 # Las tablas temporales expiran en 1 hora para evitar costes no deseados
}

resource "google_storage_bucket" "gcs_bucket" {
  name          = var.bucket_name
  location      = "US"
  force_destroy = true # Permite destruir el bucket con archivos dentro al ejecutar 'terraf'

# Esta línea es importante para habilitar el acceso uniforme a nivel de bucket y evitar problemas de permisos con los objetos dentro del bucket.
  uniform_bucket_level_access = true
  # Regla de ciclo de vida para eliminar archivos antiguos y evitar costes
  lifecycle_rule {
    condition {
      age = 30 # Días
    }
    action {
      type = "Delete"
    }
  }
}


# Definición de la Tabla Externa en BigQuery
resource "google_bigquery_table" "external_web_logs" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "external_web_logs"

  external_data_configuration {
    autodetect    = true
    source_format = "CSV"

    source_uris = ["gs://${google_storage_bucket.gcs_bucket.name}/raw/web_logs/*.csv"]

    csv_options {
      quote             = "\""
      skip_leading_rows = 1
    }
  }
}

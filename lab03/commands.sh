gcloud storage cp ../data/web_logs.csv gs://curso-gcp-bigquery-bq-external-tables-bucket/raw/web_logs/web_logs.csv

bq query --use_legacy_sql=false "SELECT request_method, COUNT(*) AS tot_req, AVG(bytes_sent) AS avg_byt_sent FROM `lab03_dataset.external_web_logs` GROUP BY request_method"
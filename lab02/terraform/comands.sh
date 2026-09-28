gcloud storage cp ../data/products.json gs://ericbigquery-bq-batch-ingestion-bucket/raw/products/products.json
bq load  --source_format=CSV  --skip_leading_rows=1  --schema=../schemas/ecommerce_users_schema.json  lab02_dataset.users  gs://ericbigquery-bq-batch-ingestion-bucket/raw/users/ecommerce_users.csv

gcloud storage cp ../data/ecommerce_users.csv gs://ericbigquery-bq-batch-ingestion-bucket/raw/users/ecommerce_users.csv
bq load  --source_format=NEWLINE_DELIMITED_JSON  --autodetect  lab02_dataset.products  gs://ericbigquery-bq-batch-ingestion-bucket/raw/products/products.json


bq query --use_legacy_sql=false "SELECT * FROM `lab02_dataset.users` LIMIT 10"
bq query --use_legacy_sql=false "SELECT * FROM `lab02_dataset.products` where price > 26"
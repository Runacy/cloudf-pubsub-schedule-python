
args=-v
name=
dev:
	docker-compose up --build -d


# 初期設定
## gcloud init
# Pub/Sub サブスクリプションを作成します。これは、ジョブの結果を表示するために必要です。
## https://cloud.google.com/scheduler/docs/schedule-run-cron-job
## gcloud pubsub subscriptions create cron-sub --topic cron-topic
# cron jobのpub/subターゲットの指定(例)
## gcloud scheduler jobs create pubsub myjob --schedule "*/5 * * * *" --topic cron-topic --message-body "Hello"

# secret manager 
# gcloud secrets create <secret-id> \
#     --replication-policy="automatic"
# gcloud secrets create web_alpha_env --data-file=".alpha.env" --locations=us-central1 --replication-policy="user-managed"
# gcloud alpha pubsub subscriptions delete
gcloud:
	docker exec -it  gcloud bash -c "gcloud ${args}"

gcloud-secret:
	docker exec -it  gcloud bash -c "gcloud secrets create ${name} --data-file='/app/src/.env' --replication-policy='automatic'"


gcloud-deploy:
	sh ./scripts/deploy.sh ${name}
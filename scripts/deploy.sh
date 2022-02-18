#!/bin/bash

if [ $# -ne 1 ]; then
    echo "引数を見直してください。"
    exit 1
fi

if [ -z $1 ]; then
    echo "topicが空です。"
    exit 1
fi

TOPIC=$1-topic

# 一度 delete
docker exec -it  gcloud bash -c "gcloud scheduler jobs delete ${TOPIC}-job --location=asia-northeast1"
docker exec -it  gcloud bash -c "gcloud alpha pubsub subscriptions delete cron-sub"
docker exec -it  gcloud bash -c "gcloud pubsub topics delete ${TOPIC}"
docker exec -it  gcloud bash -c "gcloud functions delete main"

set -eu
docker exec -it  cloudf-pubsub-schedule-python-app bash -c "cd /application/src/ && poetry export -f requirements.txt -o requirements.txt"
sed -i "" "s/<TOPIC_NAME>/${TOPIC}/g" cloudbuild.yaml
docker exec -it  gcloud bash -c "gcloud builds submit --config /app/cloudbuild.yaml /app/src/"
docker exec -it  gcloud bash -c "gcloud pubsub subscriptions create cron-sub --topic ${TOPIC}"
docker exec -it  gcloud bash -c "gcloud scheduler jobs create pubsub ${TOPIC}-job --location=asia-northeast1 --schedule=\"0 0 * * 1\" --topic=\"${TOPIC}\" --message-body=\"{}\""
sed -i "" "s/${TOPIC}/<TOPIC_NAME>/g" cloudbuild.yaml
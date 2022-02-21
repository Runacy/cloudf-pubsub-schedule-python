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


docker exec -it  gcloud bash -c "gcloud beta scheduler jobs --location=asia-northeast1 delete ${TOPIC}-job"

sed -i "" "s/<TOPIC_NAME>/${TOPIC}/g" cloudbuild.yaml
docker exec -it  gcloud bash -c "gcloud builds submit --config /app/cloudbuild.yaml /app/src/"
docker exec -it  gcloud bash -c "gcloud pubsub subscriptions create cron-sub --topic ${TOPIC}"
docker exec -it  gcloud bash -c "gcloud scheduler jobs create pubsub ${TOPIC}-job --location=asia-northeast1 --schedule=\"0 0 * * 1\" --topic=\"${TOPIC}\" --message-body=\"{}\""
sed -i "" "s/${TOPIC}/<TOPIC_NAME>/g" cloudbuild.yaml
dev:
	docker-compose up --build -d

ARG=-v
gcloud:
	docker exec -it  gcloud bash -c "gcloud ${ARG}"

gcloud-build:
	docker exec -it  gcloud bash -c "gcloud builds submit --config /app/cloudbuild.yaml /app/src/"

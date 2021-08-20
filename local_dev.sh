#!/bin/zsh


docker compose -f docker-compose-oracle.yml pull
mkdir ../oradata
docker compose -f docker-compose.yml -p local_opt_debug up --build --timeout 60 --detach

sleep 3

while :
do
  DBT_CONTAINER=$(docker ps | grep "local_opt_debug_dbt" | cut -d' ' -f1)
  if [ -z "${DBT_CONTAINER}" ]; then
      echo "waiting for the containers...";
      sleep 3
  else
      break;
  fi
done

echo "Running: docker exec -it ${DBT_CONTAINER} /bin/bash"
docker exec -it ${DBT_CONTAINER} /bin/bash

# todo: wrap in trap statment?
docker compose -p local_opt_debug down
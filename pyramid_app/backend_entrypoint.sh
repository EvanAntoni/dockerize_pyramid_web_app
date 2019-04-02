#!/bin/bash

host="db"

while true
do
   ping -c 5 "$host"
   db_connection=$?
   migrations="$(find pyramid_app/alembic/versions/ -type f -name "*.py" | wc -l)"
   if [[ $db_connection == 0 ]]
   then
       if [[ $migrations == 0 ]]
       then
           echo "Postgres is up - executing commands"

           alembic -c development.ini revision --autogenerate -m "init" && \
           alembic -c development.ini upgrade head && \
           initialize_pyramid_app_db development.ini
       fi
      break
   fi
   echo "Postgres is unavailable - sleeping 5 sec"
   sleep 5
done

exec $@
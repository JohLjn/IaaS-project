[http://51.120.119.137/](http://51.120.119.137/)

IP: 51.120.119.137

För att kunna nyttja init.sql, kör i följande ordning:

1. Stå i root-mappen (Infrastructure) och flytta över filen till databas-containern
   genom docker cp och placera den i /var/lib/postgresql/data

docker compose cp init.sql database:/var/lib/postgresql/data

2. Starta upp psql inuti containern genom docker exec och använd -it för att kunna
   arbeta inuti Postgres

winpty docker compose exec -it database psql -U postgres

3. Slutligen, använd \i för att kunna exekverera SQL-kod från en extern SQL-fil
   (Den som importerades i steg 1)

\i /var/lib/postgresql/data/init.sql

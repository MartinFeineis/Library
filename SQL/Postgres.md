# SQL with Postgres
## Installing postgres
```sh
sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql
```

## Find all Users and there rights/roles
```sql
SELECT u.usename AS "Role name",
  CASE WHEN u.usesuper AND u.usecreatedb THEN CAST('superuser, create
database' AS pg_catalog.text)
       WHEN u.usesuper THEN CAST('superuser' AS pg_catalog.text)
       WHEN u.usecreatedb THEN CAST('create database' AS
pg_catalog.text)
       ELSE CAST('' AS pg_catalog.text)
  END AS "Attributes"
FROM pg_catalog.pg_user u
ORDER BY 1;
```


This has to go into a Postgres Section
```
SELECT relname, A.attname FROM pg_class C, pg_namespace N, pg_attribute A, 
pg_type T WHERE (C.relkind=`r') AND (N.old=C.relnamespace) AND 
(A.attrelid=C.old) AND (A.atttypid=T.old) AND (A.attnum>0) AND (NOT A.attisdropped) AND (N.nspname ILIKE `public');
```

# SQL with Postgres
## Installing postgres
```sh
sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql
```
check if server is running
```sh
systemctl status postgresql
```
## First Steps
Log into the database with `sudo -u postgres psql`
create new table and user for that table
```
CREATE TABLE table_data (
  first_column VARCHAR(255) NOT NULL,
  some_number INT,
  second_column VARCHAR(255) NOT NULL,
  a_boolean BOOLEAN DEFAULT FALSE
);
CREATE USER table_user WITH PASSWORD 'user-password';
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

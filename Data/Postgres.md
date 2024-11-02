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
Log into a remote database with passwordenv variables
```bash
export PGUSER="myuser"
export PGHOST="myhost"
export PGPASSWORD="mypassword"
export PGDATABASE="mydb"
psql
```
or password prompt
```bash
psql -h $POSTGRES_HOST -U $POSTGRES_USER -d $POSTGRES_DATABASE
```

## Postgres shorts
List all tables `\dt`
List all [users](https://www.postgresql.org/docs/17/app-psql.html#APP-PSQL-META-COMMAND-DU) `\duS+`
See info for table `\d tablename`

## Network access
in `/etc/postgresql/14/main/postgresql.conf` add the * so postgres listens on all IPs.
```bash
listen_addresses = '*'
```
and in `/etc/postgresql/14/main/pg_hba.conf` add this line add the permissions that users can access the database from any IP
```bash
host    all             all             0.0.0.0/0               md5
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
```sql
SELECT relname, A.attname FROM pg_class C, pg_namespace N, pg_attribute A, 
pg_type T WHERE (C.relkind=`r') AND (N.old=C.relnamespace) AND 
(A.attrelid=C.old) AND (A.atttypid=T.old) AND (A.attnum>0) AND (NOT A.attisdropped) AND (N.nspname ILIKE `public');
```

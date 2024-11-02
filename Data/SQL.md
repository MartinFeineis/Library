# SQL Statements
## Creating a user
Create a user a give access to `tablename`
```sql
CREATE USER app_user WITH PASSWORD 'password';
GRANT SELECT, INSERT, UPDATE, DELETE ON tablename TO app_user;
GRANT USAGE, SELECT ON SEQUENCE tablename_id_seq TO app_user;
GRANT UPDATE ON SEQUENCE tablename_id_seq TO app_user;
```

## Insert Data
create Table
```sql
CREATE TABLE sw_comics (
  Band smallint NOT NULL,
  Title VARCHAR(255),
  Notes VARCHAR(255),
  Owned BOOLEAN DEFAULT FALSE,
  Wishlist BOOLEAN DEFAULT FALSE
);
```
Insert into table (no space between table name and columns)
```sql
INSERT INTO sw_comics(Band, Title, Notes, Owned, Wishlist)
VALUES
  ('10', 'Dark Times - Blutige Ernte', 'Checkout Kurosawas \"Yojimbo - Der Leibwaechter\" and \"Dir verborgene Festung\"', 'true', 'false'),
  ('28', 'Blutsband II: Boba Fett ist tot', 'kein toller Zeichenstil', 'true','false'),
  ('35', 'Crimson Empire II - Das Blutsgericht', 'Nom Anor tritt auf, schoener Zeichenstil','true','false');
```

create new table and user for that table
```sql
CREATE TABLE table_data (
  first_column VARCHAR(255) NOT NULL,
  some_number INT,
  second_column VARCHAR(255) NOT NULL,
  a_boolean BOOLEAN DEFAULT FALSE
);
CREATE USER table_user WITH PASSWORD 'user-password';
```
# Add column to table
add column deletedBefore with timezone aware timestamp
```sql
ALTER TABLE directory_info
ALTER COLUMN deletedBefore TYPE TIMESTAMP WITH TIME ZONE;
```
Verify changes where made
```sql
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'directory_info' AND column_name = 'deletedbefore';
```
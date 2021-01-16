# Script Library Repo
[gitbook.io Link](https://martinfeineis.gitbook.io/newlib/)  
[github Link](https://github.com/MartinFeineis/Library)
This is where I put scripts, commands and code snippets of importance to me to grant myself super human memory.

Feel free to browse...

## Things to check out
[LineageOS](https://www.howtogeek.com/348545/how-to-install-lineageos-on-android/)  
[mkdocs](https://www.mkdocs.org/)

This has to go into a Postgres Section
```
SELECT relname, A.attname FROM pg_class C, pg_namespace N, pg_attribute A, 
pg_type T WHERE (C.relkind=`r') AND (N.old=C.relnamespace) AND 
(A.attrelid=C.old) AND (A.atttypid=T.old) AND (A.attnum>0) AND (NOT A.attisdropped) AND (N.nspname ILIKE `public');
```

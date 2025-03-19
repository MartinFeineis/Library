---
tags:
  - Data Bases
---

<!-- Load abbreviations -->
--8<-- ".abbreviations"

!!! Warning " "
    This document is a **WORK IN PROGRESS**.<br/>
    This is just a quick personal cheat sheet: treat its contents with caution!
---


# PostgreSQL

PostgreSQL is a free and open source RDBMS.

???+ Note "Reference(s)"
    * <https://wiki.gentoo.org/wiki/PostgreSQL>
    * <https://wiki.gentoo.org/wiki/PostgreSQL/QuickStart>
    * <https://wiki.archlinux.org/index.php/PostgreSQL>
    * <https://www.postgresql.org/docs/>
    * <https://www.postgresql.org/docs/current/tutorial.html>


---
## Table of contents

<!-- vim-markdown-toc GitLab -->

* [Install](#install)
* [Config](#config)
* [Use](#use)
    * [Major update procedure](#major-update-procedure)
    * [Minor update procedure](#minor-update-procedure)

<!-- vim-markdown-toc -->

---
## Install

!!! Note ""

    === "emerge"
        ```console
        # emerge -a dev-db/postgresql
        # emerge --config dev-db/postgresql
        ```

    === "pacman"
        **TODO**
        ```console
        # pacman -S postgresql
        ```

    === "apt"
        **TODO**
        ```console
        # apt install postgresql
        ```

    === "yum"
        **TODO**
        ```console
        # yum install postgresql
        ```

    === "dnf"
        ```console
        dnf install postgresql
        ```


---
## Config

> Main configuration files of PostgreSQL are located in `/etc/postgresql-x.x/`.

> Sample config files are available in `/usr/share/postgresql-x.x/`.

<br/>

Allow local identification to the `postgres` user without password in order to set one later on:

```console
# vi /etc/postgresql-x.x/pg_hba.conf
    > ...
    > # TYPE  DATABASE        USER            ADDRESS                 METHOD
    > # "local" is for Unix domain socket connections only
  ~ > local   all             all                                     trust
    > # IPv4 local connections:
    > host    all             all             127.0.0.1/32            password
    > # IPv6 local connections:
    > host    all             all             ::1/128                 password
    > # Allow replication connections from localhost, by a user with the
    > # replication privilege.
  ~ > local   replication     all                                     trust
    > host    replication     all             127.0.0.1/32            password
    > host    replication     all             ::1/128                 password
```

Start the PostgreSQL service:

!!! Note ""

    === "OpenRC"
        ```console
        # /etc/init.d/postgresql-x.x start
        ```

    === "Runit"
        ```console
        # sv up postgresql-x.x
        ```

    === "SysVinit"
        ```console
        # service postgresql-x.x start
        ```

    === "SystemD"
        ```console
        # systemctl start postgresql-x.x
        ```

Define the `postgres` password:
```console
# psql -U postgres
    > \password
    > ...
    > \q
```

Forbid local identification without password:

```console
# vi /etc/postgresql-x.x/pg_hba.conf
    > ...
    > # TYPE  DATABASE        USER            ADDRESS                 METHOD
    > # "local" is for Unix domain socket connections only
  ~ > local   all             all                                     password
    > # IPv4 local connections:
    > host    all             all             127.0.0.1/32            password
    > # IPv6 local connections:
    > host    all             all             ::1/128                 password
    > # Allow replication connections from localhost, by a user with the
    > # replication privilege.
  ~ > local   replication     all                                     password
    > host    replication     all             127.0.0.1/32            password
    > host    replication     all             ::1/128                 password
```

Restart the PostgreSQL service and add it to the init system:

!!! Note ""

    === "OpenRC"
        ```console
        # /etc/init.d/postgresql-x.x restart
        # rc-update add postgresql-x.x default
        ```

    === "Runit"
        ```console
        # sv restart postgresql-x.x
        # ln -s /etc/runit/sv/postgresql-x.x /run/runit/service/
        ```

    === "SysVinit"
        ```console
        # service postgresql-x.x restart
        # chkconfig postgresql-x.x on
        ```

    === "SystemD"
        ```console
        # systemctl restart postgresql-x.x
        # systemctl enable postgresql-x.x
        ```


---
## Use

* Use the `-d` option to connect to the database you created (without specifying a database, `psql`
  will try to access a database that matches your username).
```console
$ psql -d myDatabaseName
```

* Use the `-U` option to connect to a user (e.g. `postgres`):
```console
$ psql -U postgres
```

* `psql` command to get help:
```console
=> \help
```

* `psql` command to connect to a particular database:
```console
=> \c <database>
```

* `psql` command to list all users and their permission levels:
```console
=> \du
```

* `psql` command to show summary information about all tables in the current database:
```console
=> \dt
```

* `psql` command to exit/quit the `psql` shell:
```console
=> \q # or CTRL+d
```

* There are of course many more meta commands. To see all `psql` meta commands run:
```console
=> \?
```

### Major update procedure

For major versions only, e.g. from PostgreSQL 11 to 12:

* <https://www.kostolansky.sk/posts/upgrading-to-postgresql-12/>
* <https://wiki.gentoo.org/wiki/PostgreSQL/QuickStart#Migrating_PostgreSQL>

E.g.:
```console
$ pg_upgrade -U postgres \
> -d /var/lib/postgresql/11/data -D /var/lib/postgresql/12/data \
> -b /usr/lib64/postgresql-11/bin -B /usr/lib64/postgresql-12/bin
```

After an update, don't forget to add the new PostgreSQL version to the init system, and remove the
old one:

!!! Note ""

    === "OpenRC"
        ```console
        # rc-update add postgresql-y.y.new default
        # rc-update del postgresql-x.x.old default
        ```

    === "Runit"
        ```console
        # ln -s /etc/runit/sv/postgresql-y.y.new /run/runit/service/
        # unlink /run/runit/service/postgresql-x.x.old
        ```

    === "SysVinit"
        ```console
        # chkconfig postgresql-y.y.new on
        # chkconfig postgresql-x.x.old off
        ```

    === "SystemD"
        ```console
        # systemctl enable postgresql-y.y.new
        # systemctl disable postgresql-x.x.old
        ```

Check that your data bases are present:
```console
$ sudo -u postgres psql -c "\list"
```

**If a database is missing**, you can recover it (e.g. a Nextcloud database) this way:

!!! Note ""

    === "Gentoo"
        ```console
        # rc-service postgresql-12 stop
        # rc-service postgresql-11 start
        # eselect postgresql set 11
        $ sudo -u postgres psql --version
        $ cd /path/to/backup
        $ sudo -u postgres pg_dump nextcloud | sudo tee pg_dump_`date +"%Y%m%d"`
        
        # rc-service postgresql-11 stop
        # rc-service postgresql-12 start
        # eselect postgresql set 12
        $ sudo -u postgres psql --version
        $ sudo -u postgres psql nextcloud < pg_dump_20200314
        ```

Now the old version of PostgreSQL can safely be removed from the system:
```console
```

### Minor update procedure

TODO


---

!!! Star " "
    If this cheat sheet has been useful to you, then please consider leaving a star
    [here](https://gitlab.com/stephane.tzvetkov/cheatsheets/).


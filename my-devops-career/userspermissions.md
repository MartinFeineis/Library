# 7 Users and permissions

Learning and applying permissions (read,write,execute) and ownership (user,group) on Files.

## Owner and Groups

The command `ls` lists the files and directories in the current _working directory_. A sample output would look like this:

```
[vagrant@fedora30 ~]$ ls
MyDirectory  MyFile  MySecondFile.txt
```

The ls command has comes with many useful parameters. The most important one in my opinion are

* `-l` to list the files instead of table style
* `-a` to print all files. Filenames that start with a **.** like `.bashrc`
*   `-h` to print file size in humanreadable output

    A sample output can look like this:

    ```
    [vagrant@fedora30 ~]$ ls -lah
    total 20K
    drwx------. 4 vagrant vagrant 152 Oct 31 00:01 .
    drwxr-xr-x. 4 root    root     34 Oct 30 00:04 ..
    -rw-------. 1 vagrant vagrant 165 Oct 30 00:05 .bash_history
    -rw-r--r--. 1 vagrant vagrant  18 Feb 16  2019 .bash_logout
    -rw-r--r--. 1 vagrant vagrant 141 Feb 16  2019 .bash_profile
    -rw-r--r--. 1 vagrant vagrant 376 Feb 16  2019 .bashrc
    drwxrwxr-x. 2 vagrant vagrant   6 Oct 31 00:01 MyDirectory
    -rw-rw-r--. 1 vagrant vagrant  60 Oct 31 00:01 MyFile
    -rw-rw-r--. 1 vagrant vagrant   0 Oct 31 00:01 MySecondFile.txt
    drwx------. 2 vagrant vagrant  48 Oct 27 12:43 .ssh
    ```

    As you can see this shows way more information compared&#x20;

    with the first output. The first big row shows the permissions of

    the file and its type. More on this in a second.

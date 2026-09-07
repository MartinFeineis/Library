# 2 Package Manager

## apt Package Manager for Ubuntu, Debian and Linux Mint

To search for new Packages use, where the Packagename is  `apt search <packagename>`

## Installing a package

To install a package with  run `sudo apt install <packagename>` You need to confirm this with `Y` or run the command like `sudo apt -y install <packagename>` Besides `apt` there is also `apt-get`. The former one, `apt` is meant to be used for endusers. Many commands between `apt` and `apt-get` are similar.

## Uninstalling/removing a package

To uninstall a package run `sudo yum remove <packagename>`

## Showing package information

```bash
yum show <package>
```

## Lesson Tests

1. Install the package `bsdgames`.
2. Show the content of the `bsdgames` package.
3. Get the version of the `bsdgames` package.
4. Play one of the games.

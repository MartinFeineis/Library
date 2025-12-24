# Make

Make is a build tool, [docs](https://www.gnu.org/software/make/). Its main purpse
is compile/create/update file (targets), through commands/steps (rules) based on 
other files (dependencies). Rules need to be indented by `TAB`s in order for make to 
differentiate between _build commands_ and _make syntax_

```make
<target>: <dependcies>
    <rule>
```
e.g.
```make
name.txt: ncont.txt
    date >> name.txt
    cat ncont.txt >> name.txt
```

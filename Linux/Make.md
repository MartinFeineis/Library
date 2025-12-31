# Make

Make is a build tool, [docs](https://www.gnu.org/software/make/). Its main purpse
is compile/create/update file (targets), through commands/steps (rules) based on 
other files (dependencies). Rules need to be indented by `TAB`s in order for make to 
differentiate between _build commands_ and _make syntax_

```make
<target>: <dependcies>
    <rule>
```
e.g. Create the file/target `name.txt` write the date to it and any content from `ncont.txt`
```make
name.txt: ncont.txt
    date >> name.txt
    cat ncont.txt >> name.txt
```
## Multiple targets
Create multiple files from the same _rule/recipe_
With this filesystem: 
```sh
ls
1.be  2.be  3.be  Makefile  name.txt  ncont.txt
```
And this rule [Static Pattern Rules](https://www.gnu.org/software/make/manual/html_node/Static-Usage.html)
also [Pitfalls of Using Wildcards](https://www.gnu.org/software/make/manual/html_node/Wildcard-Pitfall.html)
```make
*.be: ncont.txt
    date >> $@
    echo "Wildcarding" >> $@
    cat ncont.txt >> $@
```
`*.be` will find all 3 files,
> [!Warning] 
> `$@` will only evaluate to the first target `1.be`
  
{% hint style="info" %}
Instead of `*` there is also `%` in make syntax
{% endhint %} 

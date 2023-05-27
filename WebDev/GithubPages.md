# Github Pages
Create repository name like `username.github.io` (martinfeineis.github.io)
The Url will be then `https://username.github.io` (https://martinfeineis.github.io/)

It will serve the `index.html` in the root of the repository

create a new nuxt project
in project/nuxt.config.ts add a target and router:
```
export default defineNuxtConfig({
    target: 'static',
    router: {
      base: '/MartinFeineis.github.io/'
    }
})
```
In your `package.json` add 
```
"generate": "nuxt generate && cp -r /workspaces/MartinFeineis.github.io/hmy-page/.output/public/* /workspaces/MartinFeineis.github.io/",
```
# Jeykyll
From [her](https://alex-alekseichuk.github.io/2020/06/10/nojekyll-file-to-host-nuxt-on-github/) place a file
name `.nojeykyll` in the root of the repository to avoid the `_nuxt` folder getting lost 
during building  

## removed practices
I stopped using push-dir and do my git management my own way.
~~~install `npm install --save-dev push-dir`  
in package.json in the scripts section add a deploy item:
```
"deploy": "push-dir --dir=dist --branch=gh-pages --cleanup"
```
~~~

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
install `npm install --save-dev push-dir` 
in package.json in the scripts section add a deploy item:
```
"deploy": "push-dir --dir=dist --branch=gh-pages --cleanup"
```
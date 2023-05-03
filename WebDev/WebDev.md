# Web Development

## NVM 
[nvm](https://github.com/nvm-sh/nvm/blob/master/README.md) is a node.js version manager like `pyenv`.
Install `nvm` and use it to install `node.js` and `npm`.

## Node.js
Install with one like the three below
```bash
nvm install node
nvm install v16.13.2
nvm install --lts
```
the first installs the latest version of `node`  
the second installs `node` version `v16.13.2` replace it with the version you want  
the third install the latest `long-term-support`ed version

## npm
[npm](https://www.npmjs.com/) is a package manager for node modules/packages it comes with `node.js`. I know if the `npm` version can be specified with `nvm`.

## Vue
[vue](https://vuejs.org/) is a javascript framework for building mostly single page apps (SPAs). The whole page is downloaded with a basically empty `index.html` file that then gets populated on the client with the `vue.js` library. This is good for portals, webshops or applications that don't need to be searchable with search engines. The drawback is, everything gets downloaded at once, if it is not cached. 
Install and initialize with:
```bash
npm install -g @vue/cli
npm init vue@latest
vue create hello-world -d
vue --version
```


## Nuxt
[nuxt](https://nuxt.com/) is a framework for `vue.js` apps, that adds server-side rendering.
Install with: 
```bash
npx nuxi@latest init hello-world
```
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
[npm](https://www.npmjs.com/) is a package manager for node modules/packages it comes with `node.js`. I do not know if the `npm` version can be specified with `nvm`.

### NPX
`npx` is a package runner. [docs](https://docs.npmjs.com/cli/v7/commands/npx)

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
[nuxt](https://nuxt.com/) is a framework for `vue.js` apps, that adds server-side rendering. Drastically increases SEO capability of the Website, as server side rendering returns the whole page to the Search Engine.
Install with: 
```bash
npx nuxi@latest init <project>
```
## Directories
### Root level directoruis
* `components`: create Vue components in here starting with uppercase letters. Use them with `<Componen />
Then use the github cli tool to create and sync the repository
### Using bootstrap
I want to use the cdn for bootstrap so I put the `app` part in `nuxt.config.ts`
```js
// https://v3.nuxtjs.org/api/configuration/nuxt.config
export default defineNuxtConfig({
  devtools: { enabled: true },
  app: {
    head: {
      link: [
        { rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css', integrity: 'sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor', crossorigin: 'anonymous' }
      ],
      script: [
        { src: 'https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js', integrity: 'sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2', crossorigin: 'anonymous' }
      ]
    }
  },
  vite: {
    define: {
      "process.env.DEBUG": false,
    },
  },
});
```

## Nuxt
[nuxt](https://nuxt.com/) is a framework for `vue.js` apps, that adds server-side rendering. Drastically increases SEO capability of the Website, as server side rendering returns the whole page to the Search Engine.
[directory structure](https://nuxt.com/docs/guide/directory-structure/nuxt)
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
## Vue
[vue](https://vuejs.org/) is a javascript framework for building mostly single page apps (SPAs). The whole page is downloaded with a basically empty `index.html` file that then gets populated on the client with the `vue.js` library. This is good for portals, webshops or applications that don't need to be searchable with search engines. The drawback is, everything gets downloaded at once, if it is not cached. 
Install and initialize with:
```bash
npm install -g @vue/cli
npm init vue@latest
vue create hello-world -d
vue --version
```
### Component
A new component with css, javascript and html template
```vue
<template>
    <div>
        <h1>Hello New Component</h1>
    </div>
</template>
<script>
    console.log("Hello JS World!")
</script>
<style>
    h1 {
        background-color: #9932CC;
    }
</style>
```
### Api 
The `server/` directory is used to register APIs [link](https://nuxt.com/docs/guide/directory-structure/server)
```
import { createPool, sql } from '@vercel/postgres'

export default defineEventHandler(async () => {
  const db = createPool()
  try {
    const { rows: comics } = await db.query('SELECT * FROM sw_comics')
    return {
      comics: comics,
    }
  } catch (error) {
      throw error
  }
})
```
## Links
[composables,plugins,stores, etc.](https://bigmachine.io/frontend/what-should-be-a-plugin-vs-a-composable-vs-a-store-in-nuxt/)
[AI Links](https://www.reddit.com/r/OpenAI/comments/12jyes5/what_are_good_techniques_for_feeding_extremely/)
[async/await](https://javascript.info/async-await)

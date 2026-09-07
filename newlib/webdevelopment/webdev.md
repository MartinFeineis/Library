# Web Development

## NVM 
[nvm](https://github.com/nvm-sh/nvm/blob/master/README.md) is a node.js version manager like `pyenv`.
Install `nvm` and use it to install `node.js` and `npm`. 
```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
```
Or look [here](https://github.com/nvm-sh/nvm/tree/v0.39.7?tab=readme-ov-file#installing-and-updating)
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
Create nuxt project in existing git repo:
```
npx nuxi@latest init ./ --force
```

## Form setup
```html
<script>
    async function uploadMessage(){
        var sender = document.getElementById("Sender").value;
        var recipient = "404FoundersSite";
        var message = document.getElementById("message").value;
        var msgBody = { "Sender": sender, "Recipient": recipient, "Message": message };
          var url = "https://url-and-route/send";
          const res = await fetch(url, {
            method: 'POST',
            headers: {
                'Content-type': 'application/json'
            },
            body: JSON.stringify(msgBody)
          })
          const data = await res.json()
          var sentMsgId = data.MsgId
          console.log(sentMsgId)
}
</script>
<h1>Contact us -- List page</h1>
<form action="" id="loginForm">
    <h3>Contact Form</h3>
    <label for="identifier">Identifier:</label><br>
    <input type="text" id="Sender" class="form-control" placeholder="Name, e-mail address or other identifier ">
    <label for="message">Message:</label><br>
    <textarea id="message" name="message">Let us know how we can help.</textarea>
    <button type="button" onclick="uploadMessage()">Submit</button>
  </form>
```

## Sign On, Authentication and Authorization
### Google Sign On 
On the Google [Credential Page](https://console.cloud.google.com/apis/credentials?project=<PROJECT-ID>) (Replace Project ID in Link)
Create a OAuth Consent Screen
then you can create Credentials and download a JSON object with the Client ID
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
```

#### O-Auth Consent screen
The __consent screen__ shows which permissions the user is giving to the app (e.g. location, drive access, etc.). Default contains [docs](https://console.cloud.google.com/apis/credentials/consent) Default contains (I think) (E-mail, Name and some meta data).
![Consent screen](https://media.404founders.com/lib/google_consent_screen.png)  
![O-auth Creds](https://media.404founders.com/lib/google_sso_creds.png)

#### Supabase
![Supabase provider](https://media.404founders.com/lib/supabase_google_provider.png)  
![Supabase Url config](https://media.404founders.com/lib/supabase_url_config.png)

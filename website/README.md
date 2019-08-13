# `amiunlocked` Website

The website counterpart to the `amiunlocked` program.

## Environment Variables

The website build process requires certain environment variables in order to run.

| Key        | Required | Description                                                                                                  |
| ---------- | -------- | ------------------------------------------------------------------------------------------------------------ |
| `TITLE`    | Yes      | Title of your website                                                                                        |
| `KVDB_URL` | Yes      | The kvdb `url` value set in the program's ["Configure program"](../program/README.md#configure-program) step |
| `GA_ID`    | No       | Google Analytics site ID                                                                                     |

## Build the site locally

Run the following commands to install dependencies and configure environment variables.

```shell
cd website
npm install
touch .env
```

The contents of your `.env` file should look like this:

```
TITLE=<website title>
KVDB_URL=<kvdb url>
GA_ID=<Google analytics site ID>
```

Lastly, build your site and serve it:

```shell
npm start
```

You can also trigger a production build:

```shell
npm run build
```

## Deploy to Netlify

You can deploy the site directly to Netlify.

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start/deploy?repository=https://github.com/raygesualdo/amiunlocked)

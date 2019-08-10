require('dotenv').config()
const { readFileSync, writeFileSync } = require('fs')
const { resolve } = require('path')
const ejs = require('ejs')

;['TITLE', 'KVDB_URL'].forEach(key => {
  if (!process.env[key]) {
    throw new Error(`Environment variable "${key}" is required.`)
  }
})

const template = readFileSync(resolve(__dirname, './index.html.ejs'), {
  encoding: 'utf-8',
})
const html = ejs.render(template, {
  gaId: process.env.GA_ID,
  title: process.env.TITLE,
  kvdbUrl: process.env.KVDB_URL,
})
writeFileSync(resolve(__dirname, './public/index.html'), html, {
  encoding: 'utf-8',
})

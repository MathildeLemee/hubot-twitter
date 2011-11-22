# Hubot Twitter Adapter

## Description

This is the [Twitter](http://twitter.com) adapter for hubot that allows you to
send an tweet to your Hubot and he will send an tweet back with the response.

## Installation

* Add `hubot-twitter` as a dependency in your hubot's `package.json`
* Install dependencies with `npm install`
* Run hubot with `bin/hubot -a twitter`

### Note if running on Heroku

You will need to change the process type from `app` to `web` in the `Procfile`.

## Usage

You will need to set some environment variables to use this adapter.

### Heroku

   heroku config:add HUBOT_TWITTER_KEY="key" HUBOT_TWITTER_SECRET="secret" HUBOT_TWITTER_TOKEN="token" HUBOT_TWITTER_TOKEN_SECRET="secret"


### Non-Heroku environment variables

   export HUBOT_TWITTER_KEY="key"
   export HUBOT_TWITTER_SECRET="secret"
   export HUBOT_TWITTER_TOKEN="token"
   export HUBOT_TWITTER_TOKEN_SECRET="secret"

Then you will need to set the HTTP endpoint on Twilio to point to your server
and make sure the request type is set to `GET`.

## Contribute

Here's the most direct way to get your work merged into the project.

1. Fork the project
2. Clone down your fork
3. Create a feature branch
4. Hack away and add tests, not necessarily in that order
5. Make sure everything still passes by running tests
6. If necessary, rebase your commits into logical chunks without errors
7. Push the branch up to your fork
8. Send a pull request for your branch

## Copyright

Copyright &copy; Mathilde Lemée. See LICENSE for details.


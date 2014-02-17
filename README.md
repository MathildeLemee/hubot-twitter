# Hubot Twitter Adapter

## Description

This is the [Twitter](http://twitter.com) adapter for hubot that allows you to
send an tweet to your Hubot and he will send an tweet back with the response.

## Installation

* Add `hubot-twitter` as a dependency in your hubot's `package.json`
* Install dependencies with `npm install`
* Run hubot with `bin/hubot -a twitter -n the_name_of_the_twitter_bot_account`

### Note if running on Heroku

You will need to change the process type from `app` to `web` in the `Procfile`.

## Usage

You will need to set some environment variables to use this adapter.

### Heroku

    % heroku config:add HUBOT_TWITTER_KEY="key"
    % heroku config:add HUBOT_TWITTER_SECRET="secret"
    % heroku config:add HUBOT_TWITTER_TOKEN="token"
    % heroku config:add HUBOT_TWITTER_TOKEN_SECRET="secret"

### Non-Heroku environment variables

    % export HUBOT_TWITTER_KEY="key"
    % export HUBOT_TWITTER_SECRET="secret"
    % export HUBOT_TWITTER_TOKEN="token"
    % export HUBOT_TWITTER_TOKEN_SECRET="secret"

Then you will need to set the HTTP endpoint on Twitter to point to your server
and make sure the request type is set to `GET`.

## Contribute

Just send pull request if needed or fill an issue !

## Copyright

Copyright &copy; Mathilde Lemee. See LICENSE for details.


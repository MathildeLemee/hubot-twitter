Robot        = require('hubot').robot()
Adapter      = require('hubot').adapter()

HTTPS        = require 'https'
EventEmitter = require('events').EventEmitter
oauth        = require('oauth')

class Twitter extends Adapter
 send: (user, strings...) ->
   strings.forEach (str) =>
     text = str
     console.log text
     tweetsText = str.split('\n')
     tweetsText.forEach (tweetText) =>
       @bot.send(user,tweetText)

 reply: (user, strings...) ->
   strings.forEach (text) =>
       @bot.reply(user,text)

 run: ->
   self = @
   options =
    key         : process.env.HUBOT_TWITTER_KEY
    secret      : process.env.HUBOT_TWITTER_SECRET
    token       : process.env.HUBOT_TWITTER_TOKEN
    tokensecret : process.env.HUBOT_TWITTER_TOKEN_SECRET
   bot = new TwitterStreaming(options)

   bot.tweet self.robot.name, (err, data) ->
     reg = new RegExp('@'+self.robot.name,'i')
     console.log "received #{data.text} from #{data.user.screen_name}"

     message = data.text.replace reg, self.robot.name
     console.log "hubot command: #{message}"

     self.receive new Robot.TextMessage data.user.screen_name, message
     if err
       console.log "received error: #{err}"

   @bot = bot

exports.use = (robot) ->
 new Twitter robot

class TwitterStreaming extends EventEmitter
 self = @
 constructor: (options) ->
    if options.token? and options.secret? and options.key? and options.tokensecret?
      @token         = options.token
      @secret        = options.secret
      @key           = options.key
      @domain        = 'stream.twitter.com'
      @tokensecret   =  options.tokensecret
      @consumer = new oauth.OAuth "https://twitter.com/oauth/request_token",
                           "https://twitter.com/oauth/access_token",
                           @key,
                           @secret,
                           "1.0",
                           "",
                           "HMAC-SHA1"
    else
      throw new Error("Not enough parameters provided. I need a key, a secret, a token, a secret token")

 tweet: (track,callback) ->
   @post "/1/statuses/filter.json?track=#{track}", '', callback

 send : (user,tweetText) ->
        console.log "send twitt to #{user} with text #{tweetText}"
        @consumer.post "https://api.twitter.com/1/statuses/update.json", @token, @tokensecret, { status: "@#{user} #{tweetText}" },'UTF-8',  (error, data, response) ->
          if error
            console.log "twitter send error: #{error} #{data}"
          console.log "Status #{response.statusCode}"


 # Convenience HTTP Methods for posting on behalf of the token"d user
 get: (path, callback) ->
   @request "GET", path, null, callback

 post: (path, body, callback) ->
   @request "POST", path, body, callback

 request: (method, path, body, callback) ->
   console.log "https://#{@domain}#{path}, #{@token}, #{@tokensecret}, null"

   request = @consumer.get "https://#{@domain}#{path}", @token, @tokensecret, null
   console.log request
   request.on "response",(response) ->
     response.on "data", (chunk) ->
       console.log chunk+''
       parseResponse chunk+'',callback

     response.on "end", (data) ->
       console.log 'end request'

     response.on "error", (data) ->
       console.log 'error '+data

   request.end()

   parseResponse = (data,callback) ->
     while ((index = data.indexOf('\r\n')) > -1)
       json = data.slice(0, index)
       data = data.slice(index + 2)
       if json.length > 0
          try
             console.log "json"+json
             callback null, JSON.parse(json)
          catch err
             console.log "error parse"+json
             callback null, data || { }

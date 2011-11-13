twitter = require 'express-twitter'
web_port = Number process.env.PORT || 8080
redis_port = Number process.env.REDIS_PORT || 6379
redis_host = process.env.REDIS_HOST || 'localhost'

db = require('redis').createClient redis_port, redis_host
require('zappa') web_port, ->
  @use 'bodyParser', 'methodOverride', @app.router
  @use 'static', session: {secret: '1'}, 'cookies'
  @use twitter.middleware {consumerKey: process.env.CK, consumerSecret: process.env.CS}

  @configure
    development: => @use errorHandler: {dumpExceptions: on}
    production: => @use 'errorHandler'

  

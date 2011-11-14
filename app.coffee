twitter = require 'ntwitter'
twi = new twitter consumer_key: process.env.CK, consumer_secret: process.env.CS
db = require('redis-url').connect process.env.REDISTOGO_URL or '127.0.0.1:6739'

require('zappa') process.env.PORT or 8080, ->
  @use 'bodyParser', 'methodOverride', 'cookieParser', session: {secret: '1'}
  @use twi.login '/auth', '/manage'
  @use @app.router, 'static'

  @app.dynamicHelpers flash: (req, res) ->
    req.flash()

  @configure
    development: => @use errorHandler: {dumpExceptions: on}
    production: => @use 'errorHandler'

  @get '/': ->
    @render 'index'

  @post '/': ->
    if @body.txt.length > 140
      @request.flash 'error', 'Your tweet is over 140 characters.'
      @redirect '/'
    else
      twi.showUser @body.uname, (err, data) =>
        if err or data == []
          @request.flash 'error', 'Invalid username.'
          @redirect '/'
        else
          db.llen data[0].id, (err, len) =>
            db.lrange data[0].id, 0, len, (err, items) =>
              if @body.pwd in items
                db.hgetall "#{data[0].id}t", (err, keys) =>
                  twi_local = new twitter consumer_key: process.env.CK, consumer_secret: process.env.CS, access_token_key: keys.k, access_token_secret: keys.s
                  twi_local.updateStatus @body.txt, (err, result) =>
                    if err
                      # sometimes twitter says it's a duplicate when it's not
                      @request.flash 'error', 'Tweet probably posted.'
                    else
                      @request.flash 'info', 'Tweet posted!'
                    db.lrem data[0].id, 1, @body.pwd
                    @redirect '/'
              else
                @request.flash 'error', 'Invalid password.'
                @redirect '/'

  @get '/manage': ->
    c = twi.cookie @request
    if c
      # that should've been in the callback
      # but I don't want to monkeypatch ntwitter
      h = "#{c.user_id}t"
      db.hexists h, 'k', (err, status) =>
        if status == 0
          db.hmset h, k: c.access_token_key, s: c.access_token_secret

      db.llen c.user_id, (err, len) =>
        db.lrange c.user_id, 0, len, (err, items) =>
          @render 'manage', items: items, title: 'Your passwords'
    else
      @redirect '/auth'

  @post '/manage': ->
    c = twi.cookie @request
    if c
      p = @body.pwd
      if typeof p != 'undefined' and p.length > 5 and p.length < 128
        db.rpush c.user_id, p, (err) =>
          @request.flash 'info', 'Successfully added password!'
          @redirect '/manage'
      else
        @request.flash 'error', 'Invalid password!'
        @redirect '/manage'
    else
      @redirect '/auth'

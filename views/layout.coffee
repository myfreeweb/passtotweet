doctype 5
html lang: 'en', ->
  head ->
    meta charset: 'utf-8'
    meta name: 'viewport', content: 'width=device-width, initial-scale=1.0'
    title "#{if @title then @title + ' / ' else ''}PassToTweet"
    link rel: 'stylesheet', href: 'http://fonts.googleapis.com/css?family=Gentium+Basic:700', type: 'text/css'
    link rel: 'stylesheet', href: '/style.css', type: 'text/css'
  body ->
    h1 -> a href: '/', 'PassToTweet'
    for type, lst of @flash
      for msg in lst
        div class: "#{type} flash", msg
    div role: 'main', @body
    footer ->
      text 'Created by '
      a href: 'http://floatboth.com', rel: 'author', 'Grigory V.'
      text ' using '
      a href: 'http://zappajs.org/', 'zappa'
      text ', '
      a href: 'http://nodejs.org', 'node.js'
      text ' and '
      a href: 'http://redis.io', 'Redis'
      text '. Hosted on '
      a href: 'http://heroku.com', 'Heroku'
      text '. '
      a href: 'https://github.com/myfreeweb/passtotweet', 'Open source.'

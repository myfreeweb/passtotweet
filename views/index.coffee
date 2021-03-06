h2 'About'
article ->
  p '''This little app lets you create one-time passwords for
tweeting. One password &mdash; one tweet.
'''
  p '''You can use it to let your friends or family post
a few tweets for you, but just as much tweets as you want.
Maybe you just want it. Maybe you&apos;re in a hospital,
police, whatever. Maybe you can&apos;t use the internets
for some reason, but you can call someone.
Or you lost your main Twitter password. Whatever.'''
  p '''I&apos;ve invented the app while reading
<a href="http://allthingsd.com/20111019/what-not-to-do-in-hong-kong-trust-me-on-this-one/">
this</a>, by the way.'''

h2 'Post a tweet'
form action: '', method: 'post', ->
  label for: 'uname', 'Username'
  input type: 'text', name: 'uname', id: 'uname', pattern: '[a-zA-Z0-9_]{1,15}', maxlength: '15'
  label for: 'pwd', 'Password'
  input type: 'text', name: 'pwd', id: 'pwd'
  label for: 'txt', 'Text'
  textarea name: 'txt', id: 'txt', maxlength: '140'
  button type: 'submit', 'Tweet!'

h2 ->
  a id: 'signin', href: '/auth', 'Sign in with Twitter'
  text ' to manage passwords'

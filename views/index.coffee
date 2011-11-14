h2 'Post a tweet'
form action: '', method: 'post', ->
  label for: 'uname', 'Username'
  input type: 'text', name: 'uname', id: 'uname'
  label for: 'pwd', 'Password'
  input type: 'text', name: 'pwd', id: 'pwd'
  label for: 'txt', 'Text'
  textarea name: 'txt', id: 'txt'
  button type: 'submit', 'Tweet!'

h2 'Manage passwords'
a id: 'signin', href: '/auth', 'Sign in with Twitter'

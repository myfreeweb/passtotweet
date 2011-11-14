h2 'Current passwords'
if @items and @items.length isnt 0
  ul ->
    for item in @items
      li ->
        text item
        text ' '
        a href: "/manage/del?index=#{_i + 1}", class: 'del', 'delete'
else
  div 'None so far, add your first one now:'

h2 'Add a password'
form action: '', method: 'post', ->
  input type: 'text', name: 'pwd', maxlength: '128'
  button type: 'submit', 'Add!'

h2 -> a href: '/logout', 'Log out'

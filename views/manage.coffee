h2 'Current passwords'
if @items
  ul ->
    for item in @items
      li item
else
  div 'None so far, add your first one now:'

h2 'Add a password', ->
  form action: '', method: 'post', ->
    input type: 'text', name: 'pwd'
    button type: 'submit', 'Add!'

doctype 5
html ->
  head ->
    meta charset: 'utf-8'
    title "#{if @title then @title + ' / ' else ''}PassToTweet"
  body ->
    h1 'PassToTweet'
    for type, lst of @flash
      for msg in lst
        div class: "#{type} error", msg
    @body

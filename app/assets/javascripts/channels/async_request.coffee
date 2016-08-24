App.async_request = App.cable.subscriptions.create "AsyncRequestChannel",
  connected: ->
   # alert "I m ready!" 

  disconnected: ->
   # alert "I disconnect!" 

  received: (data) ->
  #  alert "I knew it!" 

  respond: ->
    @perform 'respond'

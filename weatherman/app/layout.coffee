if Meteor.isClient
  Template.layout.helpers
    quot: ->
      _ntes_quote_callback = (jsonobj)-> jsonobj
      stock = Session.get 'stock'
      Meteor.call 'getQuote', stock, (err, results)->
        if err
          console.log @, err
          return
        eval results.content

  Template.layout.events
    'change .stocks': (e,t) ->
      Session.set 'stock', (t.find '.stocks').value
      #console.log Session.get 'stock'

if Meteor.isServer
  Meteor.methods
    getQuote: (stock) ->
      url = "http://api.money.126.net/data/feed/#{stock}"
      HTTP.call 'GET', url

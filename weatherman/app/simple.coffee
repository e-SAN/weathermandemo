if Meteor.isClient
  Template.simple.helpers
    sq: ->
      _ntes_quote_callback = (jsonobj)-> jsonobj
      stock = '10000002'
      Meteor.call 'getQuote', stock, (err, results)->
        #console.log eval results.content
        console.log results.content

if Meteor.isServer
  ->

if Meteor.isClient
  Template.simple.helpers
    sq: ->
      _ntes_quote_callback = (jsonobj)-> jsonobj
      stock = 'SZ000002'
      Meteor.call 'gQuote', stock, (err, results)->
        #console.log @,results.content
        console.log results

if Meteor.isServer
  Meteor.methods
  gQuote: (stock) ->
    url = "http://api.money.126.net/data/feed/#{stock}"
    url = "http://hq.sinajs.cn/list=#{stock}"
    HTTP.call 'GET', url

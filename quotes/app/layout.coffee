if Meteor.isClient
  Template.layout.helpers
    quot: ->
      results = (Session.get 'results')
      if results?
        #console.log @, price
        return "#{results.symbol}#{results.name}: #{results.price}"

  # 此處需要考慮的是，獲得的行情數據是可以延遲發送過來，期間其他的步驟是可以先行的
  # Sync vs Async

  Template.layout.events
    'change .stocks': (e,t) ->
      stock = (t.find '.stocks').value
      Meteor.call 'getQuote', stock, (err, results)->
        unless err?
          Session.set 'results', results[stock]

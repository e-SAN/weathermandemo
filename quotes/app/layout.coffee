if Meteor.isClient
  Template.layout.helpers
    quot: ->
      results = (Session.get 'results')
      if results?
        #console.log @, price
        return results #"#{results.symbol}#{results.name}: #{results.price}"

  # 此處需要考慮的是，獲得的行情數據是可以延遲發送過來，期間其他的步驟是可以先行的
  # Sync vs Async

  Template.layout.events
    'change .stocks': (e,t) ->
      stock = (t.find '.stocks').value
      source = '126.net' # realtime
      source = '163.com' # history
      GetData.quotes {source: '163.com', ids: stock}, (data)->
        # dealing with the data here, for this case it's for a single stock
        console.log data[0...200]
        #Session.set 'results', data[stock]
        Session.set 'results', data[0...200]

if Meteor.isClient
  Template.layout.helpers
    quot: ->
      results = (Session.get 'results')
      if results?
        #return results
        return "#{results.symbol}#{results.name}: #{results.price}"

  # Sync vs Async

  Template.layout.events
    'change .stocks': (e,t) ->
      stock = (t.find '.stocks').value
      source = '126.net' # realtime
      #source = '163.com' # history
      GetData.quotes {source: source, ids: stock}, (data)->
        # dealing with the data here, for this case it's for a single stock
        Session.set 'results', data[stock]
        #Session.set 'results', data[0...200]

  Template.history.helpers
    quot: ->
      results = Session.get 'history'
      if results?
        row = results.rows[0]
        return "行情：Date #{row.DATE} Code #{row.CODE} Close #{row.TCLOSE}"
        #return "#{results.symbol}#{results.name}: #{results.price}"

  Template.history.events
    'change .stocks': (e,t) ->
      stock = (t.find '.stocks').value
      source = '163.com' # history
      GetData.quotes {source: source, ids: stock, start:20080801, end:20150126}, (data)->
        # dealing with the data here, for this case it's for a single stock
        Session.set 'history', data
        Session.set 'data', GetData.rows

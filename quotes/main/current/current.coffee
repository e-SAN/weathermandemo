if Meteor.isClient
  #Template.layout.rendered = ->


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

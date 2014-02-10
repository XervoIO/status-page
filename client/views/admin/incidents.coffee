Template.incidents.rendered = ->

  $('#forms-table').dataTable()


Template.incidents.helpers

  incidents: ->
    Incident.all({sort: {createdAt: -1}})

  humanize: (words) ->
    _.humanize(words)

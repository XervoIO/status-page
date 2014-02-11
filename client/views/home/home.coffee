Template.home.rendered = ->

  #SEO Page Title & Description
  document.title = "My New Meteor App"
  $("<meta>", { name: "description", content: "Page description for My New Meteor App" }).appendTo "head"


Template.home.helpers

  services: ->
    Service.all()

  lastIncident: ->
    Incident.last()

  pastIncidents: ->
    startDate = moment().subtract('days', 7)
    endDate = moment()
    incidents = _.groupBy Incident.all({createdAt: {$gte: startDate._d}}), (incident) ->
      moment(incident.createdAt).format("dddd, MMM D YYYY")
    range = moment().range(startDate, endDate)
    range.by 'days', (momentDate) ->
      date = momentDate.format("dddd, MMM D YYYY")
      incidents[date] = [] unless incidents[date]
    pairs = _.pairs incidents
    sortedData = _.sortBy pairs, (date) ->
      -1 * moment(date[0])
    sortedData

  timeStamp: (timestamp) ->
    moment(timestamp).format("h:mm a")

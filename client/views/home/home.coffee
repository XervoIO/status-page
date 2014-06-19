

Template.home.rendered = ->

  #SEO Page Title & Description
  document.title = "My New Meteor App"
  $("<meta>", { name: "description", content: "Page description for My New Meteor App" }).appendTo "head"

  Deps.autorun ->
    #Highlight the tab w/ highest priority
    cl = ".#{Incident.priority().service().name.toLowerCase()}"
    selected(cl)

Template.home.helpers

  services: ->
    Service.all()

  lastIncident: ->
    incident = Incident.priority()
    if Session.get('service') isnt undefined
      service = Session.get('service')
      incident = Service.first({name:service}).latestIncident()
    incident

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

  service: ->
    @service().name

Template.home.events
  'click .deployments': (e, t) ->
    Session.set('service', 'Deployments')
    selected('.deployments')

  'click .balancers': (e, t) ->
    Session.set('service', 'Balancers')
    selected('.balancers')

  'click .api': (e, t) ->
    Session.set('service', 'API')
    selected('.api')

  'click .database': (e, t) ->
    Session.set('service', 'Database')
    selected('.database')

  'click .host': (e, t) ->
    Session.set('service', 'Host')
    selected('.host')

selected = (className)->
  $(".components li").each ->
    $(@).removeClass('selected')
  $(className).addClass('selected')

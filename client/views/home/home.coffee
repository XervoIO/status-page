Template.home.rendered = ->

  #SEO Page Title & Description
  document.title = "My New Meteor App"
  $("<meta>", { name: "description", content: "Page description for My New Meteor App" }).appendTo "head"


Template.home.helpers

  services: ->
    Service.all()

  lastIncident: ->
    incident = Incident.priority()
    if Session.get('service') isnt undefined
      service = Session.get('service')
      incidents = Service.first({name:service}).incidents()
      if incidents.length > 0
        incident = incidents[incidents.length - 1]
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
    removeSelected()
    $(t.find('.deployments')).addClass('selected')

  'click .balancers': (e, t) ->
    Session.set('service', 'Balancers')
    removeSelected()
    $(t.find('.balancers')).addClass('selected')

  'click .api': (e, t) ->
    Session.set('service', 'API')
    removeSelected()
    $(t.find('.api')).addClass('selected')

  'click .database': (e, t) ->
    Session.set('service', 'Database')
    removeSelected()
    $(t.find('.database')).addClass('selected')

  'click .host': (e, t) ->
    Session.set('service', 'Host')
    removeSelected()
    $(t.find('.host')).addClass('selected')

removeSelected = ->
  $(".components li").each ->
    $(@).removeClass('selected')

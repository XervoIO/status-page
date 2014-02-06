Router.map ->
  @route 'home',
    path: '/'

  @route 'newIncident',
    path: '/admin/incidents/new'
    data: new Incident

  @route 'incidents',
    path: '/admin/incidents'

  @route 'notFound',
    path: '*'
    where: 'server'
    action: ->
      @response.statusCode = 404
      @response.end Handlebars.templates['404']()

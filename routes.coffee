AdminController = RouteController.extend
  yieldTemplates:
    header:
      to: 'header'
  before: ->
    unless Meteor.user()
      @redirect('/sign-in')
      @stop()

Router.map ->
  @route 'home',
    path: '/'

  @route 'newIncident',
    controller: AdminController
    path: '/admin/incidents/new'
    data: new Incident

  @route 'incidents',
    controller: AdminController
    path: '/admin/dashboard'

  @route 'notFound',
    path: '*'
    where: 'server'
    action: ->
      @response.statusCode = 404
      @response.end Handlebars.templates['404']()

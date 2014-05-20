AdminController = RouteController.extend
  yieldTemplates:
    header:
      to: 'header'
  before: ->
    AccountsEntry.signInRequired(@)

Router.map ->
  @route 'home',
    path: '/'
    waitOn: ->
      Meteor.subscribe 'incidents'
      Meteor.subscribe 'services'

  @route 'newIncident',
    controller: AdminController
    path: '/admin/incidents/new'
    waitOn: ->
      Meteor.subscribe 'services'
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

Meteor.startup ->
  if Service.count() is 0
    services = [
      'Deployments',
      'Balancers',
      'API',
      'Database',
      'Host'
    ]
    _.each services, (service) ->
      Service.create({name: service})

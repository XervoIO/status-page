class @Service extends Minimongoid
  @_collection = new Meteor.Collection 'services'

  @has_many: [
    {name: 'incidents'}
  ]

  latestIncident: ->
    @incidents({}, {sort: {createdAt: -1}, limit: 1})[0]

  latestStatus: ->
    incident = @latestIncident()
    if incident
      incident.status
    else
      "operational"

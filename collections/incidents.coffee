class @Incident extends Minimongoid
  @_collection = new Meteor.Collection 'incidents'

  @belongs_to: [
    {name: 'service'}
  ]

  statusOptions: ->
    [
      'operational',
      'degradedPerformance',
      'partialOutage',
      'majorOutage'
    ]

Meteor.methods

  createIncident: (formData) ->
    Incident.create(formData)

Incident._collection.allow
  insert: (userId, incident) ->
    userId


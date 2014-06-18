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

  @priorityLevel: (status) ->
    if status is 'majorOutage'
      4
    else if status is 'partialOutage'
      3
    else if status is 'degradedPerformance'
      2
    else
      1

  @priority: ->
    top = @last()
    Service.all().forEach (service) ->
      current = service.latestIncident()
      if current
        if current.priority > top.priority
          top = current
    top

Meteor.methods

  createIncident: (formData) ->
    Incident.create(formData)

Incident._collection.allow
  insert: (userId, incident) ->
    userId

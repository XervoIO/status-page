Meteor.publish 'incidents', ->
  Incident.find()

Meteor.publish 'services', ->
  Service.find()

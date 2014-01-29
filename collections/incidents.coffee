class @Incident extends Minimongoid
  @_collection = new Meteor.Collection 'incidents'

  @belongs_to: [
    {name: 'service'}
  ]

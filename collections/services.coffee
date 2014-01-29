class @Service extends Minimongoid
  @_collection = new Meteor.Collection 'services'

  @has_many: [
    {name: 'incidents'}
  ]

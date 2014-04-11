Template.newIncident.events
  'submit form': (event) ->
    event.preventDefault()
    formData = SimpleForm.processForm(event.target)
    Meteor.call('createIncident', formData)
    Router.go('/admin/dashboard')

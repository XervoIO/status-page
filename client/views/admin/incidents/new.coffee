Template.newIncident.events
  'submit form': (event) ->
    event.preventDefault()
    formData = SimpleForm.processForm(event.target)
    Incident.create formData
    Router.go('/admin/dashboard')

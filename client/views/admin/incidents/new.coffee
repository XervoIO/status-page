Template.newIncident.events
  'submit form': (event) ->
    event.preventDefault()
    formData = SimpleForm.processForm(event.target)
    formData.priority = Incident.priorityLevel(formData.status)

    Incident.create formData
    Router.go('/admin/dashboard')

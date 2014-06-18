Meteor.startup ->
  AccountsEntry.config
    signupCode: 'Modulus123'
    defaultProfile:
        someDefault: 'default'

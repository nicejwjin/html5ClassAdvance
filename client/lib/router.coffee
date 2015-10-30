Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'

#Router.onBeforeAction ->
#  user = Meteor.user()
#  @next()
#  unless user?
#    Router.go '/loginScreen'
#    @next()
#  else @next()
#,
#  only: [
#    'missionWriteForm',
#    'reviewWriteForm'
#  ]
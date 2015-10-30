rv = new ReactiveVar()

Router.route 'profile',
  path: 'profile'
  fastRender: true

Template.profile.onCreated ->
#  unless (user = Meteor.user()) then return
#  Meteor.call 'profileInfo', user._id, (err, rslt) ->
#    rv.set rslt

Template.profile.helpers
  profileInfo: ->
#    cl rv.get()
#    rv.get()
    Meteor.user()

Template.profile.events
  'click [name=profileImg]': (e, tmpl) ->

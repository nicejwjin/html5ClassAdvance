Router.route 'settings',
  name: 'settings'
  fastRender: true

Template.settings.events
  'click [name=logInAndOut]': (e, tmpl) ->
    if (user = Meteor.user())? then Meteor.logout (err) ->
      if err then alert 'logout failed'
      else alert 'logout'
    else $('#loginModal').modal('show')
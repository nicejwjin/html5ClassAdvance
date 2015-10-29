Template.header.helpers
  pageTitle: -> '해주세요'
  loginout: -> if Meteor.userId()? then 'logout' else 'login'

Template.header.events({
  'click #loginout': (evt, template) ->
    $('#loginModal').modal('show')

})

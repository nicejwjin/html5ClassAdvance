Template.header.helpers
  pageTitle: -> '해주세요'
  loginout: -> if Meteor.userId()? then 'logout' else 'login'
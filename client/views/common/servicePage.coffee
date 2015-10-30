Router.route 'servicePage',
  path: 'servicePage/:pageTitle/:image'
  template: 'servicePage'
  fastRender: true

Template.servicePage.onCreated ->
  Session.set 'pageTitle', Router.current().params.pageTitle

Template.servicePage.helpers
  image: -> Router.current().params.image
  isAboutCompany: -> if Router.current().params.pageTitle is '회사소개' then true else false
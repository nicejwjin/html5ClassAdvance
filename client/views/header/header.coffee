Template.header.events
  'click #loginout': (evt, tmpl) ->
    if Meteor.userId()? then Meteor.logout()
    else $('#loginModal').modal('show')

Template.header.helpers
  loginout: -> if Meteor.userId()? then 'logout' else 'login'
  pageTitle: ->
    switch Router.current().route.getName()
      when 'youDo' then '해주세요'
      when 'iDo' then '해드려요'
      when 'review' then '미션후기'
      when 'settings' then '설정'
      else 'Hello Mission'

Template.header.onRendered ->
  slideRight = new Menu(
    wrapper: '#o-wrapper'
    type: 'slide-right'
    menuOpenerClass: '.c-button'
    maskId: '#c-mask')
  slideRightBtn = document.querySelector('#c-button--slide-right')
#  slideRightBtn = $('#c-button--slide-right')[0]
  slideRightBtn.addEventListener 'click', (e) ->
    e.preventDefault
    slideRight.open()
    return
  menuItemBtn = document.querySelector('.c-menu__items')
  menuItemBtn.addEventListener 'click', (e) ->
    e.preventDefault
    slideRight.close()
    return
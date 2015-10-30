Template.layout.helpers
  mainMenu: ->
    if Router.current().route.getName() in ['youDo', 'iDo', 'review', 'settings'] then true
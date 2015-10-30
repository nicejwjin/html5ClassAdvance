Router.route 'loginScreen',
  fastRender: true

Template.loginScreen.events
  'click [name=btnJoin]': (e, tmpl) ->
    username = $('[name=username]').val()
    pwd = $('[name=password]').val()
    if (username.length <= 0) or (pwd.length <= 0) then return
    if confirm "위내용으로 회원가입 하시겠습니까?"
      Meteor.call 'addUser', username, pwd, (err, rslt) ->
        if err? then alert err.reason
        else
          alert rslt
    else return

  'click [name=btnLogin]': (e, tmpl) ->
    username = $('[name=username]').val()
    pwd = $('[name=password]').val()
    Meteor.loginWithPassword username, pwd, (error) ->
      if error
        alert '로그인에 실패하였습니다. 아이디 및 패스워드를 다시 확인해주세요.'
      else Meteor.call 'limitLoginTokens', (err, rslt) ->
        if err then alert err else Router.go 'youDo'

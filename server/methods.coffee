Meteor.methods
  'addUser': (_email, _pwd) ->
    if Meteor.users.find(username: _email).count() > 0 then throw new Meteor.Error "duplicated-id", "이미사용중인 아이디입니다."
    if _email not in ['admin', 'dev']
      options = {}
      options.username = _email unless _email is null
      options.password = _pwd unless _pwd is null
      options.profile = {}
      rslt = Accounts.createUser options
      unless rslt then return throw new Meteor.Error '사용자 생성 실패'
      else return '사용자 생성 완료'
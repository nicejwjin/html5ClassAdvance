Meteor.methods
  'addUser': (_email, _pwd) ->
    cl 'methods/addUser'
    if Meteor.users.find(username: _email).count() > 0 then throw new Meteor.Error "duplicated-id", "이미사용중인 아이디입니다."
    if _email not in ['admin', 'dev']
      options = {}
      options.username = _email unless _email is null
      options.password = _pwd unless _pwd is null
      options.profile = dataSchema 'profile'
      rslt = Accounts.createUser options
      unless rslt then return throw new Meteor.Error '사용자 생성 실패'
      else return '사용자 생성 완료'

  limitLoginTokens: ->
    cl 'methods/limitLoginTokens'
    user = Meteor.user()
    unless user then throw new Meteor.Error '로그인오류 001'
    if (arrTokens = user?.services?.resume?.loginTokens)?.length > 1
      arrTokens.splice 0, arrTokens.length - 1
      Meteor.users.update _id: user._id,
        $set: 'services.resume.loginTokens': arrTokens
        $inc: 'profile.로그인횟수': 1

  missionCreate: (_mission) ->
    cl 'methods/missionCreate'
    user = Meteor.user()
    _.extend _mission,
      작성자정보:
        _id: user._id
        profile: user.profile
    result = CollectionMissions.insert _mission
    if result then return '등록되었습니다.'
    else throw new Meteor.Error '등록에 실패하였습니다.'

  missionRead: (_id) ->
    cl 'methods/missionRead'
    result = CollectionMissions.findOne _id: _id
#    cl result
    return result

  missionRemove: (_id) ->
    cl 'methods/missionRemove'
    CollectionMissions.remove _id: _id

  missionEdit: (_obj) ->
    cl 'methods/missionEdit'
    CollectionMissions.update _id: _obj._id, _obj

  commentInsert: (_comment) ->
    cl 'methods/commentInsert'
    unless Meteor.userId() then throw new Meteor.Error '로그인 후 작성 가능합니다.'
    user = Meteor.user()
    _.extend _comment,
      작성자정보:
        _id: user._id
        profile: user.profile
    result = CollectionComments.insert _comment
    if result then return '등록되었습니다.'
    else throw new Meteor.Error '등록에 실패하였습니다.'

  commentRemove: (_commentId) ->
    cl 'methods/commentRemove'
    unless CollectionComments.findOne(_id: _commentId)?.작성자정보._id is Meteor.userId() then throw new Meteor.Error "다른유저의 댓글을 삭제할수 없습니다."
    CollectionComments.remove _id: _commentId

  reviewCreate: (obj) ->
    cl 'methods/reviewCreate'
    user = Meteor.user()
    _.extend obj,
      작성자정보:
        _id: user._id
        profile: user.profile
    CollectionReviews.insert obj

  reviewRemove: (_id) ->
    cl 'methods/reviewRemove'
    CollectionReviews.remove _id: _id

  reviewRead: (_id) ->
    cl 'methods/missionRead'
    result = CollectionReviews.findOne _id: _id
    return result

  imageFileUpload: (fileObj) ->
    cl 'methods/imageFileUpload'
    try
      HTTP.call 'POST', "http://#{imageServerIp}:#{imageServerPort}/addFlagImage", {data: fileObj}
      return 'save done'
    catch e
      throw new Meteor.Error '저장에 실패하였습니다. 다시 시도하세요. 지속적인 문제시 개발실에 문의바랍니다.'

  profileInfo: (_userId) ->
    cl 'methods/profileInfo'
    Meteor.users.findOne _id: _userId
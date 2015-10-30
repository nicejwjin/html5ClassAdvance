Router.route 'reviewDetail',
  path: 'reviewDetail/:_id'

rv = new ReactiveVar()

Template.reviewDetail.onCreated ->
  Session.set 'pageTitle', '후기상세'
  Meteor.call 'reviewRead', Router.current().params._id, (err, rslt) ->
    rv.set rslt
  @autorun =>
    whenSubsReadyData [@subscribe '게시물상세댓글', Router.current().params._id], ->
      comments: ->
        CollectionComments.find('게시물_id': Router.current().params._id)

Template.reviewDetail.helpers
  objReview: -> return rv.get()
  프로필이미지: ->
    if @작성자정보.profile?.프로필이미지.length > 0
      "http://#{imageRepositoryIp}:#{imageRepositoryPort}/" + @작성자정보.profile.프로필이미지
    else return '/images/noimg_star.png'
  후기이미지: ->
    "http://#{imageRepositoryIp}:#{imageRepositoryPort}/" + @
  작성일시: ->
    jUtils.getStringMDHMFromDate @createdAt
  myContents: ->
    if @작성자정보._id is Meteor.user()._id then true

Template.reviewDetail.events
  'click [name=btnCommentSave]': (e, tmpl) ->
    comment = $('[name=comment]').val()
    obj = dataSchema 'comment',
      게시물_id: Router.current().params._id
      댓글: comment
    Meteor.call 'commentInsert', obj, (err, rslt) ->
      if err then alert err else alert rslt
      $('[name=comment]').val('')

  'click [name=btnCommentRemove]': (e, tmpl) ->
    if confirm "댓글을 삭제하시겠습니까?"
      Meteor.call 'commentRemove', @_id, (err, rslt) ->
        if err then alert "댓글삭제 실패"

  'click [name=reviewRemoveBtn]': (e, tmpl) ->
    Meteor.call 'reviewRemove', @_id, (err, rslt) ->
      if err then alert err
      else
        alert "삭제하였습니다."
        history.go(-1)
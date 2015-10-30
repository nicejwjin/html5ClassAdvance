Router.route 'review',
  name: 'review'
  fastRender: true

Template.review.onCreated ->
  condition = {}
  @autorun =>
    whenSubsReadyData [@subscribe 'reviewLists', condition], ->
      reviews: ->
        CollectionReviews.find({},{sort: createdAt: -1}).fetch()

Template.review.helpers
  commentCount: ->
    CollectionComments.find(게시물_id: @_id).count()
  프로필이미지: ->
    if @작성자정보.profile?.프로필이미지?.length > 0
      "http://#{imageRepositoryIp}:#{imageRepositoryPort}/" + @작성자정보.profile.프로필이미지
    else return '/images/noimg_star.png'

Template.review.events
  'click [name=reviewWriteBtn]': (e, tmpl) ->
    user = Meteor.user()
    unless user?
      if confirm("로그인 하시겠습니까?") then $('#loginModal').modal('show')
    else
      Router.go 'reviewWriteForm'
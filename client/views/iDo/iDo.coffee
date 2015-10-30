condition = new ReactiveVar()

Router.route 'iDo',
  name: 'iDo'
  fastRender: true
  onRun: ->
    condition.set where: {
      미션종류: Router.current().route.getName()
    }, options: {
      sort: createdAt: -1
    }
    @next()

Template.iDo.onCreated ->
  @autorun =>
    whenSubsReadyData [@subscribe 'missionLists', condition.get()], ->
      iDoLists: ->
        CollectionMissions.find({},{sort: createdAt: -1}).fetch()


Template.iDo.helpers
  commentCount: ->
    CollectionComments.find(게시물_id: @_id).count()
  finish: ->
    now = new Date()
    if @마감일시 > now then return 'not-finish'
    else return 'finish'
  프로필이미지: ->
    if @작성자정보.profile?.프로필이미지.length > 0
      "http://#{imageRepositoryIp}:#{imageRepositoryPort}/" + @작성자정보.profile.프로필이미지
    else return '/images/noimg_star.png'

Template.iDo.events
  'click [name=findAll]': (e, tmpl) ->
    cond = condition.get()
    if cond.where?.마감일시?
      delete cond.where?.마감일시
      condition.set cond
  'click [name=findNotFinished]': (e, tmpl) ->
    cond = condition.get()
    cond.where['마감일시'] = {$gt: new Date()}
    condition.set cond
  'click [name=findFinished]': (e, tmpl) ->
    cond = condition.get()
    cond.where['마감일시'] = {$lte: new Date()}
    condition.set cond
  'click [name=missionWriteBtn]': (e, tmpl) ->
    user = Meteor.user()
    unless user? then if confirm("로그인 하시겠습니까?") then $('#loginModal').modal('show')
    else Router.go 'missionWriteForm', {category: 'iDo'}
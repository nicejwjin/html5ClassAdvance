rv = new ReactiveVar()

Router.route 'missionEdit',
  path: 'missionEdit/:_id'
  template: 'missionEdit'
  fastRender: true
  onRun: ->
    Meteor.call 'missionRead', @params._id, (err, rslt) ->
      rv.set rslt
    @next()

Template.missionEdit.onRendered ->
  Session.set 'pageTitle', '미션수정'
  $(document).ready ->
    departure = document.getElementById('autoCompleteDeparture')
    autocompleteDeparture = new (google.maps.places.Autocomplete)(departure)
    # When the user selects an address from the dropdown,
    google.maps.event.addListener autocompleteDeparture, 'place_changed', ->
      # Get the place details from the autocomplete object.
      place = autocompleteDeparture.getPlace()
      #      console.log 'place: ' + JSON.stringify(place)
      return

    arrival = document.getElementById('autoCompleteArrival')
    autocompleteArrival = new (google.maps.places.Autocomplete)(arrival)
    google.maps.event.addListener autocompleteArrival, 'place_changed', ->
      place = autocompleteArrival.getPlace()
      #      console.log 'place: ' + JSON.stringify(place)
      return
    return

Template.missionEdit.helpers
  objMission: -> rv.get()
  pageTitle: ->
    Router.current().params.pageTitle


Template.missionEdit.events
  'click [name=btnSubmit]': (e, tmpl) ->
    출발지 = $('[name=출발지]').val()
    도착지 = $('[name=도착지]').val()
    마감시간 = $('[name=마감시간]').val()
    타이틀 = $('[name=타이틀]').val()
    리워드 = $('[name=리워드]').val()
    상세내용 = $('[name=상세내용]').val()

    if 출발지.length <= 0 or
    도착지.length <= 0 or
    마감시간.length <= 0 or
    타이틀.length <= 0 or
    리워드.length <= 0 or
    상세내용.length <= 0
      return alert '모든 필드는 필수 입력사항입니다.'

    obj = rv.get()
    obj['출발지'] = 출발지
    obj['도착지'] = 도착지
    obj['마감일시'] = (new Date()).addHours(parseFloat(마감시간))
    obj['타이틀'] = 타이틀
    obj['리워드'] = 리워드
    obj['상세내용'] = 상세내용

    Meteor.call 'missionEdit', obj, (err, rslt) ->
      if err then alert err
      else
        alert '수정되었습니다.'
        Router.go obj.미션종류

rv = new ReactiveVar()

Router.route 'missionWriteForm',
  path: 'missionWriteForm/:category'
  template: 'missionWriteForm'
  fastRender: true

Template.missionWriteForm.onRendered ->
  Session.set 'pageTitle', '미션작성'
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

Template.missionWriteForm.helpers
  objMission: -> rv.get()

Template.missionWriteForm.events
  'click [name=btnSubmit]': (e, tmpl) ->
    출발지 = $('[name=출발지]').val()
    도착지 = $('[name=도착지]').val()
    마감시간 = $('[name=마감시간]').val()
    타이틀 = $('[name=타이틀]').val()
    리워드 = $('[name=리워드]').val()
    상세내용 = $('[name=상세내용]').val()
    미션종류 = Router.current().params.category

    if 출발지.length <= 0 or
    도착지.length <= 0 or
    마감시간.length <= 0 or
    타이틀.length <= 0 or
    리워드.length <= 0 or
    상세내용.length <= 0
      return alert '모든 필드는 필수 입력사항입니다.'

    obj = dataSchema 'mission',
      출발지: 출발지
      도착지: 도착지
      마감일시: (new Date()).addHours(parseFloat(마감시간))
      타이틀: 타이틀
      리워드: 리워드
      상세내용: 상세내용
      미션종류: 미션종류

    Meteor.call 'missionCreate', obj, (err, rslt) ->
      if err then alert err
      else Router.go 미션종류

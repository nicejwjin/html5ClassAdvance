Router.route 'reviewWriteForm',
  path: 'reviewWriteForm'
  template: 'reviewWriteForm'
  fastRender: true

Template.reviewWriteForm.onRendered ->
  Session.set 'pageTitle', '후기작성'
  $(document).ready ->
    departure = document.getElementById('reviewDeparture')
    reviewDeparture = new (google.maps.places.Autocomplete)(departure)
    # When the user selects an address from the dropdown,
    google.maps.event.addListener reviewDeparture, 'place_changed', ->
      # Get the place details from the autocomplete object.
      place = reviewDeparture.getPlace()
#      console.log 'place: ' + JSON.stringify(place)
      return

    arrival = document.getElementById('reviewArrival')
    reviewArrival = new (google.maps.places.Autocomplete)(arrival)
    google.maps.event.addListener reviewArrival, 'place_changed', ->
      place = reviewArrival.getPlace()
#      console.log 'place: ' + JSON.stringify(place)
      return
    return


Template.reviewWriteForm.helpers

Template.reviewWriteForm.events
  'click [name=btnSubmit]': (e, tmpl) ->
    isRollback = false
    출발지 = $('[name=출발지]').val()
    도착지 = $('[name=도착지]').val()
    타이틀 = $('[name=타이틀]').val()
    상세내용 = $('[name=상세내용]').val()
    첨부이미지 = []
    images = []

    for i in [1..3]
      file = tmpl.find("[name=첨부이미지#{i}]").files[0]
      images.push file

    if 출발지.length <= 0 or
    도착지.length <= 0 or
    타이틀.length <= 0 or
    상세내용.length <= 0
      return alert '모든 필드는 필수 입력사항입니다.'

    images.forEach (fileObj) ->
      unless fileObj? then return
      fileName = Meteor.uuid()
      첨부이미지.push fileName

      fileReader = new FileReader()
      fileReader.onload = (file) ->
        tmpObj =
          'fileName': fileName
          'image': file.srcElement.result
        Meteor.call 'imageFileUpload', tmpObj, (err, rslt) ->
          if err then alert err else cl 'image upload done'
      fileReader.readAsBinaryString fileObj

    obj = dataSchema 'review',
      출발지: 출발지
      도착지: 도착지
      타이틀: 타이틀
      상세내용: 상세내용
      첨부이미지: 첨부이미지

    Meteor.call 'reviewCreate', obj, (err, rslt) ->
      if err then alert err
      else alert '등록되었습니다.';Router.go 'review'

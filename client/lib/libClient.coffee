@whenSubsReadyData = (subs, cb) ->
  #when all sub handler, insert callback return data to dataVar
  return for sub in subs when !sub.ready()
  Blaze.getView('with').dataVar.set cb()

@libClient =
  #image서버에 이미지를 저장, 성공시 uuid 이미지명을 리턴
  saveImageAsBinaryString: (image) ->
    cl 'libClient/saveImageAsBinaryString'
    name = Meteor.uuid()
    tmpObj =
      'fileName': name
      'image': image
    try
      HTTP.call 'POST', "http://#{imageServerIp}:#{imageServerPort}/addFlagImage", {data: tmpObj}
      return name
    catch e
      alert e
      throw new Meteor.Error '저장에 실패하였습니다. 다시 시도하세요. 지속적인 문제시 개발실에 문의바랍니다.'

@dataSchema = (_objName, _addData) ->
  rslt = {}

  # add 될 데이터가 있다면 return 시에 extend 해서 반환한다.

  addData = _addData or {}

  switch _objName
    when 'profile'
      rslt =
        firstName: ''
        lastName: ''
        email: ''
        국적: ''
        사용언어: []
        성별: ''
        프로필이미지: ''
        자기소개: ''
        생년월일: {}  #date
        상세주소: ''
        isDeletedAccounts: false
        회원등급: ''
        로그인횟수: 0
    when 'mission'
      rslt =
        createdAt: new Date()
        작성자정보:
          _id:''
          profile:{}
        미션종류: ''
        출발지: ''
        도착지: ''
        타이틀: ''
        리워드: ''
        상세내용: ''
        마감일시: {} #2015-01-01 16:00
        readCount: 0
    when 'review'
      rslt =
        createdAt: new Date()
        작성자정보:
          _id:''
          profile:{}
        출발지: ''
        도착지: ''
        타이틀: ''
        상세내용: ''
        첨부이미지: []
        readCount: 0
    when 'comment'
      rslt =
        createdAt: new Date()
        게시물_id: ''
        작성자정보:
          _id: ''
          profile: {}
        댓글: ''

    else
      throw new Error '### Data Schema Not found'

  return _.extend rslt, addData

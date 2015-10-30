Meteor.publish('missionLists', (condition) ->
  cl 'pub/missionLists'
  lists = CollectionMissions.find(condition?.where or {}, condition?.options or {})
  missionIds = []
  lists.forEach (mission) ->
    missionIds.push mission._id
  return [
    lists
    CollectionComments.find({게시물_id: $in: missionIds},
      {fields:
        _id: 1
        게시물_id: 1})
  ]
)

Meteor.publish 'reviewLists', (condition) ->
  cl 'pub/reviewLists'
  lists = CollectionReviews.find(condition?.where or {}, condition?.options or {})
  reviewIds = []
  lists.forEach (review) ->
    reviewIds.push review._id
  commentsCursor = CollectionComments.find({게시물_id: $in: reviewIds},
    {fileds:
      _id: 1
      게시물_id: 1})
  return [
    lists
    commentsCursor
  ]


Meteor.publish '게시물상세댓글', (_id) ->
  cl 'pub/missionLists'
  CollectionComments.find 게시물_id: _id
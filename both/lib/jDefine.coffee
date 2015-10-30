@imageServerIp = do -> Meteor.settings?.public?.imageServerIp
@imageServerPort = do -> Meteor.settings?.public?.imageServerPort
@imageRepositoryIp = do -> Meteor.settings?.public?.imageRepositoryIp
@imageRepositoryPort = do -> Meteor.settings?.public?.imageRepositoryPort

@jDefine =
  timeFormat: 'YYYY-MM-DD HH:mm:ss'
  timeFormatMDHM: 'MM-DD HH:mm'
  timeFormatMD: 'MM-DD'
  timeFormatYM: 'YYYY-MM'
  timeFormatYMD: 'YYYY-MM-DD'
  timeFormatHMS: 'HH:mm:ss'
  timeFormatH: 'HH'
  timeFormatM: 'mm'
  timeFormatHM: 'HH:mm'
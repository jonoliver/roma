Meteor.startup ->
  user = Meteor.user()
  socket = new Roma.Slack.Socket();
  Session.set('notifications', [])
  
  Tracker.autorun (c) ->
    user = Meteor.user()
    if user && user.profile.pomo.type == 'pomodoro'
      Session.set('notifications', [])
      socket.start(user.profile.slack)
    if user && user.profile.pomo.type != 'pomodoro'
      console.log Session.get('notifications')
      socket.stop()
      Meteor.call 'endDnd'
    return
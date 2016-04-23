Meteor.startup ->
  Tracker.autorun (c) ->
    user = Meteor.user()
    if user && user.profile.pomo.type != 'pomodoro'
      Meteor.call 'endDnd'
    return

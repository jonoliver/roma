Meteor.startup ->
  Tracker.autorun (c) ->
    user = Meteor.user()
    if user.profile.pomo.type != 'pomodoro'
      token = user.profile.slack.access_token
      return unless token
      url = "https://slack.com/api/dnd.endDnd?token=#{token}"
      HTTP.call 'GET', url, (error, response) ->
        console.log error, response.content
    return

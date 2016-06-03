class Roma.Slack.Socket
  started = false
  logMessages = false

  isMention = (msg, userId) -> msg.indexOf("<@#{userId}>") > -1

  onMessage = (message, userId) ->
    if logMessages
      data = JSON.parse(message.data)
      console.log  data
      # data.type, data.channel, data.user, data.text
      if data.type == 'message' and isMention(data.text, userId)
        # Meteor.call 'usersInfo', data.user, (wat)->
        name = Meteor.user().profile.name
        notification =
          fromUser: data.user
          channel: data.channel
          message: data.text.split("<@#{userId}>").join("@#{name}")
        console.log notification
        notifications = Session.get('notifications')
        notifications.push notification
        Session.set('notifications', notifications)
    return

  start: (slackDetails) ->
    unless started
      userId = slackDetails.user_id
      rtmUrl = "https://slack.com/api/rtm.start?token=#{slackDetails.access_token}&simple_latest&no_unreads"
      $.get rtmUrl, (res) =>
        @ws = new WebSocket(res.url)
        @ws.onopen = (e) -> console.log e
        @ws.onmessage = (e) -> onMessage e, userId
        @ws.onclose = -> console.log ('closed!')
        return
    started = true
    logMessages = true

  stop: -> logMessages = false
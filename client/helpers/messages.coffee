Template.messages.helpers
  messageGroups: ->
    groupedMessages = _.groupBy Meteor.user().messages, 'from'
    messages = _.map groupedMessages, (messages, fromUserId) ->
      user = Meteor.users.findOne({'_id': fromUserId})
      {name: user.profile.name, messages: messages}
    messages
  notifications: ->
    groupedMessages = _.groupBy Session.get('notifications'), 'fromUser'
    _.map groupedMessages, (messages, fromUserId) -> { name: fromUserId, messages: messages }
  inPomo: ->
    Meteor.user().profile.pomo.type == "pomodoro"
  isEnabled: ->
    Roma.isEnabled('messaging')
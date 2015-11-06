Template.messages.helpers
  messageGroups: ->
    groupedMessages = _.groupBy Meteor.user().messages, 'from'
    messages = _.map groupedMessages, (messages, fromUserId) ->
      user = Meteor.users.findOne({'_id': fromUserId})
      {name: user.profile.name, messages: messages}
    messages

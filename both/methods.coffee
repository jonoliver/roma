Meteor.methods {
  'sendMessage': (user_id, message) ->
    Meteor.users.update({_id:user_id}, { $push:{"messages":message}}, {multi: true} )
  'clearMessages':  ->
    Meteor.users.update({_id:Meteor.userId()}, { $unset: {"messages" : ""} })
  'authorize': (code) ->
    Roma.Auth.access(code)
  'setDoNotDisturb': ->
    token = Meteor.user().profile.slack.access_token
    return unless token
    url = "https://slack.com/api/dnd.setSnooze?token=#{token}&num_minutes=25"
    HTTP.call 'GET', url, (error, response) ->
      console.log error, response.content
}
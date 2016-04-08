Meteor.methods {
  'sendMessage': (user_id, message) ->
    Meteor.users.update({_id:user_id}, { $push:{"messages":message}}, {multi: true} )
  'clearMessages':  ->
    Meteor.users.update({_id:Meteor.userId()}, { $unset: {"messages" : ""} })
}
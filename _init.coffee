@Roma = {};

Meteor.methods {
  'sendMessage': (user_id, message) ->
    console.log message
    Meteor.users.update({_id:user_id}, { $push:{"messages":message}}, {multi: true} )
}
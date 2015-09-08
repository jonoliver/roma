Meteor.publish "userStatus", () ->
  return Meteor.users.find
    "status.online": true
    "profile.name": { $ne: "" }

Meteor.users.find({ "status.online": true }).observe
  added: (user)-> 
  removed: (user)-> 
    Meteor.users.update({_id:user._id}, {$set:{'profile.pomo.type':null}})
    Meteor.users.update({_id:user._id}, {$set:{'profile.pomo.minute':null}})
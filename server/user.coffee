Meteor.publish "userStatus", () ->
  return Meteor.users.find
    "status.online": true
    "profile.name": { $ne: "" }

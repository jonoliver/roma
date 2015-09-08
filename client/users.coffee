Template.users.helpers
  usersOnline: ->
    Meteor.users.find({ "status.online": true })
  user: ->
    Meteor.user()
  edit: =>
    user = Meteor.user()
    Session.get('edit') || user.profile.name == undefined || user.profile.name == ""

Template.users.events
  'change, blur [name="name"]': (e)-> 
    Meteor.users.update({_id:Meteor.user()._id}, { $set:{"profile.name":e.target.value}}, {multi: true} )
    Session.set('edit', false)
  'click .edit' : ->
    Session.set('edit', true)

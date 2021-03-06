Meteor.subscribe("userData");
Meteor.subscribe("userStatus");

Template.users.helpers
  usersOnline: ->
    Meteor.users.find({ "status.online": true })
  user: ->
    Meteor.user()
  edit: =>
    user = Meteor.user()
    Session.get('edit') || user.profile.name == undefined || user.profile.name == ""
  messageUser: (args) ->
    Session.get('send_message_user') == args.hash.id
  messagingClass: ->
    if Roma.isEnabled('messaging') then 'send_message' else ''
  friendlyPomoType: (pomoType)->
    pomoType.split('_').join(' ')

Template.users.events
  'change [name="name"], blur [name="name"]': (e)-> 
    Meteor.users.update({_id:Meteor.user()._id}, { $set:{"profile.name":e.target.value}}, {multi: true} )
    Session.set('edit', false)
  'click .edit' : ->
    Session.set('edit', true)
  'click .cancel' : ->
    Session.set('edit', false)
  'click .send_message': (e)->
    return unless Roma.isEnabled('messaging')
    Session.set('send_message_user', e.target.dataset.userId)    
  'click .cancel_message': (e)->
    return unless Roma.isEnabled('messaging')
    Session.set('send_message_user', null)
  # 'keyup .message_text': (e)->
  'submit .message_form': (e)->
    e.preventDefault()
    toUserId = e.target.elements.user.value
    message = {
      from: Meteor.user()._id
      message: e.target.elements.message.value
    }
    Meteor.call 'sendMessage', toUserId, message
    e.target.elements.message.value = ""
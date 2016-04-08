Template.timer.helpers
  time: ->
    Session.get 'time'
  complete: ->
    Session.get 'complete'
  usersOnline: ->
    Meteor.users.find({ "status.online": true })
  
Template.timer.events
  'click #pomodoro': (e)->
    handleStart 25, e
    Meteor.call 'clearMessages'
  'click #short_break': (e)->
    handleStart 5, e
  'click #long_break': (e)->
    handleStart 15, e
  'click #mega_short_break': (e)->
    handleStart 1, e
  
handleStart = (minutes, event)->
  Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.type':event.target.id}})
  Roma.timer.reset minutes
  $('.active').removeClass('active')
  $(event.target).addClass('active')


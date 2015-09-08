if Meteor.isClient
  Meteor.subscribe("userStatus");
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
    'click #short_break': (e)->
      handleStart 5, e
    'click #long_break': (e)->
      handleStart 15, e
    'click #mega_short_break': (e)->
      handleStart 1, e
    
  handleStart = (minutes, event)->
    Roma.timer.reset minutes
    $('.active').removeClass('active')
    $(event.target).addClass('active')
  

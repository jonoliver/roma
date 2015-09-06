if Meteor.isClient
  Template.timer.helpers
    time: ->
      Session.get 'time'
    complete: ->
      Session.get 'complete'
  Template.timer.events
    'click #pomodoro': (e)->
      handleStart 25, e
      return
    'click #short_break': (e)->
      handleStart 5, e
      return
    'click #long_break': (e)->
      handleStart 10, e
      return
    'click #mega_short_break': (e)->
      handleStart 1, e
      return
  
  handleStart = (minutes, event)->
    Roma.timer.reset minutes
    $('.active').removeClass('active')
    $(event.target).addClass('active')
    
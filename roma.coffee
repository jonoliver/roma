if Meteor.isClient
  Template.timer.helpers
    time: ->
      Session.get 'time'
    complete: ->
      Session.get 'complete'
  Template.timer.events
    'click #start_pomodoro': (e)->
      handleStart 25, e
      return
    'click #start_short_break': (e)->
      handleStart 5, e
      return
    'click #start_long_break': (e)->
      handleStart 10, e
      return
    'click #start_mega_short_break': (e)->
      handleStart 1, e
      return
  
  handleStart = (minutes, event)->
    Roma.timer.reset minutes
    $('.active').removeClass('active')
    $(event.target).addClass('active')
    
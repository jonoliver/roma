if Meteor.isClient
  Template.timer.helpers
    time: ->
      Session.get 'time'
    complete: ->
      Session.get 'complete'
  Template.timer.events
    'click #start_pomodoro': ->
      Roma.timer.reset 25
      return
    'click #start_short_break': ->
      Roma.timer.reset 5
      return
    'click #start_long_break': ->
      Roma.timer.reset 10
      return
    'click #start_mega_short_break': ->
      Roma.timer.reset 1
      return

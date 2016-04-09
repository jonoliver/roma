Template.timer.helpers
  time: ->
    Session.get 'time'
  complete: ->
    Session.get 'complete'
  isTestingEnabled: ->
    Roma.isEnabled('testing')
  headerText: ->
    pomoType = Meteor.user().profile.pomo.type
    switch pomoType
      when 'pomodoro' then 'Focus time!'
      when 'long_break' then 'Take a long break!'
      when 'short_break' then 'Take a short break!'
      when 'mega_short_break' then 'Take a mega short break!'
      else 'Get started!'
  
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


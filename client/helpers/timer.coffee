Template.timer.helpers
  time: ->
    Session.get 'time'
  complete: ->
    Session.get 'complete'
  headerText: ->
    pomoType = Meteor.user().profile.pomo.type
    return Roma.intervals[pomoType].headerDuringMessage if pomoType
    return Roma.intervals[lastPomoType()].headerAfterMessage if lastPomoType()
    'Get started!'
  activeClass: (pomoType) ->
    return '' if Meteor.user().profile.pomo.type == null
    if Meteor.user().profile.pomo.type == pomoType then 'active' else ''
  pomodoroNextClass: ->
    return 'next' if lastPomoType() == undefined
    nextClass(lastPomoType() != 'pomodoro')
  longBreakNextClass: ->
    nextClass(lastPomoType() == 'pomodoro' && isTimeForLongBreak())
  shortBreakNextClass: ->
    nextClass(lastPomoType() == 'pomodoro' && !isTimeForLongBreak())
    
Template.timer.events
  'click #pomodoro': (e)->
    handleStart e
    Meteor.call 'clearMessages'
  'click #short_break': (e)->
    handleStart e
  'click #long_break': (e)->
    handleStart e
  
handleStart = (event)->
  id = event.target.id
  Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.type':id}})
  Session.set 'last_pomo_type', id
  Roma.timer.reset Roma.intervals[id].duration

lastPomoType = ->
  Session.get 'last_pomo_type'
  
nextClass = (condition) ->
  if condition && Session.get 'complete' then "next" else ""
  
isTimeForLongBreak = ->
  (Meteor.user().profile.pomo.completed_count % 4) == 0
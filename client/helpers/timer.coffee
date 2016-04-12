Template.timer.helpers
  time: -> Session.get 'time'
  headerText: ->
    return Roma.intervals[currentPomoType()].headerDuringMessage if currentPomoType()
    return Roma.intervals[lastPomoType()].headerAfterMessage if lastPomoType()
    'Get started!'
  activeClass: (pomoType) -> if currentPomoType() == pomoType then 'active' else ''
  pomodoroNextClass: ->
    return 'next' if lastPomoType() == undefined
    nextClass(!wasPomo())
  longBreakNextClass:  -> nextClass(wasPomo() && isTimeForLongBreak())
  shortBreakNextClass: -> nextClass(wasPomo() && !isTimeForLongBreak())
    
Template.timer.events
  'click #pomodoro': (e) ->
    handleStart e
    Meteor.call 'clearMessages'
  'click #short_break': (e) -> 
    handleStart e
  'click #long_break': (e) -> 
    handleStart e
  
handleStart = (event)->
  id = event.target.id
  Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.type':id}})
  Session.set 'last_pomo_type', id
  Roma.timer.reset Roma.intervals[id].duration

wasPomo = -> lastPomoType() == 'pomodoro'
isTimeForLongBreak = -> (Meteor.user().profile.pomo.completed_count % 4) == 0
currentPomoType = -> Meteor.user().profile.pomo.type
lastPomoType = -> Session.get 'last_pomo_type'
nextClass = (condition) ->
  if condition && Session.get 'complete' then "next" else ""
  

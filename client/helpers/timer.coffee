Template.timer.helpers
  time: ->
    Session.get 'time'
  complete: ->
    Session.get 'complete'
  isTestingEnabled: ->
    Roma.isEnabled('testing')
  headerText: ->
    pomoType = Meteor.user().profile.pomo.type
    return Roma.intervals[pomoType].headerDuringMessage if pomoType
    # lastPomoType = Meteor.user().profile.pomo.last_type
    lastPomoType = Session.get 'last_pomo_type'
    return Roma.intervals[lastPomoType].headerAfterMessage if lastPomoType
    'Get started!'
    
Template.timer.events
  'click #pomodoro': (e)->
    handleStart Roma.intervals.pomodoro.duration, e
    Meteor.call 'clearMessages'
  'click #short_break': (e)->
    handleStart Roma.intervals.short_break.duration, e
  'click #long_break': (e)->
    handleStart Roma.intervals.long_break.duration, e
  'click #mega_short_break': (e)->
    handleStart Roma.intervals.mega_short_break.duration, e
  
handleStart = (minutes, event)->
  Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.type':event.target.id}})
  # Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.last_type':event.target.id}})
  Session.set 'last_pomo_type', event.target.id
  Roma.timer.reset minutes
  $('.active').removeClass('active')
  $(event.target).addClass('active')


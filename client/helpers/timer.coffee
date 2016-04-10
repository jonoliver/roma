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
    handleStart e
    Meteor.call 'clearMessages'
  'click #short_break': (e)->
    handleStart e
  'click #long_break': (e)->
    handleStart e
  'click #mega_short_break': (e)->
    handleStart e
  
handleStart = (event)->
  id = event.target.id
  Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.type':id}})
  # Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.last_type':id}})
  Session.set 'last_pomo_type', id
  Roma.timer.reset Roma.intervals[id].duration
  $('.active').removeClass('active')
  $(event.target).addClass('active')


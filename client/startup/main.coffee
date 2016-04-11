init = ->
  Roma.timer = new (Roma.Timer)(
    onUpdate: (t) ->
      Session.set 'time', t
    onStart: ->
      Session.set 'complete', false
      document.title = 'go!'
    onComplete: ->
      Session.set 'complete', true
      pomoType = Meteor.user().profile.pomo.type
      notification = new Notification(Roma.intervals[pomoType].headerAfterMessage, {icon: 'img/tomato.png'});
      document.title = 'done!'

      if pomoType == 'pomodoro'
        count = Meteor.user().profile.pomo.completed_count || 0
        count = count + 1
        Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.completed_count':count}})
        
      Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.type':null}})
      Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.minute':null}})
    onMinute: (m)->    
      Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.minute':m}})
)

Meteor.startup ->
  init()
  Notification.requestPermission()

  if Roma.isEnabled('testing')
    # speed up the timers for manual testing, we don't have all day!
    _.each Roma.intervals, ((o) -> o.duration = 1)
    Roma.timer.displaySpeed = 100


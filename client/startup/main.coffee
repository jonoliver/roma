init = ->
  Roma.timer = new (Roma.Timer)(
    onUpdate: (t) ->
      Session.set 'time', t
    onStart: ->
      Session.set 'complete', false
      document.title = 'go!'
    onComplete: ->
      Session.set 'complete', true
      Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.type':null}})
      Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.minute':null}})
      document.title = 'done!'
      notification = new Notification("All done!", {icon: 'img/tomato.png'});
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


init = ->
  Roma.timer = new (Roma.Timer)(2,
    onUpdate: (t) ->
      Session.set 'time', t
    onStart: ->
      Session.set 'complete', false
      document.title = 'go!'
    onComplete: ->
      Session.set 'complete', true
      Meteor.users.update({_id:Meteor.user()._id}, {$set:{'profile.pomo.type':null}})
      document.title = 'done!'
)

if Meteor.isClient
  Meteor.startup ->
    init()

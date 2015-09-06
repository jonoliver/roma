init = ->
  Roma.timer = new (Roma.Timer)(2,
    onUpdate: (t) ->
      Session.set 'time', t
      return
    onStart: ->
      Session.set 'complete', false
      return
    onComplete: ->
      Session.set 'complete', true
      return
)
  return

if Meteor.isClient
  Meteor.startup ->
    init()
    return
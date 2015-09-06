init = ->
  Roma.timer = new (Roma.Timer)(2,
    onUpdate: (t) ->
      Session.set 'time', t
      return
    onStart: ->
      Session.set 'complete', false
      document.title = 'go!'
      return
    onComplete: ->
      Session.set 'complete', true
      document.title = 'done!'
      return
)
  return

if Meteor.isClient
  Meteor.startup ->
    init()
    return
init = ->
  Roma.timer = new (Roma.Timer)(2,
    onUpdate: (t) ->
      Session.set 'time', t
    onStart: ->
      Session.set 'complete', false
      document.title = 'go!'
    onComplete: ->
      Session.set 'complete', true
      document.title = 'done!'
)

if Meteor.isClient
  Meteor.startup ->
    init()

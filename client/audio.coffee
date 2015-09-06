if Meteor.isClient
  Meteor.startup ->
    Tracker.autorun (c) ->
      if Session.equals('complete', true)
        $('#pacman')[0].play()
      return
    return
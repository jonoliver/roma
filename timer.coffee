extend = (object, properties) ->
  for key, val of properties
    object[key] = val
  object
  
class Roma.Timer
  constructor: (minutes, events) ->
    @minutes = minutes || 25
    @seconds = 0
    @started = false
    @interval = null
    @intervalTime = 10
    @events = extend {
      onUpdate: ->
      onStart: ->
      onComplete: ->
    }, events

  start: () ->
    unless @started
      @interval = Meteor.setInterval =>
        @update()
      , @intervalTime
      @started = true
      @events.onStart()
    
  stop: () ->
    Meteor.clearInterval @interval
    @started = false
    
  reset: (minutes) ->
    @stop()
    @minutes = minutes
    @seconds = 0
    @events.onUpdate(@format())
    @start()
    
  update: () ->
    if @seconds == 0
      if @minutes == 0
        @stop()
        @events.onComplete()
      else 
        @seconds = 59
        @minutes--
    else
      @seconds--
    @events.onUpdate(@format())
    
  format: () ->
    seconds = if @seconds < 10 then "0#{@seconds}" else @seconds
    "#{@minutes}:#{seconds}"
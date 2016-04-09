class Roma.Timer
  constructor: (minutes, events) ->
    @totalMinutes = minutes || 25
    @minutes = 0
    @seconds = 0
    @started = false
    @interval = null
    @intervalTime = 100
    @startingTime = 0
    @totalSeconds = 0
    
    @events = _.extend {
      onUpdate: ->
      onStart: ->
      onComplete: ->
      onMinute: ->
    }, events

  start: ->
    unless @started
      @startingTime = new Date().getTime()
      @totalSeconds = 0
      @interval = Meteor.setInterval =>
        @update()
      , @intervalTime
      @started = true
      @events.onStart()
      @events.onMinute(@minutes)

    
  stop: ->
    Meteor.clearInterval @interval
    @started = false
    
  reset: (minutes) ->
    @stop()
    @totalMinutes = minutes
    @minutes = 0
    @seconds = 0
    @start()

  update: ->
    @events.onMinute(@totalMinutes - @minutes) if @seconds == 0
    @updateCounts()
    if @minutes == @totalMinutes
      @stop()
      @events.onComplete()

    # TODO: change to onSecond, only update when second changes
    @events.onUpdate(@format())

  updateCounts: ->
    currentTime = new Date().getTime()
    @totalSeconds = Math.floor((currentTime - @startingTime)/100)
    @seconds = @totalSeconds % 60
    @minutes = Math.floor(@totalSeconds / 60)

  format: ->
    seconds = if @seconds == 0 then 0 else 60 - @seconds 
    seconds = if seconds < 10 then "0#{seconds}" else seconds
    minutes = if @seconds == 0 then @totalMinutes - @minutes else @totalMinutes - @minutes - 1
    "#{minutes}:#{seconds}"
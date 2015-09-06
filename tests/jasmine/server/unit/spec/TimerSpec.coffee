describe "Timer", ()->
  it 'runs a test', ()->
    expect(Roma.Timer).toBeDefined()

  it 'creates an instance', ()->
    timer = new Roma.Timer()
    timer.start()
    expect(1).toEqual(1)
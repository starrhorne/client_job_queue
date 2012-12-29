# use require to load any .js file available to the asset pipeline
#= require jquery
#= require jquery_ujs
#= require client_job_queue

describe "JobHandler", ->

  handler = (options) -> options

  dispatcher = null

  beforeEach ->
    dispatcher = new JobDispatcher()

  describe "#isBound", ->

    it "returns false when no handler is bound to an event", ->
      expect(dispatcher.isBound("blah")).toBe(false)
      expect(dispatcher.isBound("blah", handler)).toBe(false)
      
    it "returns true when a handler is bound to an event", ->
      dispatcher.bind("blah", handler)
      expect(dispatcher.isBound("blah", handler)).toBe(true)


  describe "#unbind", ->
    
    it "returns identity", ->
      expect(dispatcher.unbind()).toBe(dispatcher)
      expect(dispatcher.unbind("blah")).toBe(dispatcher)
      expect(dispatcher.unbind("blah", handler)).toBe(dispatcher)

    it "removes a handler from the event", ->
      expect(dispatcher.isBound("blah")).toBe(false)
      dispatcher.bind("blah", handler)
      expect(dispatcher.isBound("blah", handler)).toBe(true)
      dispatcher.unbind("blah", handler)
      expect(dispatcher.isBound("blah")).toBe(false)


  describe "#trigger", ->
    it "returns identity", ->
      expect(dispatcher.trigger("blah")).toBe(dispatcher)

    it "calls handlers", ->
      x = y = 0
      dispatcher.bind("blah", -> x = 1)
      dispatcher.bind("blah", -> y = 2)
      dispatcher.trigger("blah")
      expect(x).toBe(1)
      expect(y).toBe(2)


  describe "#bindMultiple", ->
    it "returns identity", ->
      expect(dispatcher.bindMultiple({})).toBe(dispatcher)
      
    it "binds multiple handlers", ->
      fn1 = -> null
      fn2 = -> null
      dispatcher.bindMultiple(fn1: fn1, fn2: fn2)
      expect(dispatcher.isBound("fn1", fn1)).toBe(true)
      expect(dispatcher.isBound("fn2", fn2)).toBe(true)

  describe "#constructor", ->

    it "binds multiple handlers", ->
      fn1 = -> null
      fn2 = -> null
      d = new JobDispatcher(fn1: fn1, fn2: fn2)
      expect(d.isBound("fn1", fn1)).toBe(true)
      expect(d.isBound("fn2", fn2)).toBe(true)






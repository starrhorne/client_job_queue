class window.JobDispatcher

  _events: {}

  constructor: (callbacks={}) ->
    @bindMultiple(callbacks)

  bind: (name, callback) =>
    (@_events[name] ||= []).push(callback)
    @

  bindMultiple: (events = {}) =>
    @bind(name, callback) for name, callback of events
    @

  isBound: (name, callback) =>
    !!(@_events[name] && (callback in @_events[name]))

  unbind: (name, callback) =>
    if @_events[name]
      @_events[name] = @_events[name].filter (otherCallback) -> callback == otherCallback 
    @

  trigger: (name, options) =>
    callback?(options) for callback in (@_events[name] || [])
    @



class window.JobQueue

  constructor:  (@name, handlers) ->
    @dispatcher = new JobDispatcher(handlers)
    queuedJobs = JobCookie.getJSON(@name) 
    JobCookie.delete(@name)
    @enqueue(queuedJobs)

  enqueue: (items) =>
    return unless items
    @work(job, options) for [job, options] in items
    @


  work: (job, options) =>
    @dispatcher.trigger("before", [job, options])
    @dispatcher.trigger("#{ job }:before", options)
    @dispatcher.trigger(job, options)
    @dispatcher.trigger("#{ job }:after", options)
    @dispatcher.trigger("after", [job, options])
    @


class window.JobCookie
  @set: (name, value, days) ->
    if days
      date = new Date
      date.setTime(date.getTime() + (days*24*60*60*1000))
      expires = "; expires=" + date.toGMTString()
    else
      expires: ""
    document.cookie = name + "=" + value + expires + "; path=/"
 
  @get: (key) ->
    key = key + "="
    for c in document.cookie.split(';')
      while c.charAt(0) is ' '
        c = c.substring(1, c.length) 
      if c.indexOf(key) == 0
        return c.substring(key.length, c.length) 
    return null
  
  @getJSON: (key) ->
    eval(decodeURIComponent(@get(key)) || "[]")

  @delete: (name) ->
    @set(name, "", -1)




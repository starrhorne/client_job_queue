# use require to load any .js file available to the asset pipeline
#= require jquery
#= require jquery_ujs
#= require client_job_queue

describe "JobQueue", ->

  queueName = "someQueue"
  jobName = "someJob"
  pendingJobs = [['a', [1,2,3]], ["b", [4,5,6]]]

  queue = null
  beforeEach -> 
    spyOn(JobCookie, 'delete')
    spyOn(JobCookie, 'getJSON').andReturn(pendingJobs)
    queue = new JobQueue(queueName)

  describe "#constructor", ->

    it "creates a JobDispatcher", ->
      expect(queue.dispatcher).toBeDefined()
      expect(queue.dispatcher.bind).toBeDefined()

    it "saves the queue name", ->
      expect(queue.name).toBe(queueName)

    it "reads the cookie", ->
      expect(JobCookie.getJSON).toHaveBeenCalledWith(queueName)

    it "deletes the cookie", ->
      expect(JobCookie.delete).toHaveBeenCalledWith(queueName)

  describe "#enqueue", ->

    job = [jobName, 1]

    beforeEach -> 
      spyOn(queue.dispatcher, 'trigger')
      queue.enqueue([job])

    it "triggers before", ->
      expect(queue.dispatcher.trigger).toHaveBeenCalledWith("before", job)

    it "triggers #{ jobName }:before", ->
      expect(queue.dispatcher.trigger).toHaveBeenCalledWith("#{ jobName }:before", job[1])

    it "triggers #{ jobName }", ->
      expect(queue.dispatcher.trigger).toHaveBeenCalledWith(jobName, job[1])

    it "triggers #{ jobName }:after", ->
      expect(queue.dispatcher.trigger).toHaveBeenCalledWith("#{ jobName }:after", job[1])

    it "triggers after", ->
      expect(queue.dispatcher.trigger).toHaveBeenCalledWith("after", job)







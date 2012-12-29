module ClientJobQueue

  class Engine < ::Rails::Engine
  end

  module ControllerExtensions
    extend ActiveSupport::Concern
    protected
      def enqueue_client_job(queue_name, job_name, options)
        c = cookies[queue_name] 
        c = c.present? ? JSON.parse(c.to_s) : []
        c << [job_name, options]
        cookies[queue_name] = c.to_json
      end
  end

  ActionController::Base.send :include, ClientJobQueue::ControllerExtensions

end

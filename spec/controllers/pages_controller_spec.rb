require 'spec_helper'

describe PagesController do

  let(:job_params_1) { ["job1", ["email@test.com", { "name" => "bob" } ]] }
  let(:job_params_2) { ["job2", ["email@test.com", { "name" => "bob" } ]] }
  let(:session_key) { "myjobs" }

  example { controller.should respond_to("enqueue_client_job")  }

  context "#index" do

    before(:each) do
      get :index
    end

    example { response.should render_template("index") }

  end


  describe "#enqueue_client_job" do

    def queue
      JSON.parse(cookies[session_key])
    end

    before(:each) do
      controller.send(:enqueue_client_job, session_key, *job_params_1)
    end

    context "called once" do 
      example { queue.should be_an_instance_of(Array) }
      example { queue.should have(1).item }

      it "stores data in queue item" do
        queue.first.should == job_params_1
      end
    end

    context "called twice" do 
      before(:each) do
        controller.send(:enqueue_client_job, session_key, *job_params_2)
      end

      example { queue.should have(2).items }

      it "places 2 items in correct order" do
        queue.first.should == job_params_1
        queue.last.should == job_params_2
      end
    end
  end

end


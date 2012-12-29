class PagesController < ApplicationController

  def index
    enqueue_client_job("_client_queue", "console:log", ["starr@gmail.com", {name: "starr"}])
  end

end

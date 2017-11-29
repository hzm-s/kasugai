class ApplicationJob < ActiveJob::Base

  protected

    def render(*args, &block)
      ApplicationController.renderer.render(*args, &block)
    end
end

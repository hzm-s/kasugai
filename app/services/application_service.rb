require 'oblate'

class ApplicationService < Oblate::Service

  def transaction
    ActiveRecord::Base.transaction do
      yield
    end
  end
end

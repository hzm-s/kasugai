module ActionService
  module Results
    def success(detail = {})
      Success.new(detail)
    end

    def failure(detail = {})
      Failure.new(detail)
    end

    class Success < OpenStruct
      def succeeded?
        true
      end
    end

    class Failure < OpenStruct
      def succeeded?
        false
      end
    end
  end
end

module ActionService
  module Persistence
    def transaction
      ActiveRecord::Base.transaction do
        yield
      end
    end
  end
end

module ActionService
  class Base
    include ActionService::Results
    include ActionService::Persistence

    class << self
      def call(*args)
        new.call(*args)
      end
    end

    def call
      raise '`call` must be implemented'
    end
  end
end

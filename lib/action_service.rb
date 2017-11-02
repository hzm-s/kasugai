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

      def method_missing(method, *args, &block)
        service = new
        return super unless service.respond_to?(method)
        service.send(method, *args, &block)
      end
    end
  end
end

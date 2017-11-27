module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include UserSessionHelper

    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

      def find_verified_user
        if (user = find_remembered_user)
          user
        else
          reject_unauthorized_connection
        end
      end
  end
end

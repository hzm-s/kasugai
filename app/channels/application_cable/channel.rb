module ApplicationCable
  class Channel < ActionCable::Channel::Base

  protected

    def stream_for_other_users(model, current_user_id, publisher_key: 'publisher_id')
      stream_for(model, coder: ActiveSupport::JSON) do |message|
        if message[publisher_key] != current_user_id
          transmit(message)
        end
      end
    end
  end
end

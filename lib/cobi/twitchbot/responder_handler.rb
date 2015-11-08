require 'cobi/twitchbot/handler'

module Cobi; module Twitchbot
  class ResponderHandler < Handler
    def handle_event(bot, event_name, *parameters)
      send(event_name.to_sym, bot, *parameters) if respond_to?(event_name.to_sym)
    end
  end
end; end

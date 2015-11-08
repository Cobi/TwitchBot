require 'cobi/twitchbot/responder_handler'

module Cobi; module Twitchbot; module Modules
  class Ping < Cobi::Twitchbot::ResponderHandler
    def command_ping(bot, data)
      bot.pong(data.args.first)
    end
  end
end; end; end

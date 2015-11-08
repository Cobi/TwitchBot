require 'cobi/twitchbot/responder_handler'

module Cobi; module Twitchbot; module Modules
  class Hello < Cobi::Twitchbot::ResponderHandler
    def chat_command_hello(bot, args, data)
      bot.msg('#jacobicarter', "Hello, #{data.tags[:display_name]}!")
    end
  end
end; end; end

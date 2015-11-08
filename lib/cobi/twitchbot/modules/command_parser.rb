require 'cobi/twitchbot/responder_handler'

module Cobi; module Twitchbot; module Modules
  class CommandParser < Cobi::Twitchbot::ResponderHandler
    def command_privmsg(bot, data)
      return unless data.args[0] == '#jacobicarter'
      return unless data.args[1][0] == '!'
      command_name, *command_args = data.args[1][1..-1].split(' ')
      bot.event('chat_command', command_name.downcase, command_args, data)
      bot.event("chat_command_#{command_name.downcase}", command_args, data)
    end
  end
end; end; end

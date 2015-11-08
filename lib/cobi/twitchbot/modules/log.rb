require 'cobi/twitchbot/responder_handler'

module Cobi; module Twitchbot; module Modules
  class Log < Cobi::Twitchbot::ResponderHandler
    def raw_in(bot, line)
      puts line
    end

    def chat_command(bot, command, command_args, line)
      puts "COMMAND >>> #{command} (#{command_args.join(', ')}) <<<"
    end
  end
end; end; end

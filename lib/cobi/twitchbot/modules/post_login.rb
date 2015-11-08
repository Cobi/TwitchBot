require 'cobi/twitchbot/responder_handler'

module Cobi; module Twitchbot; module Modules
  class PostLogin < Cobi::Twitchbot::ResponderHandler
    def command_376(bot, data)
      bot.raw('CAP REQ :twitch.tv/commands')
      bot.raw('CAP REQ :twitch.tv/membership')
      bot.raw('CAP REQ :twitch.tv/tags')
      bot.join('#jacobicarter')
    end
  end
end; end; end

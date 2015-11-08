require 'cobi/twitchbot/responder_handler'
require 'net/http'
require 'uri'
require 'json'
require 'time'
require 'action_view'
require 'action_view/helpers'

module Cobi; module Twitchbot; module Modules
  class Uptime < Cobi::Twitchbot::ResponderHandler
    include ActionView::Helpers::DateHelper
    def chat_command_uptime(bot, args, data)
      response = JSON.parse(Net::HTTP.get(URI('https://api.twitch.tv/kraken/streams/jacobicarter')), :symbolize_names => true)
      created_at = Time.parse(response[:stream][:created_at])
      bot.msg('#jacobicarter', "The stream has been up for #{time_ago_in_words(created_at)}")
    end
  end
end; end; end

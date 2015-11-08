require 'cobi/twitchbot/irc/irc_message'

module Cobi; module Twitchbot; module Irc
  class DirectIrcMessage < Cobi::Twitchbot::Irc::IrcMessage
    attr_reader :command, :args, :tags

    def initialize(command, args, tags)
      @command = command
      @args = args
      @tags = tags
    end

    def direct?
      true
    end
  end
end; end; end

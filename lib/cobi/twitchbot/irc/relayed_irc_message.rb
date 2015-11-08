require 'cobi/twitchbot/irc/irc_message'

module Cobi; module Twitchbot; module Irc
  class RelayedIrcMessage < Cobi::Twitchbot::Irc::IrcMessage
    attr_reader :source, :command, :args, :tags

    def initialize(source, command, args, tags)
      @source = source
      @command = command
      @args = args
      @tags = tags
    end

    def direct?
      false
    end
  end
end; end; end

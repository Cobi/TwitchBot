module Cobi; module Twitchbot; module Irc
  class IrcSource
    attr_reader :nick, :user, :host

    def initialize(nick, user, host)
      @nick = nick
      @user = user
      @host = host
    end

    def server
      @host
    end

    def server?
      @nick == nil
    end

    def self.parse(encoded)
      if !encoded.include?("!") && !encoded.include?("@") && encoded.include?(".")
        new(nil, nil, encoded)
      else
        nick, user_host = encoded.split('!')
        unless user_host.nil?
          user, host = user_host.split('@')
        else
          user = host = nil
        end
        new(nick, user, host)
      end
    end
  end
end; end; end

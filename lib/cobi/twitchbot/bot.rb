require 'cobi/twitchbot/irc/direct_irc_message'
require 'cobi/twitchbot/irc/relayed_irc_message'
require 'cobi/twitchbot/irc/irc_source'
require 'socket'

module Cobi; module Twitchbot
  class Bot
    def initialize(server, port, nickname, password)
      @server = server
      @port = port
      @nickname = nickname
      @password = password
      @handlers = []
    end

    def connect!
      @socket = TCPSocket.new(@server, @port)
      event('connected')
      raw("PASS #{@password}")
      raw("NICK #{@nickname}")
      raw("USER #{@nickname} 1 1 :#{@nickname}")
      event('authenticated')
    end

    def disconnect!
      @socket.close
    end

    def register(handler)
      @handlers << handler
    end

    def raw(message)
      event('raw_out', message)
      @socket.puts(message)
    end

    def fix_irc_args(args)
      args.reduce({ :out => [], :seen => false }) do |m, e|
        if m[:seen]
          m[:out].reverse.first.concat(' ' + e)
        elsif e[0] == ':'
          m[:seen] = true
          m[:out] << e[1..-1]
        else
          m[:out] << e
        end
        m
      end[:out]
    end

    def parse_irc(message)
      if message[0] == '@'
        tags, message = message[1..-1].split(' ', 2)
        tags = Hash[tags.split(';').map do |tag|
          key, value = tag.split('=', 2)
          [key.gsub(/-/, '_').to_sym, value]
        end]
      else
        tags = {}
      end
      if message[0] == ':'
        source, command, *args = message[1..-1].split(' ')
        Cobi::Twitchbot::Irc::RelayedIrcMessage.new(Cobi::Twitchbot::Irc::IrcSource.parse(source), command.downcase, fix_irc_args(args), tags)
      else
        command, *args = message.split(' ')
        Cobi::Twitchbot::Irc::DirectIrcMessage.new(command, fix_irc_args(args), tags)
      end
    end

    def event(event_name, *parameters)
      @handlers.each do |handler|
        handler.handle_event(self, event_name, *parameters)
      end
    end

    def main_loop
      until @socket.eof?
        line = @socket.gets
        break if line.nil?
        event('raw_in', line)
        data = parse_irc(line)
        event('parsed_in', data)
        event("command_#{data.command}", data)
      end
    end

    def run
      connect!
      main_loop
    end

    def pong(message)
      raw("PONG :#{message}")
    end

    def ping(message)
      raw("PING :#{message}")
    end

    def join(channel)
      raw("JOIN :#{channel}")
    end

    def msg(channel, message)
      raw("PRIVMSG #{channel} :#{message}")
    end
  end
end; end

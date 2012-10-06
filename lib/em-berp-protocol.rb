require "em-berp-protocol/version"
require 'bert'

module EventMachine
  module Protocols
    module BerpProtocol
      def receive_data(data)
        (@buf ||= '') << data

        while @buf.size >= 4
          if @buf.size >= 4+(size = @buf.unpack('N').first)
            @buf.slice!(0,4)
            receive_object(BERT.decode(@buf.slice!(0,size)))
          else
            break
          end
        end
      end

      # Invoked with ruby objects received over the network
      def receive_object(obj)
        # stub
      end

      # Sends a ruby object over the network
      def send_object(obj)
        data = BERT.encode(obj)
        send_data([data.respond_to?(:bytesize) ? data.bytesize : data.size, data].pack('Na*'))
      end
    end
  end
end

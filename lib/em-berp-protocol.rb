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
            begin
              slice = @buf.slice!(0,size)
              receive_object(BERT.decode(slice))
            rescue TypeError => e
              handle_bert_error("TypeError: #{e}")
            rescue EOFError => e
              handle_bert_error("EOFError: #{e} with data #{slice.inspect}")
            end
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

      private

      def handle_bert_error(message)
        remote_port, *remote_ip = get_peername[2,6].unpack("nC4")
        receive_error("#{message} from client #{remote_ip.join('.')}:#{remote_port}") if respond_to? :receive_error
        close_connection
      end
    end
  end
end

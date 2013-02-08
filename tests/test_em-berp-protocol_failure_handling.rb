require 'test-helper'

class TestBerpFailureHandling < Test::Unit::TestCase
  module Server
    include EventMachine::Protocols::BerpProtocol

    def receive_error(error)
      $error = error
      EM.stop
    end
  end

  def test_receiving_invalid_magic_value
    EM.run {
      EM.start_server "127.0.0.1", 53654, Server
      assert_nothing_raised do
        s = TCPSocket.new 'localhost', 53654
        s.write [1, -3].pack("Nc") # Length 1, magic number -1
        s.close
      end
    }
    assert $error.match(/\ATypeError: Invalid magic value for BERT string from client 127\.0\.0\.1:\d+\z/)
  end

  def test_unexpected_eof_in_data_stream
    EM.run {
      EM.start_server "127.0.0.1", 53654, Server
      assert_nothing_raised do
        s = TCPSocket.new '127.0.0.1', 53654
        s.write [18, -125, 104, 2, 107, 0, 12, 99, 97, 112, 97, 98, 105, 108, 105, 116, 105, 101, 115].pack("Nc*")
        s.close
      end
    }
    assert $error.match(/\AEOFError: Unexpected end of BERT stream with data "\\x83h\\x02k\\x00\\fcapabilities" from client 127\.0\.0\.1:\d+\z/)
  end
end

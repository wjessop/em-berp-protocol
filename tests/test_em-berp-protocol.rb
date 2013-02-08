require 'test-helper'

class TestBerpProtocol < Test::Unit::TestCase
  module Server
    include EventMachine::Protocols::BerpProtocol

    def post_init
      send_object(:hello => 'world')
    end

    def receive_object(obj)
      $server = obj
      EM.stop
    end
  end

  module Client
    include EventMachine::Protocols::BerpProtocol

    def receive_object(obj)
      $client = obj
      send_object('you_said' => obj)
    end
  end

  def test_send_receive
    EM.run {
      EM.start_server "127.0.0.1", 53654, Server
      EM.connect "127.0.0.1", 53654, Client
    }

    assert($client == {:hello => 'world'})
    assert($server == {'you_said' => { :hello => 'world' }})
  end
end

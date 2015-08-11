require "multi_send/version"

module MultiSend
  # automagically figure out whether to send as a hash or array.
  #   >> 5.multi_send( :days, :ago, , :to_date, [:eql?, 5.days.ago.to_date] )
  #   => true
  def self.do(object, *messages)
    if messages.length == 1 && messages[0].is_a?(Hash)
      MultiSend.hash(object, messages[0])
    else
      MultiSend.array(object, *messages)
    end
  end

  # Sends an array of messages to self. Used like:
  #   5.send_array(:days, :ago)
  #   => (datetime object)
  # Can specify arguments by using a nested array:
  #   5.send_array( [ :+, 8 ], [ :*, 9] )
  #   => 77
  def self.array(object, *messages)
    messages.reduce(object) do |obj, message|
      obj.__send__(*message)
    end
  end

  # Sends a hash of messages to self. The keys in the hash are the message to
  # send to self and the values are the arguments. Used like:
  #   5.send_hash( :+ => 5, eql?: 10 )
  #   => true
  # Multiple arguments can be sent as an array:
  #   5.send_hash( :+ => 5, send: [:eql?, 10] )
  def self.hash(object, messages = {})
    MultiSend.array(object, *messages.map { |message, args| [message, *args] })
  end

  # If you anticipate wanting to use MultiSend a lot, you can invoke the new
  # `using` method in a class, module, or namespace. Then, instead of doing a
  # `MultiSend.do(obj, messages)` you can just do `obj.multi_send(messages)`.
  refine Object do
    def send_array(*messages)
      MultiSend.array(self, *messages)
    end

    def send_hash(messages = {})
      MultiSend.hash(self, messages)
    end

    def multi_send(*messages)
      MultiSend.do(self, *messages)
    end
  end
end

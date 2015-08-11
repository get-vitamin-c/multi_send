class Object
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

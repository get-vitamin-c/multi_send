require 'spec_helper'

require 'multi_send'

describe MultiSend do
  describe '.array' do
    let(:obj) { 5 }

    it 'sends a single message to an object' do
      expect(MultiSend.array(obj, :odd?)).to eq(true)
    end

    it 'sends chain of messages to an object' do
      expect(MultiSend.array(obj, :odd?, :to_s)).to eq("true")
    end

    it 'can put arguments via nested array' do
      expect(MultiSend.array(obj, [:+, 5], [:*, 3])).to eq(30)
    end

    it 'cannot handle an actual array correctly' do
      expect do
        MultiSend.array(obj, [:odd?, :to_s])
      end.to raise_error
    end
  end

  describe '.hash' do
    let(:obj) { "hello" }

    it 'sends message and arguments as key/value pair' do
      expect(MultiSend.hash(obj, split: '')).to eq(%w(h e l l o))
    end

    it 'sends multiple messages correctly' do
      expect(MultiSend.hash(obj, split: '', "[]": 0)).to eq("h")
    end

    it 'can do multiple args with an array' do
      expect(MultiSend.hash(obj, send: [:eql?, obj])).to eq(true)
    end
  end

  describe '.do' do
    let(:obj) { 10 }

    it 'can correctly determine to send an array' do
      expect(MultiSend.do(obj, ["+", 5], :even?, :to_s)).to eq((obj + 5).even?.to_s)
    end

    it 'can correctly determine to send a hash' do
      expect(MultiSend.do(obj, "+": 10, "/": 2)).to eq(10)
    end

    it 'sends a single argument hash correctly' do
      expect(
        MultiSend.do(obj, :+ => 1)
      ).to eq(11)
    end
  end

  describe 'refinement' do
    using MultiSend
    let(:obj) { 5 }

    it 'monkeypatches ok' do
      expect(obj.multi_send("+": 10, ">": 10)).to eq(true)
    end

    it 'allows hash' do
      expect(obj.send_hash(:+ => 8, :- => 3)).to eq(10)
    end

    it 'allows arrays' do
      expect(obj.send_array(:to_s, :to_i, :odd?)).to eq(true)
    end

    it 'allows nested arrays' do
      expect(obj.send_array(:to_s, :length, [:eql?, 1])).to eq(true)
    end

    it 'allows nested hashing' do
      expect(
        obj.send_hash(:+ => 5, send: [:==, 10])
      ).to eq(true)
    end

    it 'handles single argument hash' do
      expect(
        obj.send_hash(:+ => 5)
      ).to eq(10)
    end

    it 'multisends single hash correctly' do
      expect(
        obj.multi_send(:+ => 5)
      ).to eq(10)
    end

    it 'works with variables' do
      comp = { :+ => 5  }
      expect(
        obj.multi_send(comp)
      ).to eq(10)
    end

    it 'wait what' do
      comp = { "+" => 5 }
      expect(
        obj.multi_send(comp)
      ).to eq(10)
    end
  end
end

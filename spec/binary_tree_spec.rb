require_relative 'spec_helper'

describe BinaryTree do
  
  describe '#add' do
    let(:tree) { described_class.new }
    context 'when the tree is initially empty' do
      before { tree.add(:a, 1) }
      it { expect(tree.root).to_not be_nil }
      it { expect(tree.root.key).to be(:a) }
      it { expect(tree.root.value).to be(1)}
    end
    context 'when adding multiple elements' do
      let(:pairs) { [ [:a, 1], [:b, 2], [:c, 3], [:d, 4], [:e, 5] ] }
      before do
        pairs.sample(pairs.size).each { |pair| tree.add(pair.first, pair.last) }
      end
      let(:keys) { tree.map { |key, value| key } } 
      it 'an in-order traversal should yield the keys in order' do
        expect(keys).to eq([:a, :b, :c, :d, :e])
      end
    end
  end
  
  describe '#find' do
    let(:tree) { described_class.new }
    let(:pairs) { [ [:a, 1], [:b, 2], [:c, 3], [:d, 4], [:e, 5] ] }
    before do
      pairs.sample(pairs.size).each { |pair| tree.add(pair.first, pair.last) }
    end
    context 'when the key exists in the tree' do
      it { expect(tree.find(:a)).to eq(1) }
    end
    context 'when the key does not exist in the tree' do
      it { expect(tree.find(:z)).to be_nil }
    end
  end
  
  describe '#remove' do
    #         f
    #      /    \
    #    b       g
    #   / \ 
    #  a   d
    #      /\
    #     c  e
    let(:pairs) { [ [:f, 6], [:b, 2], [:a, 1], [:d, 4], [:c, 3], [:e, 5], [:g, 7] ]}
    let(:tree) do
      tree = described_class.new
      pairs.each { |pair| tree.add(pair.first, pair.last) }
      return tree
    end
    
    # Using .map() should print a list of the existing keys in order -
    # that's how we can confirm the binary tree maintains its order
    context 'when the key exists in the tree' do
      context 'and when the key is a leaf node' do
        before { tree.remove(:a) }
        it { expect(tree.find(:a)).to be_nil }
        it { expect(tree.map { |keys| keys}).to eq([:b, :c, :d, :e, :f, :g]) }
      end
      context 'and when the key is a branch node' do
        before { tree.remove(:d) }
        it { expect(tree.find(:d)).to be_nil }
        it { expect(tree.map { |keys| keys}).to eq([:a, :b, :c, :e, :f, :g]) }
      end
      context 'and when the key is the root node' do
        before { tree.remove(:f) }
        it { expect(tree.find(:f)).to be_nil }
        it { expect(tree.map { |keys| keys}).to eq([:a, :b, :c, :d, :e, :g]) }
      end
    end
    context 'when called multiple times' do
      before do
        tree.remove(:a)
        tree.remove(:f)
        tree.remove(:d)
      end
      it { expect(tree.map { |keys| keys}).to eq([:b, :c, :e, :g]) }
    end
    
  end
  
end
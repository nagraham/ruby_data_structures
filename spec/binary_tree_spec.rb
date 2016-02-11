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
  
end
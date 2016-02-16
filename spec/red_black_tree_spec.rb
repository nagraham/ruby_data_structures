require 'spec_helper'

describe RedBlackTree do
  
  describe '#add' do
    context 'when inserting into an empty tree' do
      let(:empty_tree) { RedBlackTree.new }
      before { empty_tree.add(:a, 1) }
      it { expect(empty_tree.root.value).to eq(1)}
    end
    context 'when the tree has one node' do
      let(:tree) { RedBlackTree.new }
      before { tree.add(:b, 2) }
      context 'and when the new key is less than the root key' do
        before { tree.add(:a, 1) }
        it { expect(tree.root.key).to eq(:b) }
        it { expect(tree.root.left_node.key).to eq(:a) }
      end
      context 'and when the new key is greater than the root key' do
        before { tree.add(:c, 3) }
        it { expect(tree.root.key).to eq(:c) }
        it { expect(tree.root.left_node.key).to eq(:b) }
      end
    end
    context 'when the tree has two nodes' do
      let(:tree) { RedBlackTree.new }
      before do 
        tree.add(:d, 4)
        tree.add(:b, 2)
      end
      context 'and when the new key is larger than the two existing keys' do
        before { tree.add(:e, 5) }
        it { expect(tree.root.key).to eq(:d) }
        it { expect(tree.root.left_node.key).to eq(:b) }
        it { expect(tree.root.right_node.key).to eq(:e) }
      end
      context 'and when the new key is less than the two existing keys' do
        before { tree.add(:a, 1) }
        it { expect(tree.root.key).to eq(:b) }
        it { expect(tree.root.left_node.key).to eq(:a) }
        it { expect(tree.root.right_node.key).to eq(:d) }
      end
      context 'and when the new key is between the two existing keys' do
        before { tree.add(:c, 3) }
        it { expect(tree.root.key).to eq(:c) }
        it { expect(tree.root.left_node.key).to eq(:b) }
        it { expect(tree.root.right_node.key).to eq(:d) }
      end
    end
  end
end
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
        it { expect(tree.root.key).to be(:b) }
        it { expect(tree.root.left_node.key).to be(:a) }
      end
      context 'and when the new key is greater than the root key' do
        before { tree.add(:c, 3) }
        it { expect(tree.root.key).to be(:c) }
        it { expect(tree.root.left_node.key).to be(:b) }
      end
    end
  end
  
end
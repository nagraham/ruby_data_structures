require_relative 'spec_helper'

describe Tree do
  
  describe '#new' do
    let(:tree) { Tree.new }
    it { expect(tree.root).to be_nil }
  end
  
  describe '#add' do
    let(:tree) { Tree.new }
    context 'when the first key/value is added to the tree' do
      before { tree.add(:a, 1) }
      it 'root will contain that key value' do
        expect(tree.root.value).to eq(1)
      end
    end
    context 'when multiple key/values are added to the tree' do
      before do
        tree.add(:a, 1)
        tree.add(:b, 2)
        tree.add(:c, 3)
        tree.add(:d, 4)
      end
      it 'will add the values in a breath-first manner' do
        expect(tree.root.value).to eq(1)
        expect(tree.root.left_node.value).to eq(2)
        expect(tree.root.right_node.value).to eq(3)
        expect(tree.root.left_node.left_node.value).to eq(4)
      end
    end
  end
  
  # describe '#each' do
  #   let(:tree) { Tree.new }
  #   before do
  #     tree.add(:b, 23)
  #     tree.add(:c, 12)
  #     tree.add(:a, 4)
  #     tree.add(:e, 64)
  #     tree.add(:g, 78)
  #     tree.add()
  #   end
  #   context 'with in order algorithm' do
  #
  #   end
  # end
  
end
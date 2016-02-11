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
        pairs = [[:a, 1], [:b, 2], [:c, 3], [:d, 4], [:e, 5], [:f, 6], [:g, 7]]
        pairs.each { |p| tree.add(p.first, p.last) }
      end
      it 'will add the values in a breadth-first manner' do
        expect(tree.root.value).to eq(1)
        expect(tree.root.left_node.value).to eq(2)
        expect(tree.root.right_node.value).to eq(3)
        expect(tree.root.left_node.left_node.value).to eq(4)
        expect(tree.root.left_node.right_node.value).to eq(5)
        expect(tree.root.right_node.left_node.value).to eq(6)
        expect(tree.root.right_node.right_node.value).to eq(7)
      end
    end
  end
  
  # Tree:
  #        a
  #    b        c
  #  d   e    f   g
  describe '#each' do
    let(:tree) { Tree.new }
    before do
      pairs = [[:a, 1], [:b, 2], [:c, 3], [:d, 4], [:e, 5], [:f, 6], [:g, 7]]
      pairs.each { |p| tree.add(p.first, p.last) }
    end
    context 'with the in-order algorithm' do
      let(:target_values) { [4, 2, 5, 1, 6, 3, 7] }
      before { tree.traversal = :in_order }
      let(:in_order_values) do
        values = []
        tree.each { |key, value| values << value }
        values
      end
      it 'should iterate through the tree in an "in-order" sequence' do
        expect(in_order_values).to eq(target_values)
      end
    end
    context 'with the pre-order algorithm' do
      let(:target_values) { [1, 2, 4, 5, 3, 6, 7] }
      before { tree.traversal = :pre_order }
      let(:pre_order_values) do
        values = []
        tree.each { |key, value| values << value }
        values
      end
      it 'should iterate through the tree in a "pre-order" sequence' do
        expect(pre_order_values).to eq(target_values)
      end
    end
    context 'with the post-order algorithm' do
      let(:target_values) { [4, 5, 2, 6, 7, 3, 1] }
      before { tree.traversal = :post_order }
      let(:post_order_values) do
        values = []
        tree.each { |key, value| values << value }
        values
      end
      it 'should iterate through the tree in a "post-order" sequence' do
        expect(post_order_values).to eq(target_values)
      end
    end
    context 'with the breadth-first algorithm' do
      let(:target_values) { [1, 2, 3, 4, 5, 6, 7] }
      before { tree.traversal = :breadth_first }
      let(:breadth_first_values) do
        values = []
        tree.each { |key, value| values << value }
        values
      end
      it 'should iterate through the tree in a "breadth-first" sequence' do
        expect(breadth_first_values).to eq(target_values)
      end
    end
  end
end
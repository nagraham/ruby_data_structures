require_relative 'spec_helper'

describe Tree do
  
  describe '#new' do
    let(:tree) { Tree.new }
    it { expect(tree.root).to be_nil }
  end
  
end
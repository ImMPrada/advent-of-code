require 'spec_helper'

RSpec.describe Confirmation do
  describe ',confirm' do
    it 'returns true' do
      expect(described_class.confirm).to be(true)
    end
  end
end

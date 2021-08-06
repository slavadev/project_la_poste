# frozen_string_literal: true

RSpec.describe LaPoste::ProvidersSources::InMemory do
  let(:provider_source) { described_class.new }

  describe "#providers" do
    subject(:providers) { provider_source.providers }

    it "loads default providers" do
      expect(providers.keys).to match_array(["LP", "MR"])
    end

    it "loads correct sizes" do
      expect(providers["LP"].sizes).to match_array(["S", "M", "L"])
    end

    it "loads correct prices" do
      expect(providers["LP"].price_for_size("S")).to eq(1.5)
    end
  end
end

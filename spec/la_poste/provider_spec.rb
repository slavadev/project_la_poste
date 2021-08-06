# frozen_string_literal: true

RSpec.describe LaPoste::Provider do
  let(:provider) { described_class.new(code, size_prices) }
  let(:code) { "LP" }
  let(:size_prices) { { "S" => 1.5, "M" => 4.9, "L" => 6.9 } }

  describe "#initialize" do
    it "sets code from params" do
      expect(provider.code).to eq(code)
    end
  end

  describe "sizes" do
    subject { provider.sizes }

    it { is_expected.to match_array(["S", "M", "L"]) }
  end

  describe "price_for_size" do
    subject { provider.price_for_size(size) }

    context "when M" do
      let(:size) { "M" }

      it { is_expected.to eq(4.9) }
    end

    context "when L" do
      let(:size) { "L" }

      it { is_expected.to eq(6.9) }
    end

    context "when not existing" do
      let(:size) { "XS" }

      it { is_expected.to be_nil }
    end
  end
end

# frozen_string_literal: true

RSpec.describe LaPoste::Rules::SetPrice do
  let(:rule) { described_class.new(providers_source) }
  let(:providers_source) { LaPoste::ProvidersSources::InMemory.new }

  describe "#call" do
    subject(:apply) { rule.call(transaction) }

    context "when one provider" do
      let(:transaction) { LaPoste::Transaction.new(Date.today, "LP", "S") }

      it "sets full price from the provider" do
        apply
        expect(transaction.full_price).to eq(1.5)
      end
    end

    context "when another provider" do
      let(:transaction) { LaPoste::Transaction.new(Date.today, "MR", "M") }

      it "sets full price from the provider" do
        apply
        expect(transaction.full_price).to eq(3.0)
      end
    end
  end
end

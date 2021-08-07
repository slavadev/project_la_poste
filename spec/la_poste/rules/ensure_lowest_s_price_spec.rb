# frozen_string_literal: true

RSpec.describe LaPoste::Rules::EnsureLowestSPrice do
  let(:rule) { described_class.new(providers_source) }
  let(:providers_source) { LaPoste::ProvidersSources::InMemory.new }
  let(:transaction) { LaPoste::Transaction.new(Date.today, "LP", size) }
  let(:size) { "S" }
  let(:min_price) { 1.5 }

  describe "#call" do
    subject(:apply) { rule.call(transaction) }

    context "when full price is higer than minimum" do
      before do
        transaction.full_price = 2.0
      end

      it "sets the discount" do
        apply
        expect(transaction.discount).to eq(0.5)
      end
    end

    context "when full price is same than minimum" do
      before do
        transaction.full_price = 1.5
      end

      it "does not set the discount" do
        apply
        expect(transaction.discount).to eq(0)
      end
    end

    context "when full price is lower than minimum" do
      before do
        transaction.full_price = 1.0
      end

      it "does not set the discount" do
        apply
        expect(transaction.discount).to eq(0)
      end
    end

    context "when full price is higer than minimum but there is already a discount" do
      before do
        transaction.full_price = 2.0
        transaction.discount = 1.0
      end

      it "does not change the discount" do
        apply
        expect(transaction.discount).to eq(1.0)
      end
    end

    context "when size is not S" do
      let(:size) { "M" }

      before do
        transaction.full_price = 10.0
      end

      it "does not set the discount" do
        apply
        expect(transaction.discount).to eq(0)
      end
    end
  end
end

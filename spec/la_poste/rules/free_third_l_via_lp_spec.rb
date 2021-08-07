# frozen_string_literal: true

RSpec.describe LaPoste::Rules::FreeThirdLViaLP do
  let(:rule) { described_class.new }
  let(:transaction) { LaPoste::Transaction.new(Date.today, provider_code, size) }
  let(:provider_code) { "LP" }
  let(:size) { "L" }

  before do
    transaction.full_price = 5.0
  end

  describe "#call" do
    subject(:apply) { rule.call(transaction) }

    RSpec.shared_examples "adds discount" do
      it "adds full discount" do
        apply
        expect(transaction.discounted_price).to eq(0)
      end
    end

    RSpec.shared_examples "does not add discount" do
      it "does not add discount" do
        apply
        expect(transaction.discount).to eq(0)
      end
    end

    context "when it's a third L sized LP package this month" do
      before do
        2.times do
          rule.call(LaPoste::Transaction.new(Date.today, "LP", "L"))
        end
      end

      include_examples "adds discount"
    end

    context "when it's a fourth L sized LP package this month" do
      before do
        3.times do
          rule.call(LaPoste::Transaction.new(Date.today, "LP", "L"))
        end
      end

      include_examples "does not add discount"
    end

    context "when it's a third M sized LP package this month" do
      let(:size) { "M" }

      before do
        2.times do
          rule.call(LaPoste::Transaction.new(Date.today, "LP", "M"))
        end
      end

      include_examples "does not add discount"
    end

    context "when it's a third L sized MR package this month" do
      let(:provider_code) { "MR" }

      before do
        2.times do
          rule.call(LaPoste::Transaction.new(Date.today, "MR", "L"))
        end
      end

      include_examples "does not add discount"
    end

    context "when it's a third L sized LP package in two months" do
      before do
        2.times do
          rule.call(LaPoste::Transaction.new(Date.today.prev_month, "LP", "L"))
        end
      end

      include_examples "does not add discount"
    end
  end
end

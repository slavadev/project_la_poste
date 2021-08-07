# frozen_string_literal: true

RSpec.describe LaPoste::Rules::MonthlyLimitDiscount do
  let(:rule) { described_class.new }
  let(:transaction) { LaPoste::Transaction.new(Date.today, "LP", "L") }
  let(:discount) { 5 }

  before do
    transaction.full_price = 50
    transaction.discount = discount
  end

  describe "#call" do
    subject(:apply) { rule.call(transaction) }

    context "when discount used this month is 9" do
      before do
        prev_transaction = LaPoste::Transaction.new(Date.today, "LP", "L")
        prev_transaction.full_price = 50
        prev_transaction.discount = 9
        rule.call(prev_transaction)
      end

      it "limits discount" do
        expect { apply }.to change { transaction.discount }.from(5).to(1)
      end
    end

    context "when discount used this month is 10" do
      before do
        prev_transaction = LaPoste::Transaction.new(Date.today, "LP", "L")
        prev_transaction.full_price = 50
        prev_transaction.discount = 10
        rule.call(prev_transaction)
      end

      it "limits discount" do
        expect { apply }.to change { transaction.discount }.from(5).to(0)
      end
    end

    context "when discount used last month is 10" do
      before do
        prev_transaction = LaPoste::Transaction.new(Date.today.prev_month, "LP", "L")
        prev_transaction.full_price = 50
        prev_transaction.discount = 10
        rule.call(prev_transaction)
      end

      it "does not limit discount" do
        expect { apply }.not_to(change { transaction.discount })
      end
    end

    context "when one discount is bigger than 10" do
      let(:discount) { 15 }

      it "limits discount" do
        expect { apply }.to change { transaction.discount }.from(15).to(10)
      end
    end
  end
end

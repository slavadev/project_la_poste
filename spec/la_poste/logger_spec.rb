# frozen_string_literal: true

RSpec.describe LaPoste::Logger do
  let(:logger) { described_class.new(ios) }
  let(:ios) { instance_spy("IO") }

  describe "#log_transaction" do
    subject(:log) { logger.log_transaction(transaction) }

    let(:transaction) { LaPoste::Transaction.new(date, "LP", "S") }
    let(:date) { Date.new(2021, 1, 2) }

    before { transaction.full_price = 3.9 }

    context "when transaction doesn't have discount" do
      it "puts line to the stream" do
        log
        expect(ios).to have_received(:puts).with("2021-01-02 S LP 3.90 -")
      end
    end

    context "when transaction has discount" do
      before { transaction.discount = 1 }

      it "puts line to the stream" do
        log
        expect(ios).to have_received(:puts).with("2021-01-02 S LP 2.90 1.00")
      end
    end
  end

  describe "#log_invalid_transaction_error" do
    subject(:log) { logger.log_invalid_transaction_error(error) }

    let(:error) { LaPoste::InvalidTransactionError.new(msg) }
    let(:msg) { "Wrong line" }

    it "puts line to the stream" do
      log
      expect(ios).to have_received(:puts).with("Wrong line")
    end
  end
end

# frozen_string_literal: true

RSpec.describe LaPoste::TransactionProducers::FromFile do
  let(:producer) { described_class.new(filename, providers_source) }
  let(:providers_source) { LaPoste::ProvidersSources::InMemory.new }

  describe ".initialize" do
    context "when there file is not found" do
      let(:filename) { "spec/support/input_not_found.txt" }

      it "raises an error" do
        expect { producer }.to raise_error(Errno::ENOENT)
      end
    end
  end

  describe "#next" do
    subject(:transaction) { producer.next }

    context "when it's a first line" do
      let(:filename) { "spec/support/input_big.txt" }

      it "returns a transaction with a correct date" do
        expect(transaction.date).to eq(Date.new(2015, 2, 1))
      end

      it "returns a transaction with a correct provider code" do
        expect(transaction.provider_code).to eq("MR")
      end

      it "returns a transaction with a correct size" do
        expect(transaction.size).to eq("S")
      end
    end

    context "when it's a sixth line" do
      let(:filename) { "spec/support/input_big.txt" }

      before { 5.times { producer.next } }

      it "returns a transaction with a correct date" do
        expect(transaction.date).to eq(Date.new(2015, 2, 6))
      end

      it "returns a transaction with a correct provider code" do
        expect(transaction.provider_code).to eq("LP")
      end

      it "returns a transaction with a correct size" do
        expect(transaction.size).to eq("L")
      end
    end

    context "when there is no more lines" do
      let(:filename) { "spec/support/input_small.txt" }

      before { producer.next }

      it { is_expected.to be_nil }
    end

    context "when there file is empty" do
      let(:filename) { "spec/support/input_empty.txt" }

      it { is_expected.to be_nil }
    end

    RSpec.shared_examples "raises InvalidTransactionError" do
      it "raises an invalid transaction error" do
        expect { transaction }.to raise_error(LaPoste::InvalidTransactionError)
      end
    end

    context "when line has wrong date format" do
      let(:filename) { "spec/support/input_wrong_date.txt" }

      include_examples "raises InvalidTransactionError"

      it "returns an error with correct message" do
        transaction
      rescue LaPoste::InvalidTransactionError => e
        expect(e.message).to eq("01.12.2001 S MR Ignored")
      end
    end

    context "when line has wrong format" do
      let(:filename) { "spec/support/input_wrong_format.txt" }

      include_examples "raises InvalidTransactionError"
    end

    context "when line has wrong provider" do
      let(:filename) { "spec/support/input_wrong_provider.txt" }

      include_examples "raises InvalidTransactionError"
    end

    context "when line has wrong size" do
      let(:filename) { "spec/support/input_wrong_size.txt" }

      include_examples "raises InvalidTransactionError"
    end
  end
end

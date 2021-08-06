# frozen_string_literal: true

RSpec.describe LaPoste::Transaction do
  describe "#initialize" do
    subject(:transaction) { described_class.new(date, provider_code, size) }

    let(:date) { Date.today }
    let(:provider_code) { "LP" }
    let(:size) { "S" }

    it "sets date from params" do
      expect(transaction.date).to eq(date)
    end

    it "sets provider_code from params" do
      expect(transaction.provider_code).to eq(provider_code)
    end

    it "sets size from params" do
      expect(transaction.size).to eq(size)
    end

    it "sets full price to 0" do
      expect(transaction.full_price).to eq(0)
    end

    it "sets discount to 0" do
      expect(transaction.discount).to eq(0)
    end
  end

  describe "#full_price=" do
    subject(:assignment) { transaction.full_price = new_price }

    let(:transaction) { described_class.new(Date.today, "LP", "S") }
    let(:new_price) { 10 }

    before do
      transaction.full_price = 30
      transaction.discount = 20
    end

    it "sets the full price" do
      expect { assignment }.to change { transaction.full_price }.to 10
    end

    it "adjusts the discount" do
      expect { assignment }.to change { transaction.discount }.to 10
    end
  end

  describe "#discount=" do
    subject(:assignment) { transaction.discount = new_discount }

    let(:transaction) { described_class.new(Date.today, "LP", "S") }

    before do
      transaction.full_price = 20
    end

    context "when discount is less than full price" do
      let(:new_discount) { 10 }

      it "saves the discount" do
        expect { assignment }.to change { transaction.discount }.to 10
      end
    end

    context "when discount is bigger than full price" do
      let(:new_discount) { 30 }

      it "adjusts the discount to be not bigger than the full price" do
        expect { assignment }.to change { transaction.discount }.to 20
      end
    end
  end

  describe "discounted_price" do
    subject { transaction.discounted_price }

    let(:transaction) { described_class.new(Date.today, "LP", "S") }

    before do
      transaction.full_price = 30
      transaction.discount = 20
    end

    it { is_expected.to eq(10) }
  end
end

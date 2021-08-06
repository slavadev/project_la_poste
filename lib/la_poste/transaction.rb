# frozen_string_literal: true

module LaPoste
  # Transaction contains all information about the delivery, including provider,
  # date, size, price for the customer and discount. Discount can never be
  # bigger than the full price.
  #
  # @since 0.1.0
  class Transaction
    attr_reader :date, :provider_code, :size, :full_price, :discount

    # @param [Date] date
    # @param [String] provider_code
    # @param [String] size
    def initialize(date, provider_code, size)
      @date = date
      @provider_code = provider_code
      @size = size
      @full_price = 0
      @discount = 0
    end

    # Sets the new full price for the transaction. The discount is reduced if
    # it's bigger than the new price.
    #
    # @param [Float] new_price
    #
    # @return [Float]
    def full_price=(new_price)
      @discount = [new_price, @discount].min
      @full_price = new_price
    end

    # Sets the new discount for the transaction. The discount is reduced if
    # it's bigger than the full price.
    #
    # @param [Float] new_price
    #
    # @return [Float]
    def discount=(new_discount)
      @discount = [@full_price, new_discount].min
    end

    # @return [Float]
    def discounted_price
      @full_price - @discount
    end
  end
end

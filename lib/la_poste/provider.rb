# frozen_string_literal: true

module LaPoste
  # Provider is a delivery company. It has a code and a price for each size
  # they deliver
  #
  # @since 0.1.0
  class Provider
    attr_reader :code

    # @param [String] code
    # @param [Hash<String, Float>] size_prices
    def initialize(code, size_prices)
      @code = code
      @size_prices = size_prices
    end

    # @return [Array<String>]
    def sizes
      @sizes ||= @size_prices.keys
    end

    # @param [Sring] size
    # @return [Float, nil] price for the size or nil if size is not present
    def price_for_size(size)
      @size_prices[size]
    end
  end
end

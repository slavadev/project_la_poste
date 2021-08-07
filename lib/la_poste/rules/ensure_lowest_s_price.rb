# frozen_string_literal: true

module LaPoste
  module Rules
    # EnsureLowestSPrice finds a minimum price for the S sized package amongst
    # all providers and adds corresponding discount if price is higher.
    #
    # @since 0.1.0
    class EnsureLowestSPrice
      # @param [#providers] providers_source
      def initialize(providers_source)
        @min_price = Float::INFINITY
        providers_source.providers.each_value do |provider|
          price = provider.price_for_size("S")
          next unless price

          @min_price = price if price < @min_price
        end
      end

      # @param [Transaction] transaction
      # @return [void]
      def call(transaction)
        current_price = transaction.discounted_price
        return if current_price <= @min_price

        transaction.discount = transaction.full_price - @min_price
      end
    end
  end
end

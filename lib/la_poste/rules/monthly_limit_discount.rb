# frozen_string_literal: true

module LaPoste
  module Rules
    # MonthlyLimitDiscount keeps track of all applied discounts within a month
    # and limits it to 10.
    #
    # @since 0.1.0
    class MonthlyLimitDiscount
      LIMIT = 10.0

      def initialize
        @discount_per_month = Hash.new(0)
      end

      # @param [Transaction] transaction
      # @return [void]
      def call(transaction)
        key = month_key(transaction)
        @discount_per_month[key] += transaction.discount
        delta = @discount_per_month[key] - LIMIT
        return if delta <= 0

        @discount_per_month[key] = LIMIT
        transaction.discount = transaction.discount - delta
      end

      private

      def month_key(transaction)
        transaction.date.strftime("%Y-%m")
      end
    end
  end
end

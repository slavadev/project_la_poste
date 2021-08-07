# frozen_string_literal: true

module LaPoste
  module Rules
    # FreeThirdLViaLP sets 0 price for the third L sized package via LP, but
    # only once a month.
    #
    # @since 0.1.0
    class FreeThirdLViaLP
      def initialize
        @packages_per_month = Hash.new(0)
      end

      # @param [Transaction] transaction
      # @return [void]
      def call(transaction)
        return if transaction.provider_code != "LP" || transaction.size != "L"

        key = month_key(transaction)
        @packages_per_month[key] += 1
        transaction.discount = transaction.full_price if @packages_per_month[key] == 3
      end

      private

      def month_key(transaction)
        transaction.date.strftime("%Y-%m")
      end
    end
  end
end

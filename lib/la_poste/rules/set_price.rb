# frozen_string_literal: true

module LaPoste
  module Rules
    # SetPrice uses providers source to set price for a given transaction
    #
    # @since 0.1.0
    class SetPrice
      # @param [#providers] providers_source
      def initialize(providers_source)
        @providers = providers_source.providers
      end

      # @param [Transaction] transaction
      # @return [void]
      def call(transaction)
        provider = @providers[transaction.provider_code]
        price = provider.price_for_size(transaction.size)
        transaction.full_price = price
      end
    end
  end
end

# frozen_string_literal: true

module LaPoste
  module ProvidersSources
    # InMemory loads list of the providers saved in memory
    #
    # @since 0.1.0
    class InMemory
      PROVIDERS_HASH = {
        "LP" => { "S" => 1.5, "M" => 4.9, "L" => 6.9 },
        "MR" => { "S" => 2.0, "M" => 3.0, "L" => 4.0 }
      }.freeze

      # @return [Hash<String, Provider>] hash where key is code and value is a
      #   provider
      def providers
        @providers ||= PROVIDERS_HASH.map do |code, size_prices|
          [code, Provider.new(code, size_prices)]
        end.to_h
      end
    end
  end
end

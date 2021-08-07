# frozen_string_literal: true

module LaPoste
  # Logger writes information about transactions(including invalid) to provided
  # IO stream
  #
  # @since 0.1.0
  class Logger
    # @param [IO] ios
    def initialize(ios)
      @ios = ios
    end

    # @param [Transaction] transaction
    # @return [void]
    def log_transaction(transaction)
      date = transaction.date.strftime("%Y-%m-%d")
      size = transaction.size
      provider_code = transaction.provider_code
      price = format("%.2f", transaction.discounted_price)
      discount = if transaction.discount.positive?
                   format("%.2f", transaction.discount)
                 else
                   "-"
                 end
      @ios.puts("#{date} #{size} #{provider_code} #{price} #{discount}")
    end

    # @param [InvalidTransactionError] error
    # @return [void]
    def log_invalid_transaction_error(error)
      @ios.puts(error.message)
    end
  end
end

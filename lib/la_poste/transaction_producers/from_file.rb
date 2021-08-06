# frozen_string_literal: true

module LaPoste
  module TransactionProducers
    # FromFile reads the file and produces transaction per line
    #
    # @since 0.1.0
    class FromFile
      # @param [String] filename
      # @param [#providers] provider_source
      #
      # @raise [Errno::ENOENT] if file is not found
      def initialize(filename, provider_source)
        @file = File.new(filename, "r")
        @providers = provider_source.providers
      end

      # @return [Transaction, nil] transaction or nil if there are no more
      #   transactions
      #
      # @raise [InvalidTransactionError] if line format is wrong or provider/size
      #   is not found. Provided message is an original line + "Ignored"
      def next
        line = @file.readline
        parts = split_line(line)
        date = get_date(parts[0], line)
        provider = get_provider(parts[2], line)
        size = get_size(parts[1], line, provider)
        Transaction.new(date, provider.code, size)
      rescue EOFError
        @file.close
        nil
      end

      private

      def split_line(line)
        parts = line.split
        raise_invalid_transaction_error(line) if parts.size != 3

        parts
      end

      def get_date(substr, line)
        Date.strptime(substr, "%Y-%m-%d")
      rescue Date::Error
        raise_invalid_transaction_error(line)
      end

      def get_provider(substr, line)
        provider = @providers[substr]
        raise_invalid_transaction_error(line) unless provider

        provider
      end

      def get_size(substr, line, provider)
        raise_invalid_transaction_error(line) unless provider.sizes.include?(substr)

        substr
      end

      def raise_invalid_transaction_error(line)
        raise InvalidTransactionError, "#{line.chomp} Ignored"
      end
    end
  end
end

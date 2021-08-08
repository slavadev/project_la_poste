# frozen_string_literal: true

module LaPoste
  # Controller put together all pieces depedning on requirements and should be
  # used as a main entrypoint for business logic.
  #
  # @since 0.1.0
  class Controller
    def from_file_to_stdout(filename)
      providers_source = ProvidersSources::InMemory.new
      producer = TransactionProducers::FromFile.new(filename, providers_source)
      logger = Logger.new($stdout)
      rules = build_rules(providers_source)
      process(producer, rules, logger)
    rescue Errno::ENOENT
      $stdout.puts("File \"#{filename}\" is not found")
    end

    private

    def build_rules(providers_source)
      [
        Rules::SetPrice.new(providers_source),
        Rules::EnsureLowestSPrice.new(providers_source),
        Rules::FreeThirdLViaLP.new,
        Rules::MonthlyLimitDiscount.new
      ]
    end

    def process(producer, rules, logger)
      while (transaction = next_transaction(producer, logger))
        rules.each do |rule|
          rule.call(transaction)
        end
        logger.log_transaction(transaction)
      end
    end

    def next_transaction(producer, logger)
      producer.next
    rescue InvalidTransactionError => e
      logger.log_invalid_transaction_error(e)
      retry
    end
  end
end

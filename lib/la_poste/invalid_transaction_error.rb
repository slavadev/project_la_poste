# frozen_string_literal: true

module LaPoste
  # InvalidTransactionError is raised when producer can't produce a transaction
  # from a given input or some rule marked a transaction as invalid
  #
  # @since 0.1.0
  class InvalidTransactionError < StandardError
  end
end

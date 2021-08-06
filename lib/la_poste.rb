# frozen_string_literal: true

require "date"

require_relative "la_poste/version"
require_relative "la_poste/transaction"
require_relative "la_poste/provider"
require_relative "la_poste/providers_sources/in_memory"
require_relative "la_poste/invalid_transaction_error"

# LaPoste is a module that calculates discounts for delivery transactions
module LaPoste
end

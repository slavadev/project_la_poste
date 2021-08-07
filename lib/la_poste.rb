# frozen_string_literal: true

require "date"

require_relative "la_poste/version"
require_relative "la_poste/transaction"
require_relative "la_poste/provider"
require_relative "la_poste/providers_sources/in_memory"
require_relative "la_poste/invalid_transaction_error"
require_relative "la_poste/transaction_producers/from_file"
require_relative "la_poste/logger"
require_relative "la_poste/rules/set_price"
require_relative "la_poste/rules/ensure_lowest_s_price"
require_relative "la_poste/rules/free_third_l_via_lp"

# LaPoste is a module that calculates discounts for delivery transactions
module LaPoste
end

# Base class for all M9t exceptions
class M9t::M9tError < StandardError
end

# Raised when a M9t class receives an unrecogized ':units' value
class M9t::UnitError < M9t::M9tError
end

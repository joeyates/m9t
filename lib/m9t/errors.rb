module M9t
  # Base class for all M9t exceptions
  class M9tError < StandardError
  end

  # Raised when a M9t class receives an unrecogized ':units' value
  class UnitError < M9t::M9tError
  end
end

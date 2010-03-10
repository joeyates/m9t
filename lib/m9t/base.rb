# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'

module M9t

  module Base

    def self.included(base)
      base.extend(ClassMethods)
      base.reset_options!
    end

    module ClassMethods
      def reset_options!
        @@options = self::DEFAULT_OPTIONS.clone
      end

      def options
        @@options
      end

    end

    attr_reader :value, :options

    def initialize(value, options = self.class.options.clone)
      @value, @options = value.to_f, self.class.options.merge(options)
      raise M9t::UnitError.new("Unknown units '#{ @options[:units] }'") if not self.class::KNOWN_UNITS.find_index(@options[:units])
    end

    def to_s
      value_in_units = self.class.send("to_#{ @options[:units] }", @value)
      localized_value = I18n.localize_float(value_in_units, {:format => "%0.#{ @options[:precision] }f"})

      key = 'units.' + self.class.unit_name + '.' + @options[:units].to_s
      @options[:abbreviated] ? key += '.abbreviated' : key += '.full'
      unit = I18n.t(key, {:count => value_in_units})

      "#{ localized_value }%s#{ unit }" % (@options[:abbreviated] ? '' : ' ')
    end

  end

end

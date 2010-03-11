# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'

module M9t

  module Base

    def self.included(base) #:nodoc:

      base.instance_eval do
        # Returns the classes current options - see the specific class for defaults
        def options
          @options
        end

        # Reloads the class' default options
        def reset_options!
          @options = self::DEFAULT_OPTIONS.clone # 'self::' is necessary with ruby 1.8
        end

        # The name used for i18n translations
        # E.g. M9t::Distance => 'distance'
        def measurement_name
          name.downcase.split('::')[1]
        end

        reset_options!
      end

    end

    attr_reader :value, :options

    # ==== Parameters
    # * +options+ - See individual classes for options
    def initialize(value, options = self.class.options.clone)
      @value, @options = value.to_f, self.class.options.merge(options)
      raise M9t::UnitError.new("Unknown units '#{ @options[:units] }'. Known: #{ self.class::KNOWN_UNITS.collect{|unit| unit.to_s}.join(', ') }") \
        if not self.class::KNOWN_UNITS.find_index(@options[:units])
    end

    # Returns the string representation of the measurement,
    # taking into account locale, desired units and abbreviation.
    def to_s
      value_in_units = self.class.send("to_#{ @options[:units] }", @value)
      localized_value = I18n.localize_float(value_in_units, {:format => "%0.#{ @options[:precision] }f"})

      key = 'units.' + self.class.measurement_name + '.' + @options[:units].to_s
      @options[:abbreviated] ? key += '.abbreviated' : key += '.full'
      unit = I18n.t(key, {:count => value_in_units})

      "#{ localized_value }%s#{ unit }" % (@options[:abbreviated] ? '' : ' ')
    end

  end

end

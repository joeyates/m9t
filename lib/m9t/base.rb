# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'

module M9t

  module Base

    def self.generate_conversions(klass)
      klass.instance_eval do |klass|
        def convert(from, to, value)
          value * self::CONVERSIONS[from] / self::CONVERSIONS[to]
        end

        def method_missing(name, *args, &block)
          # Define class conversion methods as required
          if name.to_s =~ /^(\w+)_to_(\w+)$/
            return send(name, args[0]) if define_conversion($1, $2)
          end
          return send(name, args[0]) if define_constructor(name)
          raise "Method '#{ name }' unknown" # TODO use standard exception
        end

        private

        def define_conversion(from, to)
          return false if not self::CONVERSIONS[from.to_sym]
          return false if not self::CONVERSIONS[to.to_sym]
          self.class.instance_exec do
            define_method("#{ from }_to_#{ to }") do |value|
              convert(from.to_sym, to.to_sym, value)
            end
          end
          true
        end

        # Define klass.unit(value) which converts the parameter
        # from the unit and returns an instance
        def define_constructor(name)
          return false if not self::CONVERSIONS[name.to_sym]
          self.class.instance_exec do
            define_method( name.to_sym ) do | *args |
              new( args[ 0 ].to_f * self::CONVERSIONS[ name ] )
            end
          end
        end
      end
    end

    def self.add_options(klass)
      klass.instance_eval do
        # Make sure derived classes get the extra methods
        def inherited(sub) #:nodoc:
          sub.instance_eval do
            M9t::Base.add_options(sub)
          end
        end

        # Returns the classes current options - see the specific class for defaults
        def options
          @options
        end

        # Reloads the class' default options
        def reset_options!
          @options = self::DEFAULT_OPTIONS.clone # 'self::' is necessary with ruby 1.8
        end

        # The name used for i18n translations
        #  M9t::Distance => 'distance'
        def measurement_name
          name.downcase.split('::')[1]
        end

        def default_unit
          self::DEFAULT_OPTIONS[:units]
        end

        reset_options!
      end
    end

    # Adds methods for handling options
    def self.included(base) #:nodoc:
      M9t::Base.add_options(base)
      M9t::Base.generate_conversions(base)
    end

    attr_reader :value, :options
    alias :to_f :value

    def initialize( value )
      @value = value.to_f
    end

    # define conversion instance methods as required
    def method_missing(name, *args, &block)
      if name.to_s =~ /^to_(\w+)$/
        return send(name) if define_conversion($1)
      end
      raise "Method '#{ name }' unknown" # TODO use standard exception
    end

    # Returns the string representation of the measurement,
    # taking into account locale, desired units and abbreviation.
    def to_s( options = {} )
      options = self.class.options.merge( options )
      units_error( options[ :units ] ) if not self.class::CONVERSIONS.has_key?( options[ :units ] )
      value_in_units = self.send("to_#{ options[:units] }")
      localized_value = I18n.localize_float(value_in_units, {:format => "%0.#{ options[:precision] }f"})

      key = 'units.' + self.class.measurement_name + '.' + options[:units].to_s
      options[:abbreviated] ? key += '.abbreviated' : key += '.full'
      unit = I18n.t(key, {:count => value_in_units})

      "#{ localized_value }%s#{ unit }" % (options[:abbreviated] ? '' : ' ')
    end

    private

    def units_error(units)
      raise M9t::UnitError.new("Unknown units '#{ units }'. Known: #{ self.class::CONVERSIONS.keys.collect{|unit| unit.to_s}.join(', ') }")
    end

    def define_conversion(to)
      return false if not self.class::CONVERSIONS[to.to_sym]
      self.class.instance_exec do
        define_method("to_#{ to }") do
          self.class.convert(self.class.default_unit, to.to_sym, self.to_f)
        end
      end
      true
    end

  end

end

# encoding: utf-8
require 'm9t/errors'
require 'm9t/i18n'

module M9t
  module Base
    def self.generate_conversions(klass)
      klass.instance_eval do |klass|
        def convert(from, to, value)
          value / self::CONVERSIONS[from] * self::CONVERSIONS[to]
        end

        # Define class conversion methods as required
        def method_missing(name, *args, &block)
          from, to = extract_from_and_to(name)
          if from
            if legal_conversion?(from, to)
              define_conversion(from, to)
              return send(name, args[0])
            end
          end
          if legal_constructor?(name)
            define_constructor(name)
            return send(name, args[0])
          end
          super
        end

        def respond_to?(name, include_all = false)
          from, to = extract_from_and_to(name)
          if from
            return true if legal_conversion?(from, to)
          end
          return legal_constructor?(name)
        end

        private

        def extract_from_and_to(name)
          if name.to_s =~ /^(\w+)_to_(\w+)$/
            [$1, $2]
          else
            nil
          end
        end

        def legal_conversion?(from, to)
          self::CONVERSIONS.include?(from.to_sym) and self::CONVERSIONS.include?(to.to_sym)
        end

        def define_conversion(from, to)
          self.class.instance_exec do
            define_method("#{ from }_to_#{ to }") do |value|
              convert(from.to_sym, to.to_sym, value)
            end
          end
        end

        def legal_constructor?(name)
          self::CONVERSIONS.include?(name.to_sym)
        end

        # Define klass.unit(value) which converts the parameter
        # from the unit and returns an instance
        def define_constructor(name)
          self.class.instance_exec do
            define_method( name.to_sym ) do | *args |
              new( args[ 0 ].to_f / self::CONVERSIONS[ name ] )
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
          name.split('::')[-1].downcase
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
      to = extract_to(name)
      if to and legal_conversion?(to)
        define_conversion(to)
        return send(name)
      end
      super
    end

    def respond_to?(name, include_all = false)
      to = extract_to(name)
      return true if to and legal_conversion?(to)
      super
    end

    # Returns the string representation of the measurement,
    # taking into account locale, desired units and abbreviation.
    def to_s( options = {} )
      options = self.class.options.merge( options )
      units_error( options[ :units ] ) if not self.class::CONVERSIONS.has_key?( options[ :units ] )
      value_in_units = self.send("to_#{ options[:units] }")
      localized_value = I18n.localize_float(value_in_units, {format: "%0.#{ options[:precision] }f"})

      key = 'units.' + self.class.measurement_name + '.' + options[:units].to_s
      options[:abbreviated] ? key += '.abbreviated' : key += '.full'
      unit = I18n.t(key, {count: value_in_units})

      "#{ localized_value }%s#{ unit }" % (options[:abbreviated] ? '' : ' ')
    end

    private

    def units_error(units)
      raise M9t::UnitError.new("Unknown units '#{ units }'. Known: #{ self.class::CONVERSIONS.keys.collect{|unit| unit.to_s}.join(', ') }")
    end

    def extract_to(name)
      if name.to_s =~ /^to_(\w+)$/
        $1
      else
        nil
      end
    end

    def legal_conversion?(to)
      self.class::CONVERSIONS.include?(to.to_sym)
    end

    def define_conversion(to)
      self.class.instance_exec do
        define_method("to_#{to}") do
          self.class.convert(self.class.default_unit, to.to_sym, self.to_f)
        end
      end
    end
  end
end


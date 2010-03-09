# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'

# Monkey patch I18n, adding:
# - handling for non-English numerical separators
module I18n

  def I18n.localize_float(f, options = {})
    format = options[:format] || '%f'
    s = format % f
    integers, decimal = s.split('.')
    integers ||= ''

    thousands_separator = I18n.t('numbers.thousands_separator')
    integers.gsub(',', thousands_separator)

    return integers if decimal.nil?

    decimal_separator = I18n.t('numbers.decimal_separator')
    integers + decimal_separator + decimal
  end
end

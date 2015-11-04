# encoding: utf-8
require 'i18n'

locales_path = File.expand_path(
  File.join('..', '..', 'locales'), File.dirname(__FILE__)
)
I18n.load_path += Dir.glob("#{ locales_path }/*.yml")
I18n.reload!

# Monkey patch I18n
# i18n does not handle localizing numbers.
# See the following GitHub issues:
# * https://github.com/svenfuchs/i18n/issues/328
# * https://github.com/svenfuchs/i18n/issues/135
# * https://github.com/svenfuchs/i18n/issues/183
module I18n
  # Handle non-English numerical separators
  # with I18n.locale = :it,
  #   I18n.localize_float(5.23) => '5,23000'
  def I18n.localize_float(float, options = {})
    format = options[:format] || '%f'
    english = format % float
    integers, decimal = english.split('.')
    integers ||= ''

    thousands_separator = I18n.t('numbers.thousands_separator')
    integers.gsub(',', thousands_separator)

    return integers if decimal.nil?

    decimal_separator = I18n.t('numbers.decimal_separator')
    integers + decimal_separator + decimal
  end
end

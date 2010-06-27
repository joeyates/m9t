# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'i18n'
require File.join(File.expand_path(File.dirname(__FILE__)), 'base')

module M9t

  # Represents atmospheric (or other) pressure
  class Pressure
    DEFAULT_OPTIONS  = {:units => :bar, :abbreviated => false, :precision => 5}
    CONVERSIONS          = {
      :bar               => 1.0,
      :pascals           => 0.00001,
      :hectopascals      => 0.001,
      :kilopascals       => 0.01,
      :inches_of_mercury => 3386.389 * 0.00001
    }

    include M9t::Base

  end

end

# encoding: utf-8

require 'rubygems' if RUBY_VERSION < '1.9'
require 'simplecov'
require 'test/unit'

if ENV[ 'COVERAGE' ]
  SimpleCov.start do
    add_filter "/test/"
  end
end

$:.unshift( File.expand_path( '../lib', File.dirname(__FILE__) ) )

require 'm9t'

# encoding: utf-8

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'httparty'
require 'httmultiparty'
require 'json'

require 'recastai/utils'
require 'recastai/errors'
require 'recastai/client'
require 'recastai/response'
require 'recastai/intent'
require 'recastai/entity'

require 'awesome_print'

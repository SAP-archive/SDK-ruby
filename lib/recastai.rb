$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'httparty'
require 'httmultiparty'
require 'json'

require 'recastai/utils'
require 'recastai/errors'
require 'recastai/client'
require 'recastai/response'
require 'recastai/sentence'
require 'recastai/entity'

require 'awesome_print'

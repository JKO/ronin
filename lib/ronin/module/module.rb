#
# Ronin - A Ruby platform for exploit development and security research.
#
# Copyright (c) 2006-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ronin/model/model'
require 'ronin/model/has_name'
require 'ronin/model/has_description'
require 'ronin/model/has_version'
require 'ronin/model/has_license'
require 'ronin/model/has_authors'
require 'ronin/platform/cacheable'

require 'parameters'

module Ronin
  module Module
    def self.included(base)
      base.send :include, Parameters,
                          Model,
                          Model::HasName,
                          Model::HasDescription,
                          Model::HasVersion,
                          Model::HasLicense,
                          Model::HasAuthors,
                          Platform::Cacheable
    end

    # 
    # Loads a module from a file.
    #
    # @param [String] path
    #   The path to the file.
    #
    # @return [Module]
    #   The loaded module.
    #
    # @see Platform::Cacheable.load_from
    #
    # @since 0.4.0
    #
    def Module.load_from(path)
      Platform::Cacheable.load_from(path)
    end

    #
    # Initializes the Ronin Module.
    #
    # @param [Hash] attributes
    #   The attributes or parameter values to initialize the module with.
    #
    # @since 0.4.0
    #
    def initialize(attributes={})
      super(attributes)

      initialize_params(attributes)
    end

    #
    # Inspects both the properties and parameters of the Ronin Module.
    #
    # @return [String]
    #   The inspected Ronin Module.
    #
    # @since 0.4.0
    #
    def inspect
      body = ''

      attribute_pairs = []

      self.attributes.each do |name,value|
        attribute_pairs << "#{name}: #{value.inspect}"
      end

      body << attribute_pairs.join(', ')

      param_pairs = []

      self.params.each do |name,param|
        param_pairs << "#{name}: #{param.value.inspect}"
      end

      body << " params: {#{param_pairs.join(', ')}}"

      return "#<#{self.class}: #{body}>"
    end
  end
end

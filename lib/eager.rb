# Copyright 2011-2012 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.
#
# Notice: The register_autoloads and eager_autoload! methods are derived
# entirely from AWS-SDK for Ruby
# https://github.com/amazonwebservices/aws-sdk-for-ruby

require 'eager/autoloader'

module Eager

  DEFAULT_AUTOLOADABLE  = {}
  DEFAULT_EAGERLOAD     = false

  attr_reader :autoloadables
  attr_accessor :eagerload

  # When this module is extended, initialize the autoload array
  def self.extended(base)
    base.reset
  end

  def register_autoloads(klass, prefix = nil, &block)
    autoloader = Eager::Autoloader.new(klass, prefix)
    autoloader.instance_eval(&block)
    autoloader.autoloads.each_pair do |const_name, file_path|
      require(file_path) if @eagerload
      @autoloadables["#{klass}::#{const_name}"] = file_path
    end
  end

  def eager_autoload!
    return if @eagerload

    @eagerload = true
    @autoloadables.values.uniq.each { |file_path| require(file_path) }
  end

  def reset
    @autoloadables  = DEFAULT_AUTOLOADABLE
    self.eagerload  = DEFAULT_EAGERLOAD
    self
  end
end

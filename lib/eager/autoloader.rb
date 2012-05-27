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

module Eager
  class Autoloader

    def initialize(klass, prefix = nil)
      @klass = klass
      @prefix = prefix || klass.name.gsub(/::/, '/').downcase
      @autoloads = {}
    end

    attr_reader :autoloads

    def autoload(const_name, file_name)
      path = "#{@prefix}/#{file_name}"
      @klass.autoload(const_name, path)
      @autoloads[const_name] = path
    end

  end
end
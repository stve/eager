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
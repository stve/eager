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

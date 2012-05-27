require 'spec_helper'

describe Eager::Autoloader do
  before(:all) do
    class FooBar; end

    module OMG
      class BBQ; end
    end
  end

  describe 'initialization' do
    it 'iniitalizes with a class' do
      lambda {
        Eager::Autoloader.new(FooBar)
      }.should_not raise_error
    end

    it 'defines an empty autoloads hash' do
      autoloader = Eager::Autoloader.new(FooBar)
      autoloader.autoloads.should be_kind_of(Hash)
    end

    it 'creates a prefix' do
      autoloader = Eager::Autoloader.new(FooBar)
      autoloader.instance_variable_get(:@prefix).should eq('foobar')
    end

    it 'creates a prefix with a modularized class' do
      autoloader = Eager::Autoloader.new(OMG::BBQ)
      autoloader.instance_variable_get(:@prefix).should eq('omg/bbq')
    end

    it 'accepts an optional prefix' do
      autoloader = Eager::Autoloader.new(FooBar, 'omg')
      autoloader.instance_variable_get(:@prefix).should eq('omg')
    end
  end

  describe '#autoload' do
    it 'calls autoload on the defined class' do
      autoloader = Eager::Autoloader.new(FooBar)

      FooBar.should_receive(:autoload).with(OMG::BBQ, 'foobar/omg/bbq')
      autoloader.autoload(OMG::BBQ, 'omg/bbq')
    end
  end
end
require 'spec_helper'

describe Eager do
  before(:all) do
    module Foo
      extend Eager
    end
  end

  after(:each) do
    Foo.reset
  end

  describe '#autoloadables' do
    it 'returns the default autoloadbles' do
      Foo.autoloadables.should eq(Eager::DEFAULT_AUTOLOADABLE)
    end
  end

  describe '#eagerload' do
    it 'returns the default eagerload configuration' do
      Foo.eagerload.should eq(Eager::DEFAULT_EAGERLOAD)
    end
  end

  describe '#eagerload=' do
    it 'assigns the eagerload configuration' do
      Foo.eagerload = true
      Foo.eagerload.should be_true
    end
  end

  context '#register_autoloads' do
    context 'when eagerload is true' do
      before do
        Foo.eagerload = true
      end

      it 'requires the file' do
        Foo.should_receive(:require).with('foo/omg')
        Foo.register_autoloads(Foo) do
          autoload :OMG, 'omg'
        end
      end

      it 'defines an autoloadble' do
        Foo.stub(:require).and_return
        Foo.register_autoloads(Foo) do
          autoload :OMG, 'omg'
        end

        Foo.autoloadables["Foo::OMG"].should eq('foo/omg')
      end
    end

    context 'when eagerload is false' do
      it 'does not require the file' do
        Foo.should_not_receive(:require)
        Foo.register_autoloads(Foo) do
          autoload :OMG, 'omg'
        end
      end
    end
  end

  describe '#eager_autoload!' do
    context 'when eagerload is true' do
      it 'no-ops' do
        Foo.eagerload = true
        Foo.eager_autoload!.should be_nil
      end
    end

    context 'when eagerload is false' do
      it 'requires registered autoloadables' do
        Foo.eagerload = false
        Foo.register_autoloads(Foo) do
          autoload :OMG, 'omg'
        end

        Foo.should_receive(:require).with('foo/omg')
        Foo.eager_autoload!
      end
    end
  end
end
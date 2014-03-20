require "behavioral/version"

module Behavioral
  def with_behaviors(*mods)
    mods.each do |mod|
      mod.instance_methods.each do |meth|
        self.define_singleton_method(meth, mod.instance_method(meth))
      end
    end
    self
  end
  
  def without_behaviors(*mods)
    mods.each do |mod|
      mod.instance_methods.each do |meth|
        self.singleton_class.send(:remove_method, meth)
      end
    end
    self
  end
end

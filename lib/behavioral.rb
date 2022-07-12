require "behavioral/version"

module Behavioral
  def self.alias_prefix
    "__behavioral_original_"
  end

  def with_behaviors(*mods)
    Array(mods).each do |mod|
      singleton_methods = self.singleton_class.instance_methods
      mod.instance_methods.each do |meth|
        Behavioral.alias_behavior(self, meth)
        self.instance_exec(meth, mod.instance_method(meth)){|m, unbound_method|
          define_singleton_method m, unbound_method
          singleton_class.send(:public, m)
        }
      end
    end
    self
  end
  
  def without_behaviors(*mods)
    Array(mods).each do |mod|
      mod.instance_methods.each do |meth|
        self.singleton_class.send(:remove_method, meth)
      end
    end
    self
  end

  def self.alias_behavior(obj, name)
    klass = obj.singleton_class
    if obj.singleton_methods.include? name
      klass.send :alias_method, :"#{Behavioral.alias_prefix}#{name}", name

      if obj.singleton_methods(false).include? name
        klass.send(:remove_method, name)
      end
    end
  end
end

require "behavioral/version"

module Behavioral
  def self.alias_prefix
    "__behavioral_original_"
  end

  def with_behaviors(*mods)
    Array(mods).each do |mod|
      mod.instance_methods.each do |meth|
        if self.singleton_class.instance_methods.include? meth
          self.singleton_class.send :alias_method, :"#{Behavioral.alias_prefix}#{meth}", meth
          self.singleton_class.send(:remove_method, meth) if self.singleton_class.instance_methods(false).include? meth
        end
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
end

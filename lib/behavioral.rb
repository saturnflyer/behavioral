require "behavioral/version"

module Behavioral
  def with_behaviors(*mods)
    Array(mods).each do |mod|
      mod.instance_methods.each do |meth|
        instance_exec(meth, mod.instance_method(meth)){|m, unbound_method|
          define_singleton_method m, unbound_method
        }
      end
    end
    self
  end
  
  def without_behaviors(*mods)
    Array(mods).each do |mod|
      mod.instance_methods.each do |meth|
        singleton_class.send(:remove_method, meth)
      end
    end
    self
  end
end

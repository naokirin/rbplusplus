module RbGCCXML
  class Node

    # Specify to Rb++ that this node is not to be wrapped
    def ignore
      cache[:ignored] = true
    end

    # Un-ignore this node, useful if there's a glob ignore and the wrapper
    # just wants a few of the classes
    def unignore
      cache[:ignored] = false
    end

    # Has this node been previously declared to not be wrapped?
    def ignored?
      !!cache[:ignored]
    end

    # Specifies that this node has been included somewhere else
    def moved_to=(val)
      cache[:moved_to] = val
    end

    # Change what the name of this node will be when wrapped into Ruby
    def wrap_as(name)
      cache[:wrap_as] = name
      self
    end

    # Where has this node moved to?
    def moved_to
      cache[:moved_to]
    end

    # Has this node been renamed
    def renamed?
      !!cache[:wrap_as]
    end

    alias_method :rbgccxml_name, :name
    def name #:nodoc:
      cache[:wrap_as] || rbgccxml_name
    end

    def cpp_name
      rbgccxml_name
    end

    # In some cases, the automatic typedef lookup of rb++ can end up
    # doing the wrong thing (for example, it can take a normal class
    # and end up using the typedef for stl::container<>::value_type).
    # Flag a given class as ignoring this typedef lookup if this
    # situation happens.
    def disable_typedef_lookup
      cache[:disable_typedef_lookup] = true
    end

    def _disable_typedef_lookup? #:nodoc:
      !!cache[:disable_typedef_lookup]
    end

    protected

    # Get this node's settings cache
    def cache
      NodeCache.get(self)
    end
  end
end

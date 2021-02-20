# frozen_string_literal: true

module Kind
  module TypeChecker
    def name
      kind.name
    end

    def ===(value)
      kind === value
    end

    def instance?(value = Undefined)
      return self === value if Undefined != value

      @__instance_func ||= ->(ck) { ->(value) { ck === value } }.(self)
    end

    def [](value)
      return value if self === value

      KIND.error!(name, value)
    end

    def or_nil(value)
      return value if self === value
    end

    def or_undefined(value)
      or_nil(value) || Undefined
    end

    def or(fallback, value = Undefined)
      return __or_func.(fallback) if Undefined === value

      instance?(value) ? value : fallback
    end

    def value(arg, default:)
      __value(arg, self[default])
    end

    def or_null(value) # :nodoc:
      KIND.null?(value) ? value : self[value]
    end

    private

      def __or_func
        @__or_func ||=
          ->(tc, fb, value) { tc.instance?(value) ? value : tc.or_null(fb) }.curry[self]
      end

      def __value(arg, default)
        self === arg ? arg : default
      end
  end

  class TypeChecker::Object # :nodoc: all
    include TypeChecker

    ResolveKindName = ->(kind, opt) do
      name = Try.(opt, :[], :name)
      name || Try.(kind, :name)
    end

    attr_reader :kind, :name

    def initialize(kind, opt)
      name = ResolveKindName.(kind, opt)

      @name = KIND.of!(::String, name)
      @kind = KIND.respond_to!(:===, kind)
    end

    private_constant :ResolveKindName
  end
end

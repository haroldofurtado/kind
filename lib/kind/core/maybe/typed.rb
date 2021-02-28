# frozen_string_literal: true

module Kind
  module Maybe
    class Typed
      include Wrappable

      def initialize(kind)
        @kind = kind
      end

      def new(arg)
        value = Result::Value.(arg)

        @kind === value ? Maybe.some(value) : Maybe.none
      end

      alias_method :[], :new

      def inspect
        "Kind::Maybe<#{@kind}>"
      end

      private

        def __call_before_expose_the_arg_in_a_block(arg)
          value = Result::Value.(arg)

          @kind === value ? value : Maybe.none
        end
    end
  end
end

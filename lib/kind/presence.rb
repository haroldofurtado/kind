# frozen_string_literal: true

module Kind
  module Presence
    extend self

    def call(object)
      return object.blank? ? nil : object if object.respond_to?(:blank?)

      return object if TrueClass === object

      return blank_str?(object) ? nil : object if String === object

      return object.empty? ? nil : object if object.respond_to?(:empty?)

      return object if object
    end

    private

      BLANK_RE = /\A[[:space:]]*\z/

      def blank_str?(object)
        object.empty? || BLANK_RE === object
      end

      private_constant :BLANK_RE
  end
end

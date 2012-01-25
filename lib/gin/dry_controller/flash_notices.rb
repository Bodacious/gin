module Gin
  module DryController
    module FlashNotices

      def self.included(base)
        base.extend(ClassMethods)
      end
      
      # Returns the flash message to be shown for the given action
      def flash_notice_on(_action)
        case class_flash_notice_value = self.class.flash_notice_on(_action)
        when Proc
          class_flash_notice_value.call(instance_variable_get("@#{resource_singular_name}"))
        else
          class_flash_notice_value
        end
      end

      module ClassMethods

        def flash_notice_on_create(message = nil)
          flash_notice_on(:create, message)
        end

        def flash_notice_on_update(message = nil)
          flash_notice_on(:update, message)
        end

        def flash_notice_on_destroy(message = nil)
          flash_notice_on(:destroy, message)
        end

        def flash_notice_on(_action, message = nil)
          _action = _action.to_sym
          @flash_notices_on ||= {}
          if message
            @flash_notices_on[_action] = message
          else
            verb_ending = _action.to_s.last == "e" ? 'd' : 'ed'
            @flash_notices_on[_action] ||= "#{resource_singular_name.titleize} successfully #{_action}#{verb_ending}!"
          end
        end

      end

    end
  end
end
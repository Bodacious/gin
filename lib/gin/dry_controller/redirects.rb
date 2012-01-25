module Gin
  module DryController
    module Redirects

      def self.included(base)
        base.extend(ClassMethods)
      end

      # Returns the url the given action should
      # redirect to upon successful completion of this
      # action.
      def redirect_url_on(_action)
        case class_redirect_url_value = self.class.redirect_url_on(_action)
        when Proc
          if class_redirect_url_value.parameters.any?
            class_redirect_url_value.call instance_variable_get("@#{resource_singular_name}")
          else
            class_redirect_url_value.call
          end
        else
          class_redirect_url_value
        end        
      end

      module ClassMethods

        def redirect_url_on_create(url_or_proc = nil)
          redirect_url_on(:create, url_or_proc)
        end

        def redirect_url_on_update(url_or_proc = nil)
          redirect_url_on(:update, url_or_proc)
        end

        def redirect_url_on_destroy(url_or_proc = nil)
          redirect_url_on(:destroy, url_or_proc)
        end

        def redirect_url_on(_action, url_or_proc = nil)
          _action = _action.to_sym
          @redirect_urls_on ||= {}
          if url_or_proc
            @redirect_urls_on[_action] = url_or_proc
          else
            @redirect_urls_on[_action] ||= lambda { |r| _action.to_sym == :destroy ? { action: 'index' } : r }
          end
        end

      end
    end
  end
end
module Gin
  module DryController
    module BeforeFilters
      require "gin/dry_controller/before_filters/set_resource_plural_ivar"
      require "gin/dry_controller/before_filters/set_resource_singular_ivar"
    end
  end
end
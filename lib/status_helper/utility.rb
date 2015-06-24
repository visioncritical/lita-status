module StatusHelper
  module Utility
    # Find Lita::User by particular method
    # Returns nil if it finds nothing
    def find_user(user, search_method = :find_by_mention_name)
      method_obj = Lita::User.method search_method
      found_user = method_obj.call user
      found_user
    end
  end
end

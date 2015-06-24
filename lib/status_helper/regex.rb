module StatusHelper
  module Regex
    STATUS_PATTERN = /(?<status>.+)/
    USER_PATTERN = /(?<user>\S+)/
    PASSWORD_PATTERN = /(?<password>\S+)/
  end
end

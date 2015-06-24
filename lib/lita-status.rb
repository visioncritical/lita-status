require 'lita'

Lita.load_locales Dir[File.expand_path(
  File.join('..', '..', 'locales', '*.yml'), __FILE__
)]

require 'status_helper/redis'
require 'status_helper/regex'
require 'status_helper/utility'

require 'lita/handlers/status'

Lita::Handlers::Status.template_root File.expand_path(
  File.join('..', '..', 'templates'),
  __FILE__
)

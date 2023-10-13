# frozen_string_literal: true

require_relative "orthotypo/composer"
require_relative "orthotypo/composer/fr"
require_relative "orthotypo/composer/fr_fr"
require_relative "orthotypo/composer/fr_ch"
require_relative "orthotypo/composer/en"
require_relative "orthotypo/composer/en_gb"
require_relative "orthotypo/ext/string"
require_relative "orthotypo/localizer"
require_relative "orthotypo/version"

module Orthotypo
  class Error < StandardError; end
end

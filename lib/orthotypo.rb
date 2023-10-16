# frozen_string_literal: true

require "htmlentities"
require "uri"
require_relative "orthotypo/composer"
require_relative "orthotypo/composer/fr"
require_relative "orthotypo/composer/fr_fr"
require_relative "orthotypo/composer/fr_ch"
require_relative "orthotypo/composer/en"
require_relative "orthotypo/composer/en_gb"
require_relative "orthotypo/core_ext"
require_relative "orthotypo/localizer"
require_relative "orthotypo/version"

module Orthotypo
  class Error < StandardError; end
end

# frozen_string_literal: true

require_relative "orthotypo/composer"
require_relative "orthotypo/ext/string"
require_relative "orthotypo/localizer"
require_relative "orthotypo/locales/fr"
require_relative "orthotypo/locales/fr_fr"
require_relative "orthotypo/locales/fr_ch"
require_relative "orthotypo/locales/en"
require_relative "orthotypo/locales/en_gb"
require_relative "orthotypo/version"

module Orthotypo
  class Error < StandardError; end
end

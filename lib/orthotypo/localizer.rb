module Orthotypo
  class Localizer

    DEFAULT_LOCALE = 'fr'

    def initialize(string, locale: nil, html: nil)
      @string = string
      @locale = locale
      @html = html
    end

    def composer
      composer_class.new @string, html: @html
    end

    protected

    def composer_class
      composer_class = composer_class_for(@locale) unless @locale.nil?
      composer_class ||= composer_class_for(DEFAULT_LOCALE)
      composer_class
    end

    def composer_class_for(locale)
      formatted_locale = locale.split('-').map(&:capitalize).join
      class_name = "Orthotypo::Composer::#{formatted_locale}"
      class_name.constantize
    rescue
    end
  end
end
  
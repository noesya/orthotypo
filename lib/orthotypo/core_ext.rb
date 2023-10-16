String.class_eval do
  def ortho(locale: nil, html: nil)
    @ortho ||= Orthotypo::Localizer.new(self, locale: locale, html: html).composer.ortho
  end
end
class String
  def ortho(locale: nil, html: nil)
    @ortho ||= Orthotypo::Parser.new(self, locale, html).ortho
  end
end
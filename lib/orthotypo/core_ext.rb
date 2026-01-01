String.class_eval do
  def ortho(locale: nil, html: nil)
    @ortho ||= Orthotypo::Composer.new(self).to_s
  end
end
class String
  def ortho
    @ortho ||= Orthotypo::Parser.new(self).ortho
  end
end
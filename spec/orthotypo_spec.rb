require 'spec_helper'

describe Orthotypo do
  it 'adds spaces before double punctuation marks' do
    expect("Un texte avec un signe double: mais il manque l'espace.".ortho)
    .to(eq("Un texte avec un signe double : mais il manque l'espace."))
  end
  it 'transforms regular spaces before double punctuation marks' do
    expect("Un texte avec un signe double : mais il manque l'espace.".ortho)
    .to(eq("Un texte avec un signe double : mais il manque l'espace."))
  end
end

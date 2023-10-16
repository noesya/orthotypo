
require 'spec_helper'

describe Orthotypo::Composer::En do
  it 'removes spaces before double punctuation marks' do
    expect("mot: suite".ortho(locale: 'en')).to eq "mot: suite"
    expect("mot : suite".ortho(locale: 'en')).to eq "mot: suite"
    expect("é: suite".ortho(locale: 'en')).to eq "é: suite"
    expect("é : suite".ortho(locale: 'en')).to eq "é: suite"
    expect("1: suite".ortho(locale: 'en')).to eq "1: suite"
    expect("1 : suite".ortho(locale: 'en')).to eq "1: suite"
    expect("mot; suite".ortho(locale: 'en')).to eq "mot; suite"
    expect("mot ; suite".ortho(locale: 'en')).to eq "mot; suite"
    expect("mot!".ortho(locale: 'en')).to eq "mot!"
    expect("mot !".ortho(locale: 'en')).to eq "mot!"
  end
end
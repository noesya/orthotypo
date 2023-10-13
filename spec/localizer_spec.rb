require 'spec_helper'

describe Orthotypo do
  it 'selects FR' do
    expect(Orthotypo::Localizer.new('').composer).to be_a Orthotypo::Composer::Fr
    expect(Orthotypo::Localizer.new('', locale: 'fr').composer).to be_a Orthotypo::Composer::Fr
    expect(Orthotypo::Localizer.new('', locale: 'fr-FR').composer).to be_a Orthotypo::Composer::FrFR
    expect(Orthotypo::Localizer.new('', locale: 'fr-CH').composer).to be_a Orthotypo::Composer::FrCH
    expect(Orthotypo::Localizer.new('', locale: 'en').composer).to be_a Orthotypo::Composer::En
    expect(Orthotypo::Localizer.new('', locale: 'en-GB').composer).to be_a Orthotypo::Composer::EnGB
  end
end
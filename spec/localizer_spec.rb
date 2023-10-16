require 'spec_helper'

describe Orthotypo do
  it 'selects proper locale' do
    expect(Orthotypo::Localizer.new('').composer).to be_a Orthotypo::Composer::Fr
    expect(Orthotypo::Localizer.new('', locale: 'fr').composer).to be_a Orthotypo::Composer::Fr
    expect(Orthotypo::Localizer.new('', locale: 'fr-FR').composer).to be_a Orthotypo::Composer::FrFr
    expect(Orthotypo::Localizer.new('', locale: 'fr-CH').composer).to be_a Orthotypo::Composer::FrCh
    expect(Orthotypo::Localizer.new('', locale: 'en').composer).to be_a Orthotypo::Composer::En
    expect(Orthotypo::Localizer.new('', locale: 'en-GB').composer).to be_a Orthotypo::Composer::EnGb
    expect(Orthotypo::Localizer.new('', locale: 'en-UNKNOWN').composer).to be_a Orthotypo::Composer::Fr
  end
end
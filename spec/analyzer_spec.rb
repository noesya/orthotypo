require 'spec_helper'

describe Orthotypo::Analyzer do
  it 'find urls' do
    expect(Orthotypo::Analyzer.url?("https://unsplash.com/@lusvardi?utm_source=osuny")).to be true
    expect(Orthotypo::Analyzer.url?("https://hal.science/hal-02455856")).to be true
    expect(Orthotypo::Analyzer.url?("mailto:test@example.com")).to be true
    expect(Orthotypo::Analyzer.url?("mot:")).to be false
  end
end

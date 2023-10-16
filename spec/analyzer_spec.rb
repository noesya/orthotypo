require 'spec_helper'

describe Orthotypo::Analyzer do
  it 'find urls' do
    expect(Orthotypo::Analyzer.url?("https://unsplash.com/@lusvardi?utm_source=osuny")).to be true
    expect(Orthotypo::Analyzer.url?("mot:")).to be false
  end
end

require 'spec_helper'

describe Orthotypo do
  it 'leaves html entities untouched' do
    expect("test &amp; test".ortho).to eq "test &amp; test"
  end
  
  it 'leaves html tags untouched' do
    expect("<b>bold</b>".ortho).to eq "<b>bold</b>"
  end

  it 'leaves URLs untouched' do
    expect("https://unsplash.com/@lusvardi?utm_source=osuny".ortho).to eq "https://unsplash.com/@lusvardi?utm_source=osuny"
  end
end

require 'spec_helper'

describe Orthotypo do
  it 'leaves html entities untouched' do
    expect("test &amp; test".ortho).to eq "test &amp; test"
  end
  
  it 'leaves html tags untouched' do
    expect("<b>bold</b>".ortho).to eq "<b>bold</b>"
  end
end

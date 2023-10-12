require 'spec_helper'

describe Orthotypo do
  it 'adds spaces before double punctuation marks' do
    expect("mot: suite".ortho).to(eq("mot : suite"))
    expect("é: suite".ortho).to(eq("é : suite"))
    expect("1: suite".ortho).to(eq("1 : suite"))
  end
  it 'transforms regular spaces before double punctuation marks' do
    expect("mot : suite".ortho).to(eq("mot : suite"))
    expect("é : suite".ortho).to(eq("é : suite"))
    expect("1 : suite".ortho).to(eq("1 : suite"))
  end
end

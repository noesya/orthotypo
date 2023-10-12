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
  
  it 'fixes space before simple punctuation' do
    expect("mot , suite".ortho).to(eq("mot, suite"))
  end
  
  it 'fixes quotation marks' do
    expect("«mot»".ortho).to(eq("« mot »"))
    expect("« mot »".ortho).to(eq("« mot »"))
    expect("“ mot ”".ortho).to(eq("“mot”"))
    expect("‘ mot ’".ortho).to(eq("‘mot’"))
    expect("‹ mot ›".ortho).to(eq("‹mot›"))
    expect("\" mot \"".ortho).to(eq("\"mot\""))
    expect("' mot '".ortho).to(eq("'mot'"))
  end

  it 'fixes percent' do
    expect("10%".ortho).to(eq("10 %"))
    expect("10 %".ortho).to(eq("10 %"))
  end
end

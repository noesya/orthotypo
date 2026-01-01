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
    expect("<a href=\"https://unsplash.com/@lusvardi?utm_source=osuny\">https://unsplash.com/@lusvardi?utm_source=osuny</a>".ortho).to eq "<a href=\"https://unsplash.com/@lusvardi?utm_source=osuny\">https://unsplash.com/@lusvardi?utm_source=osuny</a>"
  end

  it 'leaves mails untouched' do
    expect("prenom.nom@example.com".ortho).to eq "prenom.nom@example.com"
    expect("<a href=\"mailto:prenom.nom@example.com\">prenom.nom@example.com</a>".ortho).to eq "<a href=\"mailto:prenom.nom@example.com\">prenom.nom@example.com</a>"
  end

  it 'transforms regular spaces before double punctuation marks' do
    # :;!?
    expect("mot : suite".ortho).to(eq("mot : suite"))
    expect("mot ; suite".ortho).to(eq("mot ; suite"))
    expect("mot ! suite".ortho).to(eq("mot ! suite"))
    expect("mot ? suite".ortho).to(eq("mot ? suite"))
    # No problem with special chars
    expect("é : suite".ortho).to(eq("é : suite"))
    expect("1 : suite".ortho).to(eq("1 : suite"))
  end

  it 'fixes spaces after and before quotation marks' do
    # «»
    expect("«mot»".ortho).to(eq("«mot»"))
    expect("« mot »".ortho).to(eq("« mot »"))
    expect("« mot »".ortho).to(eq("« mot »"))
    # ‹›
    expect("‹mot›".ortho).to(eq("‹mot›"))
    expect("‹ mot ›".ortho).to(eq("‹ mot ›"))
    expect("‹ mot ›".ortho).to(eq("‹ mot ›"))
    # “”
    expect("“mot”".ortho).to(eq("“mot”"))
    expect("“ mot ”".ortho).to(eq("“ mot ”"))
    expect("“ mot ”".ortho).to(eq("“ mot ”"))
  end
end

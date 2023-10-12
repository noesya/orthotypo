require 'spec_helper'

describe Orthotypo do
  it 'adds spaces before double punctuation marks' do
    expect("mot: suite".ortho).to(eq("mot : suite"))
    expect("é: suite".ortho).to(eq("é : suite"))
    expect("1: suite".ortho).to(eq("1 : suite"))
    expect("mot; suite".ortho).to(eq("mot ; suite"))
    expect("mot!".ortho).to(eq("mot !"))
    expect("mot !".ortho).to(eq("mot !"))
  end

  it 'transforms regular spaces before double punctuation marks' do
    expect("mot : suite".ortho).to(eq("mot : suite"))
    expect("é : suite".ortho).to(eq("é : suite"))
    expect("1 : suite".ortho).to(eq("1 : suite"))
  end
  
  it 'fixes space before simple punctuation' do
    expect("mot , suite".ortho).to(eq("mot, suite"))
    expect("mot . suite".ortho).to(eq("mot. suite"))
    expect("l 'approche".ortho).to(eq("l'approche"))
    expect("l' approche".ortho).to(eq("l'approche"))
  end

  it 'fixes quotation marks' do
    expect("«mot»".ortho).to(eq("« mot »"))
    expect("« mot »".ortho).to(eq("« mot »"))
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

  it 'tests de Justine Debret' do
    expect("Elle a vu son cousin,sa tante et son oncle.Ils allaient tous très bien.".ortho).to(eq("Elle a vu son cousin, sa tante et son oncle. Ils allaient tous très bien."))
    expect("Elle dit: qui voudrait bien venir voir ce film? Il répond: moi; à moins qu’il ne fasse très beau!".ortho).to(eq("Elle dit : qui voudrait bien venir voir ce film ? Il répond : moi ; à moins qu’il ne fasse très beau !"))
    expect("L’ hiver ne va pas durer toute l’année.".ortho).to(eq("L’hiver ne va pas durer toute l’année."))
    expect("Elle ne disait plus rien…jusqu’au moment du repas.".ortho).to(eq("Elle ne disait plus rien… jusqu’au moment du repas."))
    expect("Il a dit : «J’arrive ce matin ( ou plus tard ) à Paris [ rue de la République ] pour son anniversaire.»".ortho).to(eq("Il a dit : « J’arrive ce matin (ou plus tard) à Paris [rue de la République] pour son anniversaire. »"))
  end
end

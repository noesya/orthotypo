
require 'spec_helper'

describe Orthotypo::Composer::Fr do
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
  
  it 'fixes space after simple punctuation' do
    expect("mot,suite".ortho).to(eq("mot, suite"))
    expect("4,5".ortho).to(eq("4,5"))
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

  it 'fixes dates/time' do
    expect("10/01/2023 16:00".ortho).to(eq("10/01/2023 16:00"))
    expect("10/01/2023 16:00:00".ortho).to(eq("10/01/2023 16:00:00"))
    expect("10 /01/2023 16:00".ortho).to(eq("10/01/2023 16:00"))
    expect("10 /01/2023 16 : 00".ortho).to(eq("10/01/2023 16:00"))
  end

  # https://www.scribbr.fr/elements-linguistiques/les-espaces/
  it 'tests de Justine Debret' do
    expect("Elle a vu son cousin,sa tante et son oncle.Ils allaient tous très bien.".ortho).to(eq("Elle a vu son cousin, sa tante et son oncle. Ils allaient tous très bien."))
    expect("Elle dit: qui voudrait bien venir voir ce film? Il répond: moi; à moins qu’il ne fasse très beau!".ortho).to(eq("Elle dit : qui voudrait bien venir voir ce film ? Il répond : moi ; à moins qu’il ne fasse très beau !"))
    expect("L’ hiver ne va pas durer toute l’année.".ortho).to(eq("L’hiver ne va pas durer toute l’année."))
    expect("Elle ne disait plus rien…jusqu’au moment du repas.".ortho).to(eq("Elle ne disait plus rien… jusqu’au moment du repas."))
    expect("Il a dit : «J’arrive ce matin ( ou plus tard ) à Paris [ rue de la République ] pour son anniversaire.»".ortho).to(eq("Il a dit : « J’arrive ce matin (ou plus tard) à Paris [rue de la République] pour son anniversaire. »"))
    # Le test suivant n'est pas automatisable, parce qu'on ne peut distinguer un Paris-Brest (le gâteau) d'un Paris - Brest (le trajet)
    # expect("Nous l’avons rencontré à Saint - Martin.".ortho).to(eq("Nous l’avons rencontré à Saint-Martin."))
    # Le test suivant est-il automatisable ?
    # expect("Il roule pendant 31, 5km.".ortho).to(eq("Il roule pendant 31,5 km."))
    # Pas automatisable, rien ne permet de distinguer s'il s'agit d'un rang ou d'un nombre
    # expect("Il en compte 1,000, 10,000, 36,742, 500,000, puis 1,000,000, 25,000,000, etc.".ortho).to(eq("Il en compte 1 000, 10 000, 36 742, 500 000, puis 1 000 000, 25 000 000, etc."))
    # expect("Le numéro gagnant est le 3 541 672.".ortho).to(eq("Le numéro gagnant est le 3541672."))
  end
end

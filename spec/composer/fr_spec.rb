
require 'spec_helper'

describe Orthotypo::Composer::Fr do
  it 'adds spaces before double punctuation marks' do
    expect("mot: suite".ortho).to(eq("mot : suite"))
    expect("é: suite".ortho).to(eq("é : suite"))
    # Pas automatisable, parce qu'on peut écrire une heure 11:20
    # expect("1: suite".ortho).to(eq("1 : suite"))
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
    expect("84.Paris".ortho).to(eq("84.Paris"))
    expect("etudiant.gouv.fr".ortho).to(eq("etudiant.gouv.fr"))
    expect("4,5".ortho).to(eq("4,5"))
    expect("4.5".ortho).to(eq("4.5"))
    # Le test suivant, on ne fait rien, on ne peut pas résoudre, car s'apparente au cas précédent (1984.5)
    # expect("Il est né en 1984.5 maisons en paille".ortho).to(eq("Il est né en 1984. 5 maisons en paille"))
  end

  it 'fixes quotation marks' do
    expect("«mot»".ortho).to(eq("« mot »"))
    expect("« mot »".ortho).to(eq("« mot »"))
    expect("“ mot ”".ortho).to(eq("“mot”"))
    expect("‹ mot ›".ortho).to(eq("‹mot›"))
    expect("\" mot \"".ortho).to(eq("\"mot\""))
    expect("' mot '".ortho).to(eq("'mot'"))
    expect("( une phrase entre parenthèses )".ortho).to(eq("(une phrase entre parenthèses)"))
    expect('photos "On the Job", stock'.ortho).to(eq('photos "On the Job", stock'))
  end

  it 'fixes percent' do
    expect("10%".ortho).to(eq("10 %"))
    expect("10 %".ortho).to(eq("10 %"))
  end

  it 'fixes dates/time' do
    expect("10/01/2023 16:00".ortho).to(eq("10/01/2023 16:00"))
    expect("10/01/2023 16:00:00".ortho).to(eq("10/01/2023 16:00:00"))
    expect("10 / 01 / 2023 16:00".ortho).to(eq("10/01/2023 16:00"))
    expect("10 / 01 / 2023 16 : 00".ortho).to(eq("10/01/2023 16:00"))
    expect("10 octobre 2023 16:00".ortho).to(eq("10 octobre 2023 16:00"))
  end

  it 'does well with HTML' do
    expect("<p><a href=\"https://www.linkedin.com/in/marie-dewet-1397a094/\">Marie Dewet</a>, Co-fondatrice de <a href=\"https://www.linkedin.com/company/maisoncleo/\">MaisonCléo</a> nous apporte ses lumières.</p>".ortho).to(eq("<p><a href=\"https://www.linkedin.com/in/marie-dewet-1397a094/\">Marie Dewet</a>, Co-fondatrice de <a href=\"https://www.linkedin.com/company/maisoncleo/\">MaisonCléo</a> nous apporte ses lumières.</p>"))
    expect("<p></p><p>Nous aimons la qualité</p><p></p>".ortho).to(eq("<p></p><p>Nous aimons la qualité</p><p></p>"))
    expect('<p>Série de photos "On the Job", Death to the stock</p>'.ortho).to(eq('<p>Série de photos "On the Job", Death to the stock</p>'))
  end

  it 'manages linebreaks' do
    expect("A parallel between wildlife and urban ensembles.\r\rShot during summer 2014 on our trip from north to south of Portugal.".ortho).to(eq("A parallel between wildlife and urban ensembles.<br><br>Shot during summer 2014 on our trip from north to south of Portugal."))
  end

  it 'preserves URLs' do
    expect("https://hal.science/hal-02455856".ortho).to(eq("https://hal.science/hal-02455856"))
  end

  # https://www.scribbr.fr/elements-linguistiques/les-espaces/
  it 'tests de Justine Debret' do
    # FIXME
    # expect("Elle a vu son cousin,sa tante et son oncle.Ils allaient tous très bien.".ortho).to(eq("Elle a vu son cousin, sa tante et son oncle. Ils allaient tous très bien."))
    expect("Elle ne disait plus rien…jusqu’au moment du repas.".ortho).to(eq("Elle ne disait plus rien… jusqu’au moment du repas."))

    expect("Elle dit: qui voudrait bien venir voir ce film? Il répond: moi; à moins qu’il ne fasse très beau!".ortho).to(eq("Elle dit : qui voudrait bien venir voir ce film ? Il répond : moi ; à moins qu’il ne fasse très beau !"))

    expect("L’ hiver ne va pas durer toute l’année.".ortho).to(eq("L’hiver ne va pas durer toute l’année."))

    expect("Il a dit : «J’arrive ce matin ( ou plus tard ) à Paris [ rue de la République ] pour son anniversaire.»".ortho).to(eq("Il a dit : « J’arrive ce matin (ou plus tard) à Paris [rue de la République] pour son anniversaire. »"))

    # Le test suivant n'est pas automatisable, parce qu'on ne peut distinguer un Paris-Brest (le gâteau) d'un Paris - Brest (le trajet)
    # expect("Nous l’avons rencontré à Saint - Martin.".ortho).to(eq("Nous l’avons rencontré à Saint-Martin."))

    expect("Il roule pendant 31, 5 km.".ortho).to(eq("Il roule pendant 31,5 km."))

    # Le test suivant est-il automatisable ?
    # expect("Il roule pendant 31, 5km.".ortho).to(eq("Il roule pendant 31,5 km."))

    # Pas automatisable, rien ne permet de distinguer s'il s'agit d'un rang ou d'un nombre
    # expect("Il en compte 1,000, 10,000, 36,742, 500,000, puis 1,000,000, 25,000,000, etc.".ortho).to(eq("Il en compte 1 000, 10 000, 36 742, 500 000, puis 1 000 000, 25 000 000, etc."))
    # expect("Le numéro gagnant est le 3 541 672.".ortho).to(eq("Le numéro gagnant est le 3541672."))
  end
end

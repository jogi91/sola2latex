module Textmanipulator
  def escape_latex(string)
    string.gsub!(/\\/,"\\textbackslash") #backslashes werden durch einen Backslash im fliesstext ersetzt
    string.gsub!(/\$/,"\\$")
    string.gsub!(/_/,"\\_")
    string.gsub!(/\[/,"$\\lbrack$")
    string.gsub!(/\]/,"$\\rbrack$")
    string.gsub!(/</,"\\textless")
    string.gsub!(/>/,"\\textgreater")
    string.gsub!(/\302\247/,"\\S") #Das §-Zeichen
    string.gsub!(/&/, "AMPERSAND") #Das & Zeichen nimmt z. T. noch einen wert an, je nachdem wie es escaped ist, gsub(/MATCHIRGENDWAS/, "\\&") gibt nicht \& im puts sondern MATCHIRGENDWAS. Die Escapes werden irgendwie aufgefressen.
    string.gsub!(/#/,"\\#")
    string.gsub!(/\{/,"\\{")
    string.gsub!(/\}/,"\\}")
    string.gsub!(/%/,"\\%")
    string.gsub!(/~/,"\\textasciitilde")
    string.gsub!(/"/,"\"\'") #Das Anführungszeichen wird durch ein Anführungszeichen und einen Apostroph ersetzt
    string.gsub!(/\342\202\254/,"\\texteuro") #Das Eurozeichen
    debug string.inspect
    return string
  end
  
  #Erstellt aus einem String Listen.
  def parse_lists
  end
end
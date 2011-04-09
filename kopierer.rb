#Diese Klasse soll den Vorlagentext komplett enthalten, da ich nicht davon ausgehen kann, dass der LaTeX-Code von Shoes mitgepackt wird.
#Er wird die Daten entgegennehmen, sie komplett in den Block einfügen und den kompletten LaTeX-Code dann ausgeben können.
class Kopierer
  attr_accessor :basisparameter, :basisparameterwerte, :ziele, :sicherheit, :material 
  attr_accessor :einstieg, :hauptteil, :ausstieg, :kommentare_einstieg, :kommentare_hauptteil, :kommentare_ausstieg
  def initialize
    @einstieg, @hauptteil, @ausstieg, @kommentare_einstieg, @kommentare_hauptteil, @kommentare_ausstieg = ""
    #Die Vorlage bleibt vorerst hardgecodet, damit sie in das .shy eingepackt wird. Änderung in einer späteren Version möglich
    @vorlage = "%Klimbim f\303\274r die Formatierung\n\\documentclass[12pt]{article}\n\\usepackage[a4paper,naturalnames]{hyperref}\n\\usepackage[utf8]{inputenc}  \n\\usepackage[german]{babel}\n\\usepackage{setspace}\n\\usepackage{fancyhdr}\n\\usepackage{url}\n\\usepackage{lastpage} % F\303\274r Seitenanzahl\n\\usepackage{calc}\n\n%Tabellen\n\\usepackage{tabularx}\n\\usepackage{paralist} % F\303\274r die Aufz\303\244hlungen in den Tabellen, erm\303\266glicht kurzen abstand\n\\usepackage{longtable}\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\\setlength{\\parskip}{0.5ex}%\n\\setlength{\\parindent}{0pt}%\n%\\renewcommand{\\baselinestretch}{1.5}%\n%\n\n\\oddsidemargin -10.4mm\n\\evensidemargin -10.4mm\n\\textwidth 18cm\n\\headheight 20mm\n\\topmargin -23mm\n\\textheight 222mm\n\\setlength{\\tabcolsep}{0.25cm}\n\\setlength{\\arrayrulewidth}{1pt}\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n%Kopf und Fusszeilen\n\\pagestyle{fancy}\n\\newcommand{\\tstamp}{DATUM}\n\\fancyhf{}\n\\lhead{\\sf LA X.Y}\n\\chead{BLOCKNAME}\n\\rhead{\\sf LOGOS J+S, JUBLA ZUFIKON}\n\\cfoot{\\thepage / \\pageref{LastPage}}\n\\rfoot{\\sf \\tstamp}\n\\lfoot{\\sf Sommerlager 2010 Stoos}\n\\renewcommand{\\headrulewidth}{1pt}\n\\renewcommand{\\footrulewidth}{1pt}\n\n%Zeilenabstand 1.5\n\\onehalfspacing \n\\begin{document}\n\\section*{Blockbeschrieb}\n\t\\begin{tabular}{|p{2.5cm}|p{5.5cm}|p{2.5cm}|p{5.5cm}|}\n\t\\hline\n\tBlockname: \t& BLOCKNAME\t& J+S-Nummer\t& J+S-NUMMER \\\\ \\hline\n\tLeitung:\t\t& LEITUNG\t\t& Teilnehmer:\t& TEILNEHMER \\\\ \\hline\n\tOrt:\t\t\t& ORT\t\t\t& Datum:\t\t& \\tstamp \\\\ \\hline\n\tMaterial:\t\t& MATERIAL\t\t& Zeit:\t\t& ZEIT \\\\ \\hline\n\tZiele:\t\t&  \\multicolumn{3}{p{13.5cm+4\\tabcolsep+2\\arrayrulewidth}|}{\\begin{compactitem} % Compactitem ergibt eine Liste\n\t\t\\item ZIELE % Hier sind die bl\303\266den Umbr\303\274che\n \t\\end{compactitem}} \\\\\n\t\\hline\n\\end{tabular}\n\n\n\n\\begin{tabular}{|p{17.5cm+3\\arrayrulewidth}|}\n\t\\hline\n\t\\parbox[0pt][1.5cm][c]{0cm}{\\section*{Sicherheitskonzept}}\\\\\n\t\\hline\n\t\\begin{compactitem}\n\t\t \\item SICHERHEITSKONZEPT\n \t\\end{compactitem}\\\\\n \t\\hline \n\\end{tabular}\n\n\\begin{longtable}{|p{12cm}|p{5cm+2\\arrayrulewidth}|}\n\t\\hline \n\t\\bf Blockbeschrieb & \\bf Bemerkungen \\\\ \\hline \n\t\\endfirsthead \\hline \\bf Blockbeschrieb & \\bf Bemerkungen \\\\ \\hline \n\t\\endhead \\hline \n\t\\multicolumn{2}{|c|}{Fortsetzung auf n\303\244chster Seite.} \\\\ \\hline \n\t\\endfoot\n\t\\endlastfoot \n\t{\\large\\bf {Einstieg}}\n\t\n\tEINSTIEG & \\\\ \\hline\n\t{\\large\\bf {Hauptteil}}\n\t\n\tHAUPTTEIL & \\\\ \\hline\n\t{\\large\\bf {Ausstieg}}\n\t\n\tAUSSTIEG & \\\\ \\hline\n\n\t\\end{longtable}\n\\end{document}"
  end  
  def speichern
    savefile = ask_save_file
    savefile = savefile+".tex"
    output = File.open(savefile, 'w')
    outputstring = zusammensetzen
    output.puts outputstring
    output.close
    debug "Output Closed"
    exit
  end
  
  
  def zusammensetzen
    
    #Basisparameter ersetzen, Die Parameter aus dem Hauptfile werden in UPPERCASE umgewandelt und dann in der Vorlage ersetzt. So können später einfach neue Vorlagen mit neuen Parametern definiert werden
    @basisparameterwerte.each_index do |i|
      debug @basisparameter[i].upcase
      debug @basisparameterwerte[i]
      @vorlage.gsub!(@basisparameter[i].upcase, @basisparameterwerte[i])
    end
    
    #Material Einfüllen
    @vorlage.gsub!(/MATERIAL/, @material)
    
    #Ziele Einfüllen
    zielstring = String.new
    @ziele.each do |ziel|
      ziel = "\\item "+ziel+"\n\t\t" #\t sind Tabstops, damit der Tex-Code einigermassen lesbar bleibt
      zielstring += ziel
    end
    zielstring.chomp!("\t\t") #Die letzten beiden Tabstops entfernen
    @vorlage.gsub!(/\\item ZIELE/, zielstring)
    
    #Sicherheitskonzept Einfüllen
    sicherheitskonzeptstring = String.new
    @sicherheit.each do |sicherheit|
      sicherheit = "\\item "+sicherheit+"\n\t\t"
      sicherheitskonzeptstring += sicherheit
    end
    sicherheitskonzeptstring.chomp!("\t\t")
    @vorlage.gsub!(/\\item SICHERHEITSKONZEPT/, sicherheitskonzeptstring)
    
    #Einstieg einfüllen
    einstiegsarray = @einstieg.split("\n") #An den Zeilenumbrüchen auseinandernehmen
    einstiegsstring = String.new
    if @kommentare_einstieg.length > 400 and @kommentare_einstieg.split("\n").size < einstiegsarray.size #Wenn es mehr Abschnitte in den Kommentaren als im Hauptteil gibt, nicht auseinandernehmen
      kommentararray = @kommentare_einstieg.split("\n")
    else
      kommentararray = [@kommentare_einstieg]
    end 
    einstiegsarray.each_index do |i|
      if kommentararray[i] != nil
        string = einstiegsarray[i]+" & "+kommentararray[i]+"\\\\" #Doublebackslash
      else
        string = einstiegsarray[i]+" & \\\\"
      end
      einstiegsstring += string
    end
    einstiegsstring.chomp!("\\\\")
    @vorlage.gsub!(/EINSTIEG &/, einstiegsstring)
    
    
    
    return @vorlage
  end
end
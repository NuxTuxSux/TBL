:Namespace TBL
    tab←{M←⍵ ⋄ sel←⍳≢M ⋄ msk←0⍴⍨2,⍨≢M ⋄ mi←1 ⋄ x←{(⍎⊃(M←X.M⍪'' '⊢')[X.M[;1]⍳⊂⍺;2])⍵} ⋄ ⎕ns'M' 'sel' 'msk' 'mi' 'x'}
    ∇ init;T
      ⍝⍝⍝⍝⍝     
      T←tab 2 4⍴'Giacomo' 'Saltelli' 'via Euristarchio' 12 'Gianni' 'Cremonesi' 'via della Cremeria' 34
      T.F←tab 4 3⍴'Nome' 1 1 'Cognome' 1 2 'Indirizzo' 1 3 'Età' 2 4
      T.F.D←tab 2 5⍴'chr' '⊢' '⊢' '0' '''''' 'num' '{⍎⊃⍵}' '⍕⍤⊢¨' '0' '0'
      
      T.X←tab 3 2⍴'enter' '{F}' 'close' '⊢' 'rfrf' '{⍬}'
      T.X.F←tab 2 2⍴'event' 1 'action' 1
      T.X.F.D←tab⍉⍪'chr' '⊢' '⊢' '0' ''''''
      
      T.F.F←tab 3 2⍴'ID' 1 'Domain' 2 'Col' 3
      T.F.F.D←tab 3 5⍴'chr' '⊢' '⊢' '0' '''''' 'D' '⍳' '(⌷⍨)∘⊂' 'D.M[;1]' '0' 'num' '{⍎⊃⍵}' '⍕⍤⊢¨' '0' '0'
      
      T.F.D.F←tab 5 2⍴'ID' 1 'Parse' 1 'Format' 1 'Args' 1 'Missing' 1
      T.F.D.F.D←tab⍉⍪'chr' '⊢' '⊢' '0' ''''''
      T.F.D.X←tab 0 2⍴⊂''

      T.F.X←tab 2 2⍴'enter' '{D}' 'close' '{∨/m←M[;3]>2⊃⍴⍵.M:⍵.M←⍉(⍉⍴⍨∘((+/m),≢)⍨m⌿⍎¨D.M[2⌷[2]M;5])@(⍸m)⊢⍉⍵.M\⍨~m}' 
      T.F.X.F←tab 2 2⍴'event' 1 'action' 1
      T.F.X.F.D←tab⍉⍪'chr' '⊢' '⊢' '0' ''''''
      ⍝⍝⍝⍝⍝

      ⍙←⊂T                          ⍝ implementare aggiungendo in coda
      'win'⎕WC'Form'('Caption' 'Uxcel')('Size' 500 700)('BCol' ¯3)
      'win.G'⎕WC'Grid'format(2 2)(win.Size-4)
      'win.G'⎕WS('GridLineFCol' ¯4)('GridBCol' 200 220 255)('ColTitles'((⊃⍙).F.M[;1]))
      'win.G.ED'⎕WC'Edit'
      'win.G'⎕WS'BCol'(↓8 3⍴5×⎕UCS'333333+3)#*3"3+)-(*')
      'win.G'⎕WS'CellTypes'(1⍴⍨⍴(⊃⍙).M)
      'win.G'⎕WS'Input' 'win.G.ED'
      'win.G'⎕WS'Event' 'onCellChanged' 'inpval'
      'win.G.ED'⎕WS'Event' 'onKeyPress' 'KP'
      ⍝⎕DQ'win'
    ∇
    ∇ R←format;∆                    ⍝ serve il valore di ritorno o salvo nelle celle?
      R←↑[1]∆.(↓F.D.M[flds;5],⍪,/F.D.M[flds;4],'∘','(',(⍪F.D.M[flds←F.M[F.sel;2];3]),')')∆.{m⍀(⍎2⊃⍺)⍵⌿⍨m←⍵≢¨⊆⍎⊃⍺}¨↓[1](∆←⊃⍙).(M[sel;F.sel])
    ∇
    ∇ shw                           ⍝ separare le due cose? Forse devo settare qui i colnames
      win.G.CellTypes↑⍨←⍴win.G.Values←format ⋄ win.G.ColTitles←(⊃⍙).F.(M[sel;1])
    ∇
    ∇ rfr
      win.G.CellTypes{⍉⍵⍴⍨⌽⍴⍺}←1+2⊥⍉(⊃⍙).(msk,¯1+mi)
    ∇
    ∇ inpval E;f;∆
      ∆.M[⊂(∆.sel⌷⍨3⌷E),∆.F.sel⌷⍨4⌷E]←(∆.⍎⊃,/∆.F.D.M[f;4],'∘(',∆.F.D.M[f←∆.F.M[(∆←⊃⍙).F.sel⌷⍨4⌷E;2];2],')')⊆⍕5⊃E
    ∇
    ∇ R←KP E;K;G;r;∆                ⍝ aggiornare codici di + e - con entrambi i valori
      R←0
      K G ∆←E[6 5](⊃E).##(⊃⍙)
      :Select K
      :Case 2 73                    ⍝ ^i
          ∆.M⍪←⍉⍪⍎¨∆.F.(D.M[M[;2];5]) ⋄ ∆.msk⍪←0 ⋄ ∆.sel,←≢∆.M ⋄ shw
      :Case 2 9                     ⍝ ^tab
          ∆.mi⌷←2 1 ⋄ rfr
      :Case 2 107                   ⍝ ^+
          ∆.msk[;∆.mi←1]←∨/∆.msk ⋄ rfr
      :Case 2 109                   ⍝ ^-
          ∆.msk[;∆.mi←1]←>/∆.msk ⋄ rfr
      :Case 2 106                   ⍝ ^*
          ∆.msk[;∆.mi←1]←∧/∆.msk ⋄ rfr
      :Case 2 111                   ⍝ ^↑i
          ∆.msk[;∆.mi]-⍨←1 ⋄ rfr
      :Case 0 45                    ⍝ ins
          ∆.msk[r←⊃G.CurCell;∆.mi]-⍨←1
          G.CellTypes[r;]←⊂1+2⊥∆.msk[r;],¯1+∆.mi
      :Case 2 45                    ⍝ ^ins
          ∆.msk[;∆.mi]←1 ⋄ rfr
      :Case 2 46                    ⍝ ^canc
          ∆.msk[;∆.mi]∧←0 ⋄ rfr
      :Case 2 48                    ⍝ ^0 (can't get ^=)
          ∆.msk[;∆.mi]←∆.M[∆.sel;∆.F.sel⌷⍨⊂2⊃G.CurCell]≡¨G.CurCell⌷∆.M[∆.sel;∆.F.sel] ⋄ rfr
      :CaseList (3 109)(3 189)      ⍝ ^↑-
          ∆.sel ∆.msk⌿⍨←⊂∆.msk[;∆.mi] ⋄ shw ⋄ rfr
      :CaseList (3 107)(3 187)      ⍝ ^↑+
          ∆.msk←(≢∆.M)↑↑[1]⍸⍣¯1⍤(⊂⍤⍋⌷⊢)¨(↓[1]∆.msk)⌿¨⊂∆.sel ⋄ ∆.sel←⍳≢∆.M ⋄ shw ⋄ rfr
      :Case 2 226                   ⍝ ^<
          ∆.msk[;∆.mi]←∆.M[∆.sel;∆.F.sel⌷⍨⊂2⊃G.CurCell](</⍤⍋,⍥⊆)¨G.CurCell⌷∆.M[∆.sel;∆.F.sel] ⋄ rfr
      :Case 3 226                   ⍝ ^>
          ∆.msk[;∆.mi]←∆.M[∆.sel;∆.F.sel⌷⍨⊂2⊃G.CurCell](</⍤⍒,⍥⊆)¨G.CurCell⌷∆.M[∆.sel;∆.F.sel] ⋄ rfr
      :Case 2 38                    ⍝ ^up
          ∆.sel ∆.msk⌷⍨∘⊂←⊂⍒∆.M[∆.sel;∆.F.sel⌷⍨2⌷G.CurCell] ⋄ shw ⋄ rfr
      :Case 2 40                    ⍝ ^down
          ∆.sel ∆.msk⌷⍨∘⊂←⊂⍋∆.M[∆.sel;∆.F.sel⌷⍨2⌷G.CurCell] ⋄ shw ⋄ rfr
      :Case 0 123                   ⍝ F12
          ⍙,⍨←'enter'∆.x⍬ ⋄ shw ⋄ rfr
      :Case 0 27                    ⍝ ESC
          →0/⍨1≥≢⍙ ⋄ 'close'∆.x 2⊃⍙ ⋄ ⍙↓⍨←1 ⋄ shw ⋄ rfr       ⍝ se faccio in modo che shw⋄rfr accettino ⍬ allora
      :Else                                                 ⍝ posso eliminare il →. Però lo schermo banale dovrebbe
          :If ×⊃K ⋄ :OrIf 100<2⊃K ⋄ ⎕←K ⋄ :End              ⍝ supportare gli altri comandi...
          R←1
      :EndSelect
    ∇
    ⍝ [NOTES]
    ⍝ 'fb'⎕wc'FileBox' 'Open Table' 'path' ('Event' 'onFileBoxOK' 'fff')
    ⍝ 'fb'⎕wc'BrowseBox' 'Open Table' ('StartIn' 'path')('Event' ('onFileBoxOK' 'fff') ('onFileBoxCancel' 'fff'))  

    ⍝ [BUGS]
    ⍝ - "^↑-" con nessun evidenziato crea disagio
    ⍝ - format crea blanks in corrispondenza dei missing, causa expand, forse fare sempre dltb

    ⍝ [TODO]
    ⍝ - salvataggio su file
    ⍝ - riordinamento righe - pensarci
    ⍝ - usare ⎕fx al posto di ⍎?
    ⍝ - Args vuole le parentesi!!!
    ⍝ - open/save Tables - come organizzare?
    ⍝ - se incollo i dati non aggiorna la matrice
    ⍝ - input tabulari - come fare?
    ⍝ - bool
    ⍝ - tabella comandi (fname fcode) dentro la tabella (per comandi e callback) 
    ⍝ - testare date e tabulari
    ⍝ - aggiungere zecord (zero record)
    ⍝ - import/export CSV

    ⍝ [ToThinkAbout]
    ⍝ - forse non serve recuperare il caller (G) in KB se uso quello globale
    ⍝ - definire anche id oltre alla label per le colonne?
    ⍝ - accorpare le colonne per tipo?
    ⍝ - è più efficiente salvarla trasposta?
    
    ⍝ [Riflessioni]
    
    ⍝ - forse posso definire un mktab a matrioska o più probabilmente
    ⍝ mkftb, mkdtb, mkxtb. Inoltre così non dovrebbe servirmi un link al padre
    ⍝ T ha bisogno solo di F>D e X. F solo di D e D di nessuno, X non so

    ⍝ - credo che dobbiamo dare chr di default alla costruzione
    ⍝ rende la cosa più fondata ed elimino confusione.
    ⍝ eventualmente come in x. Forse se è ⍬ o analogo mostro direttamente la matrice

    ⍝ - MEGLIO: fare un mktab generico con prototipo

    ⍝ - Idea interessante: le tabelle possono avere figli e fratelli
    ⍝ cioè entro dentro il namespace e mi muovo tra le sotto-tabelle


:EndNamespace


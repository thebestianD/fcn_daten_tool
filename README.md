---
title: ClubProfile
emoji: ⚽
colorFrom: red
colorTo: gray
sdk: docker
app_port: 7860
---

# ClubProfile

Interaktive Voilà-App zur datenbasierten Spieler-, Team- und Kaderanalyse im Kontext des 1. FC Nürnberg.

Die App verbindet individuelle Spielerprofile, saisonbezogene Teamdaten und rollenbasierte Kaderplanung. Sie ist in drei Hauptbereiche gegliedert:

1. **Spieleranalyse**
   * Rollenprofil
   * Metrikvergleich / Spiderplot
   * Datenzwilling finden

2. **Teamanalyse**
   * Saisonanalyse
   * Teamvergleich
   * gegnerbereinigte Analyse
   * ähnliche Spiele

3. **Kaderplanung**
   * Spielstil & Teamdiagnose
   * Teambuilder

## Datenherkunft

Die in der App verwendeten **Spieler-Leistungsmetriken** basieren auf Wyscout-Daten. Ausgelesen wurden sie mithilfe von:

```text
https://best11scouting.streamlit.app/
```

Die verwendeten **Teammetriken** basieren auf Opta-Daten. Ausgelesen wurden sie mithilfe von:

```text
https://football-match-reports.streamlit.app/
```

Beide Websites werden von **Ben Griffis (@BeGriffis)** bereitgestellt.

Alle übrigen Spielerinformationen, insbesondere Stammdaten und Transfermarkt-Informationen wie Verein, Liga, Marktwert, Vertragslaufzeit oder Spielerprofil-Links, stammen von **transfermarkt.de**.

## Live-App

Die App läuft als Hugging-Face-Space:

```text
https://thebestian-fcn-datentool.hf.space/
```

## Daten- und Konfigurationsdateien

Die App erwartet folgende Dateien und Ordner im Repository bzw. im Arbeitsverzeichnis des Spaces:

```text
fcn_datentool_app.ipynb
spieler_data.xlsx
weltklasse_referenz.xlsx
zweite_liga_referenz.xlsx
rollen_definitionen.xlsx
teambuilder_formationen.xlsx
team_data/
  matches_*.csv
Dockerfile
requirements.txt
```

### `spieler_data.xlsx`

Enthält die Spielerbasis inklusive Stammdaten, Transfermarkt-Informationen und Wyscout-Metrikwerten.

Die Datei kombiniert zwei Datenquellen:

* **Wyscout-Metriken**, ausgelesen über [Best11Scouting](https://best11scouting.streamlit.app/) von **@BeGriffis**
* **Transfermarkt-Daten** von [transfermarkt.de](https://www.transfermarkt.de/), insbesondere Stammdaten, Vereins- und Ligainformationen, Marktwerte, Vertragsdaten und Profil-Links

Die Datei bildet die Grundlage für:

* Rollenprofil-Berechnungen
* Spiderplot-Vergleiche
* Datenzwilling-Suche
* Kaderplanungs- und Teambuilder-Vorschläge

### `team_data/matches_*.csv`

Enthält die Matchdaten der Teams der 2. Bundesliga. Pro Team liegt eine eigene Datei vor, zum Beispiel:

```text
team_data/matches_nürnberg.csv
team_data/matches_schalke.csv
team_data/matches_berlin.csv
```

Die Dateien enthalten Opta-basierte Team- und Matchmetriken, unter anderem:

* Ergebnis, Punkte und xPts
* Tore, xG, xGA und xGD
* Open-Play- und Set-Piece-Werte
* Ballbesitz, Field Tilt und Game Control
* xT und xT-Differenz
* Pressing- und Recovery-Metriken
* Heim-/Auswärtsinformationen und Gegner

Die Teamdaten bilden die Grundlage für:

* Saisonanalyse
* Teamvergleich
* gegnerbereinigte Analysen
* Suche nach ähnlichen Spielen
* Spielstil-Analyse und Teamdiagnose

### `weltklasse_referenz.xlsx` und `zweite_liga_referenz.xlsx`

Enthalten die Referenzspieler und Referenzwerte für die Rollenberechnung. Die App kann je nach Einstellung gegen Weltklasse- oder 2.-Bundesliga-Referenzen rechnen.

### `rollen_definitionen.xlsx`

Zentrale fachliche Rollen-Konfiguration. Hier werden gepflegt:

* verfügbare Rollen
* Rollenbeschreibungen
* zulässige Positionsfamilien
* verwendete Metriken je Rolle
* Gewichtung der Metriken
* Mapping von Referenzrollen auf Makro-Rollen

### `teambuilder_formationen.xlsx`

Konfiguriert die Vorlagen des Teambuilders. Hier werden gepflegt:

* Name der Formation
* Beschreibung der Formation
* 11 Slots je Vorlage
* Positionslabels
* zugewiesene Rolle je Slot
* X/Y-Koordinaten für die Spielfeldgrafik

## Analysefunktionen im Detail

## Spieleranalyse

### Rollenprofil

Das Rollenprofil bewertet, wie gut ein Spieler statistisch zu definierten Rollen passt. Die App zeigt unter anderem:

* beste Rollen nach Fit oder Score
* Rollen-Fit
* finalen Rollen-Score
* passende Ideal- bzw. Referenzspieler
* Stärken und Schwächen je Rolle
* Metrik-Scores im Kontext der jeweiligen Rolle
* druckfähigen Spielersteckbrief

Standardmäßig werden die **Top 2 nach Rolle** angezeigt. Die Detailansicht kann je nach Bedarf auf andere Anzeigeoptionen umgestellt werden.

### Metrikvergleich / Spiderplot

Der Spiderplot vergleicht Spieler innerhalb einer Positionsgruppe. Dabei wird ein FCN-Spieler als Referenz auf **100 %** normiert. Vergleichsspieler werden relativ zu diesem Referenzspieler dargestellt.

Die Ansicht eignet sich besonders, um konkrete Spielerprofile visuell gegenüberzustellen und Stärken/Schwächen entlang einzelner Metriken sichtbar zu machen.

### Datenzwilling finden

Die Datenzwilling-Funktion sucht den ähnlichsten Spieler im Gegenpool:

* FCN-Spieler werden nur mit Nicht-FCN-Spielern verglichen.
* Nicht-FCN-Spieler werden nur mit FCN-Spielern verglichen.
* Verglichen wird innerhalb derselben Positionsgruppe.
* Die Metrikdifferenzen werden über die Standardabweichung der Positionsgruppe normiert.
* Die normierten Differenzen werden als **Distanzmittelwert** zusammengefasst.
* Der niedrigste Wert entspricht dem ähnlichsten statistischen Profil.

Als Output zeigt die App:

* Ausgangsspieler und Datenzwilling im direkten Steckbriefvergleich
* Stammdaten und Transfermarkt-Daten beider Spieler
* beste zwei Rollen beider Spieler
* Top-5 ähnlichste Gegenpool-Spieler
* vollständigen Metrikvergleich
* Hervorhebung des jeweils besseren Metrikwerts

Die Top-5-Liste ist interaktiv: Spieler aus der Liste können direkt angeklickt werden, um die Gegenüberstellung gegen diesen Kandidaten neu zu rendern.

## Teamanalyse

### Saisonanalyse

Die Saisonanalyse betrachtet die Spiele eines ausgewählten Teams. Sie kombiniert ein regelbasiertes Kurzfazit mit interaktiven Plots und einer Einzelspielanalyse.

Enthalten sind unter anderem:

* Kurzfazit zur Chancenbilanz, Spielweise und Ergebnisqualität
* Überblick über xPts, xGD und Ergebnisentwicklung
* Chancen- und Ergebnisplots
* Spielkontrollplots
* xT-/Gefahrplots
* Pressingplots
* Standardanalyse
* Heim-/Auswärts-Vergleich
* Einzelspielanalyse mit Spieltyp, Ergebnis, Matchprofil und Detailwerten

In chronologischen Spieltagsplots markiert eine gestrichelte vertikale Linie die Grenze zwischen Hin- und Rückrunde. Spiel-Labels werden nach Ergebnis eingefärbt, damit Siege, Remis und Niederlagen schneller erkennbar sind.

### Teamvergleich

Der Teamvergleich ordnet ein ausgewähltes Team im Ligakontext ein. Er enthält:

* Liga-Benchmark mit Rängen und Perzentilen
* Team-Spiderplot mit optionalem Vergleichsteam
* Ranglistenplots
* Quadrantenplots
* Endspurttabelle über alle Teams

Der Team-Spiderplot fasst mehrere Einzelmetriken zu interpretierbaren Dimensionen zusammen, zum Beispiel Angriff, Defensive, Spielkontrolle, Progression, Pressing, Standards, Effizienz und Ergebnis.

### Gegnerbereinigte Analyse

Die gegnerbereinigte Analyse bewertet Spiele relativ zum jeweiligen Gegner-Benchmark.

Die Grundidee:

```text
Teamwert im konkreten Spiel
minus
Durchschnitt anderer Teams gegen denselben Gegner
```

Dadurch lässt sich einordnen, ob ein Team gegen einen bestimmten Gegner besser, schlechter oder ungefähr im Rahmen dessen war, was die Liga gegen diesen Gegner normalerweise erreicht hat.

Beispiele:

* positives gegnerbereinigtes xG: offensiv stärker als der Liga-Benchmark gegen diesen Gegner
* negatives gegnerbereinigtes xGA: defensiv besser als der Liga-Benchmark gegen diesen Gegner
* positives gegnerbereinigtes xGD: insgesamt überdurchschnittliches Chancenprofil gegen diesen Gegner

### Ähnliche Spiele

Die Funktion „Ähnliche Spiele“ sucht statistisch ähnliche Matchprofile. Dafür werden mehrere Matchmetriken gemeinsam betrachtet, zum Beispiel:

* xG, xGA und xGD
* xT und xT-Differenz
* Ballbesitz, Field Tilt und Game Control
* PPDA und High Recoveries
* Set-Piece-Werte
* Shots und Shots Faced

Der Modus kann wahlweise nur Spiele des ausgewählten Teams oder alle verfügbaren Teams berücksichtigen. So lassen sich wiederkehrende Muster, vergleichbare Spieltypen oder auffällige Ausreißer identifizieren.

## Kaderplanung

### Spielstil & Teamdiagnose

Der Bereich „Spielstil & Teamdiagnose“ verbindet die Teamdaten mit ersten kaderplanerischen Ableitungen.

Die App berechnet ein Spielstilprofil aus mehreren Dimensionen, zum Beispiel:

* Angriff
* Defensive
* Spielkontrolle
* Progression
* Pressing
* Standards
* Effizienz
* Ergebnis

Darauf aufbauend werden relative Entwicklungsfelder und mögliche strukturelle Bedarfe abgeleitet. Die Diagnose unterscheidet zwischen echten Schwachpunkten im Ligavergleich und relativen Entwicklungsfeldern innerhalb eines insgesamt starken Profils.

Beispiele für Ableitungen:

* geringe Spielkontrolle → Bedarf an spielstarker Sechs, mitspielendem Innenverteidiger oder verbindendem Achter
* geringe Progression → Bedarf an balltragenden Außenverteidigern, progressiven Achtern oder kreativen Halbraumspielern
* schwache defensive Werte → Bedarf an Absicherung, Restverteidigung oder defensiver Stabilität
* schwache Standards → Bedarf an Kopfballstärke, Standardschützen oder besserer Boxbesetzung

### Teambuilder

Der Teambuilder erstellt aus Formationenvorlagen eine rollenbasierte Elf. Für jeden Slot werden passende Spieler vorgeschlagen. Die Optimierung kann erfolgen nach:

* höchstem Score
* bestem Fit
* allen Spielern
* nur FCN-Spielern

Die Rollen werden auf einem Spielfeld visualisiert. Spieler können direkt in der Grafik über Alternativen ausgetauscht werden.

Der Teambuilder ist bewusst in der Kaderplanung verortet, weil er die Brücke zwischen Teamdiagnose, Zielspielweise und konkreten Rollenprofilen bildet.

## Lokaler Start

Die App wird über Voilà aus dem Notebook gestartet. Im Docker-Setup des Hugging-Face-Spaces erfolgt das über den `CMD` im `Dockerfile`.

Lokal kann die App sinngemäß so gestartet werden:

```bash
voila fcn_datentool_app.ipynb --port=7860 --no-browser --Voila.ip=0.0.0.0
```

## Hinweise zur Pflege

* Rollen, Metriken und Gewichtungen werden in `rollen_definitionen.xlsx` gepflegt.
* Formationenvorlagen werden in `teambuilder_formationen.xlsx` gepflegt.
* Spieler- und Transfermarkt-Daten werden in `spieler_data.xlsx` gepflegt.
* Teamdaten werden als `matches_*.csv` im Ordner `team_data/` abgelegt.
* Neue Rollen sollten sowohl in `rollen_definitionen.xlsx` als auch, falls im Teambuilder genutzt, in `teambuilder_formationen.xlsx` eingetragen werden.
* Neue Referenzrollen sollten über das Mapping in `Source_Roles` der Rollen-Excel sauber einer Makro-Rolle zugeordnet werden.
* Für die Datenzwilling-Suche sollten Spieler innerhalb einer Positionsgruppe möglichst konsistent mit denselben Metriken gepflegt sein.
* Für Teamvergleiche sollten die Matchdateien aller Teams dieselbe Spaltenstruktur verwenden.
* Die kanonischen Dateinamen sollten im Space unverändert bleiben, da das Notebook diese Dateien erwartet.

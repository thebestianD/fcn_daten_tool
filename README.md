---

title: ClubProfile
emoji: ⚽
colorFrom: red
colorTo: gray
sdk: docker
app_port: 7860
--------------

# ClubProfile

Interaktive Voilà-App zur datenbasierten Evaluation von Spielerprofilen im Kontext des 1. FC Nürnberg.

ClubProfile kombiniert vier Analyseebenen:

1. **Rollenprofil**
   Spieler werden anhand ihrer statistischen Profile mit verschiedenen Rollen verglichen. Die App zeigt passende Rollen, Rollen-Scores, Stärken/Schwächen und einen druckfähigen Spielersteckbrief. Die zwei angezeigten Rollenprofile können wahlweise nach bestem **Fit** oder höchstem **Score** ausgewählt werden.

2. **Metrikvergleich / Spiderplot**
   Spieler können über positionsgruppenbasierte Spiderplots mit FCN-Referenzspielern verglichen werden. Der FCN-Spieler wird je Metrik auf **100 %** normiert. Vergleichsspieler werden relativ dazu dargestellt.

3. **Datenzwilling finden**
   Für einen ausgewählten Spieler wird der datentechnisch ähnlichste Gegenpool-Spieler gesucht. FCN-Spieler werden dabei mit Nicht-FCN-Spielern verglichen und Nicht-FCN-Spieler mit FCN-Spielern. Der Vergleich erfolgt innerhalb derselben Positionsgruppe, damit möglichst vergleichbare Metriken genutzt werden.

   Für jede Metrik wird die Differenz zwischen Ausgangsspieler und Vergleichsspieler berechnet, anhand der positionsgruppenspezifischen Standardabweichung normiert und anschließend zu einem Distanzmaß aufsummiert. Der Spieler mit der niedrigsten Distanz gilt als Datenzwilling. Zusätzlich zeigt die App die Top-5 ähnlichsten Gegenpool-Spieler, die direkt angeklickt und für die Gegenüberstellung ausgewählt werden können.

4. **Teambuilder**
   Aus vordefinierten Formationsvorlagen können Rollen-Eleven erstellt werden. Die App schlägt Spieler für jede Rolle vor und optimiert die Besetzung wahlweise nach **Score** oder **Fit**, entweder aus allen Spielern oder nur aus FCN-Spielern. Die Rollen werden positionsgetreu auf einem Spielfeld dargestellt und können direkt in der Grafik über Alternativen ausgetauscht werden.

## Datenherkunft

Die in der App verwendeten **Leistungsmetriken** basieren auf Wyscout-Daten. Ausgelesen wurden sie mithilfe von:

```text
https://best11scouting.streamlit.app/
```

Best11Scouting wird von **Ben Griffis (@BeGriffis auf Twitter)** bereitgestellt.

Alle übrigen Spielerinformationen, insbesondere Stammdaten und Transfermarkt-Informationen wie Verein, Liga, Marktwert, Vertragslaufzeit oder Spielerprofil-Links, stammen von **transfermarkt.de**.

## Live-App

Die App läuft als Hugging-Face-Space:

```text
https://thebestian-fcn-datentool.hf.space/
```

## Daten- und Konfigurationsdateien

Die App erwartet folgende Dateien im Repository bzw. im Arbeitsverzeichnis des Spaces:

```text
fcn_datentool_app.ipynb
spieler_data.xlsx
weltklasse_referenz.xlsx
zweite_liga_referenz.xlsx
rollen_definitionen.xlsx
teambuilder_formationen.xlsx
Dockerfile
requirements.txt
```

### `spieler_data.xlsx`

Enthält die Spielerbasis inklusive Stammdaten, Transfermarkt-Informationen und Metrikwerten.

Die Datei kombiniert zwei Datenquellen:

* **Wyscout-Metriken**, ausgelesen über [Best11Scouting](https://best11scouting.streamlit.app/) von **@BeGriffis**
* **Transfermarkt-Daten** von [transfermarkt.de](https://www.transfermarkt.de/), insbesondere Stammdaten, Vereins- und Ligainformationen, Marktwerte, Vertragsdaten und Profil-Links

Die Datei bildet die Grundlage für:

* Rollenprofil-Berechnungen
* Spiderplot-Vergleiche
* Datenzwilling-Suche
* Teambuilder-Vorschläge

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

### Rollenprofil

Das Rollenprofil bewertet, wie gut ein Spieler statistisch zu definierten Rollen passt. Die App zeigt unter anderem:

* beste Rollen nach Fit oder Score
* Rollen-Fit
* finalen Rollen-Score
* passende Ideal- bzw. Referenzspieler
* Stärken und Schwächen je Rolle
* Metrik-Scores im Kontext der jeweiligen Rolle
* druckfähigen Spielersteckbrief

Der Toggle **Top 2 nach Fit / Top 2 nach Score** steuert, welche beiden Rollenprofile in der Detailansicht angezeigt werden.

### Metrikvergleich / Spiderplot

Der Spiderplot vergleicht Spieler innerhalb einer Positionsgruppe. Dabei wird ein FCN-Spieler als Referenz auf **100 %** normiert. Vergleichsspieler werden relativ zu diesem Referenzspieler dargestellt.

Die Ansicht eignet sich besonders, um konkrete Spielerprofile visuell gegenüberzustellen und Stärken/Schwächen entlang einzelner Metriken sichtbar zu machen.

### Datenzwilling finden

Die Datenzwilling-Funktion sucht den ähnlichsten Spieler im Gegenpool:

* FCN-Spieler werden nur mit Nicht-FCN-Spielern verglichen.
* Nicht-FCN-Spieler werden nur mit FCN-Spielern verglichen.
* Verglichen wird innerhalb derselben Positionsgruppe.
* Die Metrikdifferenzen werden über die Standardabweichung der Positionsgruppe normiert.
* Die normierten Differenzen werden zu einem Distanzmaß aufsummiert.
* Der niedrigste Wert entspricht dem ähnlichsten statistischen Profil.

Als Output zeigt die App:

* Ausgangsspieler und Datenzwilling im direkten Steckbriefvergleich
* Stammdaten und Transfermarkt-Daten beider Spieler
* beste zwei Rollen beider Spieler
* Top-5 ähnlichste Gegenpool-Spieler
* vollständigen Metrikvergleich
* Hervorhebung des jeweils besseren Metrikwerts

Die Top-5-Liste ist interaktiv: Spieler aus der Liste können direkt angeklickt werden, um die Gegenüberstellung gegen diesen Kandidaten neu zu rendern.

### Teambuilder

Der Teambuilder erstellt aus Formationenvorlagen eine rollenbasierte Elf. Für jeden Slot werden passende Spieler vorgeschlagen. Die Optimierung kann erfolgen nach:

* höchstem Score
* bestem Fit
* allen Spielern
* nur FCN-Spielern

Die Rollen werden auf einem Spielfeld visualisiert. Spieler können direkt in der Grafik über Alternativen ausgetauscht werden.

## Lokaler Start

Die App wird über Voilà aus dem Notebook gestartet. Im Docker-Setup des Hugging-Face-Spaces erfolgt das über den `CMD` im `Dockerfile`.

Lokal kann die App sinngemäß so gestartet werden:

```bash
voila fcn_datentool_app.ipynb --port=7860 --no-browser --Voila.ip=0.0.0.0
```

## Hinweise zur Pflege

* Rollen, Metriken und Gewichtungen werden in `rollen_definitionen.xlsx` gepflegt.
* Formationenvorlagen werden in `teambuilder_formationen.xlsx` gepflegt.
* Neue Rollen sollten sowohl in `rollen_definitionen.xlsx` als auch, falls im Teambuilder genutzt, in `teambuilder_formationen.xlsx` eingetragen werden.
* Neue Referenzrollen sollten über das Mapping in `Source_Roles` der Rollen-Excel sauber einer Makro-Rolle zugeordnet werden.
* Für die Datenzwilling-Suche sollten Spieler innerhalb einer Positionsgruppe möglichst konsistent mit denselben Metriken gepflegt sein.
* Die Dateinamen sollten im Space unverändert bleiben, da das Notebook die kanonischen Namen erwartet.

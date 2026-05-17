---
title: ClubProfile
emoji: ⚽
colorFrom: red
colorTo: gray
sdk: docker
app_port: 7860
---

# ClubProfile

Interaktive Voilà-App zur datenbasierten Evaluation von Spielerprofilen im Kontext des 1. FC Nürnberg.

ClubProfile kombiniert drei Analyseebenen:

1. **Rollenprofil**  
   Spieler werden anhand ihrer statistischen Profile mit verschiedenen Rollen verglichen. Die App zeigt passende Rollen, Rollen-Scores, Stärken/Schwächen und einen druckfähigen Spielersteckbrief.

2. **Metrikvergleich / Spiderplot**  
   Spieler können über positionsgruppenbasierte Spiderplots mit FCN-Referenzspielern verglichen werden. Der FCN-Spieler wird je Metrik auf **100 %** normiert. Vergleichsspieler werden relativ dazu dargestellt.

3. **Teambuilder**  
   Aus vordefinierten Formationsvorlagen können Rollen-Eleven erstellt werden. Die App schlägt Spieler für jede Rolle vor und optimiert die Besetzung wahlweise nach **Score** oder **Fit**, entweder aus allen Spielern oder nur aus FCN-   Spielern. Die Rollen werden positionsgetreu auf einem Spielfeld dargestellt und können direkt in der Grafik über Alternativen ausgetauscht werden.

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

Enthält die Spielerbasis inklusive Stammdaten und Metrikwerten.

### `weltklasse_referenz.xlsx` und `zweite_liga_referenz.xlsx`

Enthalten die Referenzspieler und Referenzwerte für die Rollenberechnung. Die App kann je nach Einstellung gegen Weltklasse- oder 2.-Bundesliga-Referenzen rechnen.

### `rollen_definitionen.xlsx`

Zentrale fachliche Rollen-Konfiguration. Hier werden gepflegt:

- verfügbare Rollen
- Rollenbeschreibungen
- zulässige Positionsfamilien
- verwendete Metriken je Rolle
- Gewichtung der Metriken

### `teambuilder_formationen.xlsx`

Konfiguriert die Vorlagen des Teambuilders. Hier werden gepflegt:

- Name der Formation
- Beschreibung der Formation
- 11 Slots je Vorlage
- Positionslabels
- zugewiesene Rolle je Slot
- X/Y-Koordinaten für die Spielfeldgrafik

## Lokaler Start

Die App wird über Voilà aus dem Notebook gestartet. Im Docker-Setup des Hugging-Face-Spaces erfolgt das über den `CMD` im `Dockerfile`.

Lokal kann die App sinngemäß so gestartet werden:

```bash
voila fcn_datentool_app.ipynb --port=7860 --no-browser --Voila.ip=0.0.0.0
```

## Hinweise zur Pflege

- Rollen, Metriken und Gewichtungen werden in `rollen_definitionen.xlsx` gepflegt.
- Formationenvorlagen werden in `teambuilder_formationen.xlsx` gepflegt.
- Neue Rollen sollten sowohl in `rollen_definitionen.xlsx` als auch, falls im Teambuilder genutzt, in `teambuilder_formationen.xlsx` eingetragen werden.
- Neue Referenzrollen sollten über das Mapping in `Source_Roles` der Rollen-Excel sauber einer Makro-Rolle zugeordnet werden.
- Die Dateinamen sollten im Space unverändert bleiben, da das Notebook die kanonischen Namen erwartet.

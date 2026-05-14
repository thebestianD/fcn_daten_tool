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

ClubProfile kombiniert zwei Analyseebenen:

1. **Rollenprofil**  
   Spieler werden anhand ihrer statistischen Profile mit verschiedenen Rollen verglichen. Die App zeigt passende Rollen, Rollen-Scores, Stärken/Schwächen und einen druckfähigen Spielersteckbrief.

2. **Metrikvergleich / Spiderplot**  
   Spieler können über positionsgruppenbasierte Spiderplots mit FCN-Referenzspielern verglichen werden. Der FCN-Spieler wird je Metrik auf **100 %** normiert. Vergleichsspieler werden relativ dazu dargestellt.

## Live-App

Die App läuft als Hugging-Face-Space:

```text
https://thebestian-fcn-datentool.hf.space/

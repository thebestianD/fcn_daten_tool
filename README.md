---
title: FCN Datentool
emoji: ⚽
colorFrom: red
colorTo: gray
sdk: docker
app_port: 7860
---

# FCN Datentool – Spiderplot-App

Interaktive Voilà-App zur datenbasierten Evaluation von Spielern des 1. FC Nürnberg im Vergleich mit externen Spielern derselben Positionsgruppe.

Die App erzeugt Spiderplots, in denen ein FCN-Spieler als Referenz auf **100 %** normalisiert wird. Vergleichsspieler werden relativ zu diesem Referenzspieler dargestellt. Zusätzlich werden absolute Referenzwerte, Transfermarkt-Steckbriefe und Profil-Links angezeigt.

## Inhalt

- `fcn_datentool_app.ipynb` – Hauptnotebook / Voilà-App
- `requirements.txt` – benötigte Python-Pakete
- exbedded_excel_base64.txt – Externe Kopie der Datengrundlage 

Die Datengrundlage ist direkt im Notebook eingebettet. Es muss keine separate Excel-Datei hochgeladen werden.

## Installation

Repository klonen:

```bash
git clone https://github.com/thebestianD/fcn_daten_tool.git
cd fcn_daten_tool

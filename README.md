# NOWA Investor / Partner Update — Image Hosting

Static image hosting for NOWA's monthly partner-update emails, served via GitHub Pages.

**Live URL:** `https://nowa-technologies.github.io/nowa-investor-updates/`

## Why this repo exists

Emails sent to investors / partners contain photos (factory, prototypes, team, app screenshots). Embedding these as base64 in the email itself blows past Gmail's ~102 KB clip threshold and forces aggressive compression. Hosting the images here lets the email reference URLs, keeps the email small (~30 KB), and keeps image quality high.

## Folder structure

```
2026-05/
  hero.jpg          ← top banner of the email
  prototype.jpg     ← hardware section, image 1
  factory.jpg       ← hardware section, image 2
  mission.jpg       ← software/mission section
  logo.png          ← NOWA wordmark for header (white, transparent)
2026-06/
  …same pattern…
```

One folder per month. File names stay the same so the email template doesn't need to change much month-to-month — only the folder name in the URL.

## How to add images for a new month

```bash
cd /path/to/nowa-investor-updates
git pull
mkdir 2026-06
cp /path/to/new-images/*.jpg 2026-06/
git add 2026-06
git commit -m "Add June 2026 images"
git push
```

Wait ~1 minute for GitHub Pages to deploy, then images are live at:
`https://nowa-technologies.github.io/nowa-investor-updates/2026-06/hero.jpg`

## Image size guidelines

- Hero: 600×340, JPEG q80 (~50 KB)
- Hardware / software panels: 260×200, JPEG q80 (~20 KB each)
- Mission: 520×280, JPEG q80 (~30 KB)
- Logo: PNG with transparency, 360px wide (~10 KB)

## Visibility

This repo is **public** because GitHub Pages on a Team-plan org doesn't allow private-repo Pages.

The images themselves are non-sensitive once the email goes out to investors (they would see them anyway). A `robots.txt` discourages search-engine indexing of the URLs.

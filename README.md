# PBN – struktura repozytorium

Repozytorium gromadzi surowe i opracowane materiały contentowe (artykuły źródłowe, analizy konkurencji, pomysły na tematy) dla wielu domen (np. `3.info.pl`, `a.biz.pl`, `abcpodatki.pl`).

## Struktura katalogów
- `configuration/` – pliki konfiguracyjne domen (np. `3_info_pl.conf`, `a_biz_pl.conf`, `abcpodatki_pl.conf`) z nazwą domeny, liczbą tematów/miesiąc oraz konkurentami.
- `post-data/` – zrzuty/opisy artykułów w podkatalogach per domena (`3_info_pl/`, `a_biz_pl/`, `abcpodatki_pl/`); każdy plik Markdown odpowiada jednemu wpisowi.
- `competitors/` – materiały konkurencji (np. pełne treści postów lub wycinki); duże pliki Markdown jak `infakt_pl.md`, `taxcoach_pl.md`.
- `topic-suggestions/` – listy proponowanych tematów i roadmapy publikacji (obecnie `topics-3_info_pl.md` z planem na 2026).

## Jak korzystać i rozszerzać
- Dodanie nowej domeny: utwórz `configuration/<domena>.conf` (domena, liczba tematów, lista konkurentów), dodaj katalog `post-data/<domena>/` z plikami wpisów oraz ewentualne materiały konkurencji w `competitors/` i plan tematów w `topic-suggestions/`.
- Pliki źródłowe są duże (setki tysięcy linii); pracuj na wycinkach lub używaj narzędzi stronicujących, by uniknąć problemów z pamięcią.
- Treści są w języku polskim; zachowuj kodowanie UTF-8 oraz format Markdown.

## Konwencje nazw
- `<domena>.conf` – konfiguracja domeny i konkurencji.
- `<domena>.md` w `post-data/` – artykuły z danej domeny.
- `<konkurent>.md` w `competitors/` – treści konkurencyjne.
- `topics-<domena>.md` – lista tematów i pomysłów dla domeny.
- `post-data/<domena>-index.json` – manifest listy plików `.md` dla danej domeny (używany przez stronę `index.html`, gdy listing katalogu jest niedostępny).

## Manifesty i aktualizacja
- Manifesty są generowane dla: `3_info_pl`, `a_biz_pl`, `abcpodatki_pl`.
- Aby wygenerować/odświeżyć manifesty, uruchom w katalogu repo:
  - `powershell -NoProfile -File generate-manifests.ps1`
- Wynik: pliki `post-data/3_info_pl-index.json`, `post-data/a_biz_pl-index.json`, `post-data/abcpodatki_pl-index.json` z listą obiektów `{ path, title }`, gdzie `title` pochodzi z linii `title:` w pliku `.md`.


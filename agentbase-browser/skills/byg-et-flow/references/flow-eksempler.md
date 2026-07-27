# Flow-former at starte fra

Genkendelige mønstre for AgentBase-flows. Brug dem til at foreslå brugeren en
form — vælg den, der passer til processen, og byg videre derfra. **Byggeklods-
navnene her er til orientering; bekræft altid de præcise håndtag (handles) med
`get_node_type`, og hent den kopiklare graf fra MCP'ens egne `example://`-
ressourcer.** MCP'ens `guide://flow-building` er den tekniske kanon.

## 1. Dokument → struktureret data → regneark

Læs et dokument, træk bestemte felter ud som struktureret data, og skriv dem i
faste kolonner i et regneark.

- **Byggeklodser:** Dokument-OCR → Sprogmodel (med `response_schema`) → JSON til Excel.
  Til mange filer på én gang: Dokumentliste → Fil til struktureret data → JSON til Excel.
- **Brug den til:** fakturaer, kontrakter eller ansøgninger, hvor bestemte felter
  skal ud i faste kolonner.
- **MCP-eksempler:** `example://document-ocr-extract`, `example://file-to-structured`,
  `example://json-to-excel`.

## 2. Sortér en bunke dokumenter

Upload mange blandede dokumenter, lad platformen klassificere hvert enkelt i en
kategori, du definerer, og træk valgfrie felter ud pr. kategori.

- **Byggeklodser:** Sortér dokumenter (én output-kanal pr. kategori) → fx JSON til
  Excel og/eller Sprogmodel (opsummering) pr. kategori.
- **Brug den til:** at rydde op i en blandet mappe af bilag, hvor hvert dokument
  skal i den rigtige kasse.
- **MCP-eksempel:** `example://sort-documents`.

## 3. Behandl hvert element i en liste (løkke)

Gør det samme for hvert element i en liste — fx kør en sprogmodel på hver række
i et regneark eller hvert dokument i en bunke.

- **Byggeklodser:** (kilde, fx CSV-parser) → Løkke Start → behandling (fx
  Sprogmodel) → Løkke Slut (samler resultaterne).
- **Brug den til:** at anvende samme analyse på mange rækker, filer eller opslag.
- **MCP-eksempel:** `example://csv-enrich`.

## 4. Betinget forgrening

Send flowet ned ad forskellige veje afhængigt af en værdi.

- **Byggeklodser:** Hvis / ellers (to grene, styret af en struktureret `config` —
  ikke en sætning) eller Forgrening (flere grene efter værdi-match). Begge grene
  føres typisk videre til samme næste trin — kun den gren, der matcher, giver output.
- **Brug den til:** at behandle sager forskelligt efter type, beløb eller status.
- **MCP-eksempel:** `example://if-else-branching` (og `guide://flow-building` for
  den fulde `config`-form — den er ikke oplagt).

## Almindelige faldgruber

- **Brug ikke en kode-byggeklods (`python-code`) som type-oversætter.** Skal en fil
  laves om til tekst, brug Dokument-OCR; skal tekst laves til JSON, brug Sprogmodel
  med et `response_schema`.
- **Hvis / ellers** styres af en struktureret `config`, ikke en fritekst-sætning,
  og begge grene (sand/falsk) skal føres videre.
- **Løkke-styring** (afbryd/spring over) hører til *inde* i en løkke.
- Skriv alt, brugeren ser (labels, instruktioner, skabelontekst, prompts), på dansk.

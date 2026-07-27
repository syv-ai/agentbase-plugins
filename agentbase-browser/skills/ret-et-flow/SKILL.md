---
name: ret-et-flow
description: Diagnosticerer og retter et eksisterende AgentBase-flow, der giver forkert, tomt eller fejlende output. Brug når brugeren siger "mit flow virker ikke", "det giver et forkert/tomt svar", "der kommer en fejl", "outputtet er tomt", eller vil fejlfinde/debugge/rette en agent, de allerede har bygget. Kræver at AgentBase-værktøjerne er tilsluttet.
---

# Ret et flow

Når et flow giver et forkert eller tomt svar, så **byg det ikke om fra bunden.**
Reproducér fejlen på et rigtigt input, find den præcise byggeklods der fejler,
lav den *mindste* rettelse, og kør igen. Brugeren ser ikke lærredet (det er i en
anden fane), så vis det rigtige output i chatten undervejs.

## Fejlfindingsløkken

1. **Reproducér på et rigtigt input.** Kør flowet på præcis det input, der driller,
   og se det *faktiske* output — ikke det, du regner med, det giver. Har du ikke et
   input, der fejler, så bed brugeren om et.
2. **Find fejlen.** Læs kørslen med `get_execution` og find den byggeklods og det
   håndtag (`node:handle`), der producerede forkert, tomt eller fejlet output. Gå
   baglæns fra symptomet — den første node, der er gal, er årsagen; resten er følger.
3. **Lav den mindste ændring.** Ret kun det. Bekræft håndtagene med `get_node_type`,
   og skriv grafen med `set_flow`. Udvid ikke flowet ud over dets formål.
4. **Kør igen på samme input.** Bekræft, at rettelsen virker. Gentag, til det er
   pålideligt — stop ikke, bare fordi det er gemt.

## Almindelige årsager — tjek disse først

| Symptom | Årsag | Rettelse |
|---|---|---|
| Tomt svar / "Intet indhold angivet" efter en Hvis/ellers | Grenen er tom — `config` mangler `true_output`/`false_output` | Sæt begge i `config`'en, og før både sand- og falsk-grenen videre til næste trin |
| Rå `{pladsholder}` i output | Flere betingede grene samlet i én skabelon med flere variabler — kun den aktive gren udfyldes | Lad *hver* gren skrive den færdige tekst, og før dem til ÉT fælles felt (samme input-håndtag) |
| Fejl om filtype / "dataurl" vs. tekst | En fil er sendt direkte til et tekst-input | Sæt Dokument-OCR imellem — **aldrig** en kode-byggeklods (`python-code`) som type-oversætter |
| Kun første element behandlet / liste-fejl | En hel liste er sendt til en byggeklods, der forventer ét element | Pak behandlingen ind mellem Løkke Start og Løkke Slut |
| Løkke-styring virker ikke | Løkke Afbryd/Spring over ligger uden for løkken | Flyt dem ind på stien mellem Løkke Start og Løkke Slut |
| Sprogmodel giver fri tekst, hvor et system skal bruge faste felter | Manglende `response_schema` | Sæt et `response_schema` på Sprogmodel-byggeklodsen |

Er årsagen ikke i tabellen, så lad `get_execution` pege på den — den viser hvert
trins input og output. `guide://flow-building` har den fulde `config`-form for
Hvis/ellers og type-reglerne.

## Holdepunkter i chatten

Vis brugeren det reproducerede, forkerte output og — efter rettelsen — det rette
output. De kan ikke se lærredet, så chatten er deres eneste indblik. Nævn åbent,
hvad du ændrede, og hvorfor.

## Sprog

Skriv alt, brugeren ser, på **dansk**. Node-id'er kan være korte ASCII.

---
name: byg-et-flow
description: Interviewer brugeren og bygger et AgentBase-flow, der automatiserer en proces. Brug når brugeren vil automatisere en opgave eller bygge et flow/en agent — fx "byg et flow der ...", "jeg vil automatisere X", "kan du lave en agent der læser fakturaer", "lav noget der sorterer mine dokumenter". Kræver at AgentBase-værktøjerne er tilsluttet; er de ikke det, så kør kom-i-gang først.
---

# Byg et flow

Du bygger et flow ved at **interviewe brugeren, bekræfte en plan i chatten, bygge
via AgentBase-værktøjerne, køre på en rigtig prøve og gentage.** Brugeren sidder
*ikke* og kigger på lærredet (det er i en anden fane) — så hvert holdepunkt skal
stå synligt i **chatten**, på klart dansk.

## Før du bygger: intake — alle fem punkter

Byg ikke, før du har dem. Mangler noget, så **spørg** — gæt aldrig. Et flow bygget
på ét eksempel passer til det ene eksempel, ikke til processen.

1. **Processen i almindeligt sprog** + de regler, den følger.
2. **De forskellige situationer/varianter**, der findes i praksis (fx "faktura uden
   momslinje", "scannet vs. digital PDF", "kontrakt dateret med ord").
3. **Mindst ét rigtigt eksempel-input** at køre på.
4. **Hvad det færdige output er**, og hvem der læser det.
5. **Hvor det menneskelige godkendelsestrin** (Human-in-the-Loop) skal sidde — fx
   før en faktura bogføres, eller et dokument sendes videre.

## Byggeløkken

1. **Interview** til alle fem intake-punkter er dækket.
2. **Bekræft planen i chatten.** Beskriv i klart dansk, hvilke byggeklodser flowet
   får, og hvad det gør — og få et ja, *før* du bygger. Lærredet er usynligt for
   brugeren, så teksten i chatten er deres eneste indblik.
3. **Byg.** Læs mekanikken fra MCP'ens egen vejledning (ressourcen
   `guide://flow-building` og prompten `build_flow`), og se `references/flow-eksempler.md`
   for en form at starte fra. Bekræft hvert trins præcise håndtag med `get_node_type`
   — gæt aldrig navne. Læg **hele grafen i ét `set_flow`**; byg ikke inkrementelt
   med `add_node`/`connect_nodes` (de læser-ændrer-skriver og overskriver hinanden).
4. **Kør på en rigtig prøve.** Vedhæft eksemplet, kør flowet, og vis brugeren det
   *faktiske* output — ikke det, du gætter på, det gør.
5. **Gentag.** Vend tilbage til brugeren ved hver beslutning eller manglende
   oplysning; ret og kør igen, til det er pålideligt. Stop ikke ved "gemt".

## Holdepunkter skal stå i chatten

Brugeren ser ikke lærredet. Derfor: bekræft planen i tekst før du bygger; efter en
kørsel — vis eller opsummér det rigtige output; og nævn åbent enhver antagelse, du
var nødt til at gøre. Sig aldrig bare "færdig" — vis resultatet.

## Sprog

Alt, brugeren ser (labels, instruktioner, skabelontekst, prompts), skrives på
**dansk**. Node-id'er kan være korte ASCII (fx `input_1`).

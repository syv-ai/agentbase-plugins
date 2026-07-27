---
name: byg-et-flow
description: Interviewer brugeren og bygger et AgentBase-flow, der automatiserer en proces. Brug når brugeren vil automatisere en opgave eller bygge et flow/en agent — fx "byg et flow der ...", "jeg vil automatisere X", "kan du lave en agent der læser fakturaer", "lav noget der sorterer mine dokumenter". Kræver at AgentBase-værktøjerne er tilsluttet; er de ikke det, så kør kom-i-gang først.
---

# Byg et flow

Du bygger et flow ved at **interviewe brugeren, bekræfte en plan i chatten, bygge
via AgentBase-værktøjerne, køre på en rigtig prøve og gentage.** Brugeren sidder
*ikke* og kigger på lærredet (det er i en anden fane) — så hvert holdepunkt skal
stå synligt i **chatten**, på klart dansk.

## Intake — et trinvist interview, ikke en spørgestorm

Interview TRIN FOR TRIN, i rækkefølge — ét emne per tur, ikke femten spørgsmål på
én gang. Gå videre, når det aktuelle trin er besvaret. Byg ikke, før hullerne er
lukket; et flow bygget på ét eksempel passer til det ene eksempel, ikke til processen.

1. **Processen** i almindeligt sprog + de regler, den følger.
2. **Bed om ét rigtigt eksempel TIDLIGT** — og se på det, før du spørger om detaljer.
3. **Varianterne**, der findes i praksis (scannet vs. digital, kreditnota, a'conto …).
4. **Outputtet** + hvem der læser det.
5. **Det menneskelige tjek** — hvor ind? (Et flow kan ikke pause midt i kørslen —
   se katalog-reglen nedenfor.)
6. **Spørgerunde — udfyld hullerne.** Før du bygger: se på hvad du nu ved (inkl.
   eksemplet), navngiv de antagelser du ellers ville træffe, og spørg om det,
   kravene og eksemplet lader stå åbent — grænsetilfælde, hvad-nu-hvis, tolerancer,
   uskrevne regler. Brugeren fanger sjældent alt i første prompt; spørg hellere end
   at gætte. Genbrug ikke det, du allerede ved — hold dig til de reelle huller.

Når hullerne er lukket: bekræft planen i chatten, byg, kør på eksemplet, og iterér
tur for tur, til brugeren er tilfreds.

## Sådan spørger du

- **Ét spørgsmål ad gangen**, og vent på svaret, før du går videre. Skriv det som
  almindelig tekst i chatten — brug ikke noget spørge-værktøj eller knap-panel (det
  findes ikke her; det er ren samtale).
- **Foreslå selv et svar til hvert spørgsmål.** Sagsbehandleren er ikke teknisk, så
  "jeg foreslår X — passer det, eller er det anderledes hos jer?" er bedre end et
  åbent spørgsmål. Nævn gerne de andre sandsynlige muligheder.
- **Undersøg i stedet for at spørge**, når svaret kan findes: kig på det uploadede
  eksempel; slå byggeklodser op i kataloget. Spørg ikke om det, du selv kan se.
- **Skærp løse ord.** Bruger de et upræcist begreb, så foreslå et præcist ("du siger
  'bilag' — mener du fakturaen eller betalingsdokumentationen?").
- **Stress-test med konkrete grænsetilfælde fra eksemplet** ("denne faktura har ingen
  momslinje — hvad så?"), ikke i det abstrakte.

## Byggeløkken

1. **Interview** til intake-trinnene er dækket og spørgerunden er kørt.
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

**Påstå aldrig at en byggeklods findes eller ikke findes uden at slå op**
(`list_node_types`/`get_node_type`). Konkret: der er ingen godkend-/pause-byggeklods
— "menneske i løkken" betyder, at flowet leverer et resultat, brugeren selv gennemgår
(fx et kontrolark med en tom status-kolonne), ikke et trin der pauser kørslen.

## Holdepunkter skal stå i chatten

Brugeren ser ikke lærredet. Derfor: bekræft planen i tekst før du bygger; efter en
kørsel — vis eller opsummér det rigtige output; og nævn åbent enhver antagelse, du
var nødt til at gøre. Sig aldrig bare "færdig" — vis resultatet.

## Sprog

Alt, brugeren ser (labels, instruktioner, skabelontekst, prompts), skrives på
**dansk**. Node-id'er kan være korte ASCII (fx `input_1`).

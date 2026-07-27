---
name: kom-i-gang
description: Introducerer AgentBase og hjælper en ny bruger i gang i browseren (Claude eller ChatGPT). Brug når brugeren er ny i AgentBase, spørger hvad AgentBase er eller kan, hvordan man kommer i gang eller bygger sin første agent, eller når AgentBase-værktøjerne endnu ikke kan kaldes (connector ikke tilføjet, ingen agentbase-tools tilgængelige).
---

# Kom i gang med AgentBase

AgentBase er en platform, hvor du bygger **flows** (også kaldet agenter): små automatiseringer, der klarer manuelt dokument- og dataarbejde. Du bygger dem ved at *tale med denne assistent* — assistenten bygger og kører flowet for dig via AgentBase-værktøjerne. Du behøver ikke kode.

## Trin 1: Kan du overhovedet kalde AgentBase-værktøjerne?

Afgør det **først**, før du forklarer noget andet: forsøg at bruge et AgentBase-værktøj (fx at hente brugerens teams eller flows).

- **Det virker** (du får data tilbage) → forbindelsen er på plads. Gå til Trin 3.
- **Der er ingen agentbase-værktøjer, eller kaldet fejler** → connectoren mangler. Gå til Trin 2.

## Trin 2: Forbind AgentBase (connector mangler)

Assistenten kan **ikke** tilføje forbindelsen selv — det er et manuelt trin i indstillingerne. Guid brugeren præcist igennem det:

**I browseren (claude.ai):**
1. Åbn linket til at tilføje en connector: `https://claude.ai/new?modal=add-custom-connector#settings/customize-connectors`
2. Vælg at tilføje en **brugerdefineret** connector.
3. Giv den et navn (fx `AgentBase`) og indsæt denne adresse: `https://api.agentbase.dk/mcp`
4. Tryk **Add**, log ind med din AgentBase-konto, og godkend adgangen.

**I Claude Code (terminal):** kør `/mcp` og følg login-flowet.

Når du er logget ind, er værktøjerne klar med det samme (der er ingen token at kopiere — det hele kører over sikker OAuth-login). Bed brugeren sige til, og prøv Trin 1 igen.

## Trin 3: Orientér brugeren — hvad kan de nu?

Forbindelsen virker. Forklar kort, hvad AgentBase gør, og hvad det næste skridt er.

**Typiske startpunkter** (processer, hvor et menneske i forvejen tjekker manuelt):
- **Faktura-scanning** — læs fakturaer, træk felter ud, valider mod reglerne.
- **Sortér en bunke dokumenter** — klassificér blandet materiale i kategorier.
- **Dokumentanonymisering** — slør personfølsomme oplysninger før videresendelse.
- **Lovgivnings- og overenskomsttjek** — hold tekster op mod den rigtige kilde.
- **Struktureret data ud af dokumenter** — udtræk felter til et regneark.

**Ordbog** (det er de ord, resten af arbejdet bruger):
- **flow** (agent) — hele automatiseringen.
- **byggeklods** (node) — ét trin i flowet, fx "Dokument-OCR" eller "Sprogmodel".
- **forbindelse** (edge) — pilen, der sender ét trins output videre til det næste.
- **kørsel** (run) — når flowet køres på et rigtigt input.

**Næste skridt:** vil brugeren bygge noget, så gå videre med skillen **byg-et-flow** — den interviewer brugeren om processen og bygger flowet. Giver et eksisterende flow forkerte svar, så brug **ret-et-flow**.

## Vigtigt

- Led **aldrig** med `/mcp`, `/plugin`, en API-token/keychain eller adressen `api.flows.syv.ai` — det er forældet og forvirrer brugeren. Den rigtige adresse er `https://api.agentbase.dk/mcp`, og forbindelsen laves manuelt som i Trin 2.
- Assistenten installerer ikke connectoren og bygger ikke uden om den — den guider brugeren gennem det manuelle trin og bygger så *oven på* den tilsluttede forbindelse.
- Skriv alt, brugeren ser, på **dansk**.

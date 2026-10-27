[README.md](https://github.com/user-attachments/files/34024874/README.md)
# Oppussingsplanlegger

Mobilvennlig norsk kalkulator for oppussing: rom, materialer, maling, produktsammenligning og budsjett.

## Publisering med GitHub Pages

1. Opprett et GitHub-repository, for eksempel `oppussingsplanlegger`.
2. Last opp `index.html` og `README.md` til roten av repositoryet på `main`.
3. Åpne **Settings → Pages → Build and deployment**.
4. Velg **Deploy from a branch**, `main`, og `/ (root)`; lagre.
5. Nettadressen blir normalt `https://BRUKERNAVN.github.io/oppussingsplanlegger/`.

Appen kjører i nettleseren uten egen backend. Data kan bli lagret lokalt på enheten/nettleseren, og er ikke synkronisert mellom enheter. Unngå å slette nettleserdata før du har eksportert en sikkerhetskopi.

## Lagring i Supabase (synkronisering)

Appen støtter både lokal lagring og skybasert lagring. Oppsett:
1. Åpne Supabase-prosjektet og kjør innholdet i `supabase-setup.sql` i **SQL Editor**.
2. Under **Authentication → Providers → Email**, aktiver e-postinnlogging (OTP / Magic Link).
3. Under **Authentication → URL Configuration**, sett **Site URL** til adressen der appen er publisert, og legg samme adresse i **Redirect URLs** (for eksempel `https://gstenseng.github.io/oppussing/**` hvis GitHub Pages benyttes).
4. Åpne appen, skriv inn e-postadressen og følg innloggingslenken.
5. Etter innlogging vil appen laste prosjektet fra skyen eller opprette et nytt basert på lokale data. Dersom de er ulike, får du velge hvilken versjon du vil beholde.

**Sikkerhet:** Tabellen har Row Level Security (RLS) aktivert slik at innloggede brukere bare kan lese/endre sin egen prosjektpost. Bruk bare offentlig publishable/anon-nøkkel i frontend; aldri service_role eller hemmelige nøkler. Lokal backup/CSV fungerer fortsatt.


# MyMoneyFolder: come pubblicarla come app personale

Questa cartella contiene tutto il necessario: l'app (`index.html`), le impostazioni (`config.js`), i file che la rendono installabile sul telefono (`manifest.webmanifest`, `sw.js` e le icone) e lo script per il database (`supabase.sql`).

Il percorso richiede circa 20 minuti la prima volta. Alla fine avrai un indirizzo tuo, un accesso con email e password e i dati sincronizzati tra telefono e computer.

## 1. Crea il progetto Supabase

1. Vai su [supabase.com](https://supabase.com) e crea un account gratuito (puoi entrare anche con GitHub).
2. Premi **New project**. Dagli un nome, ad esempio *mymoneyfolder*, scegli una password per il database (salvala da qualche parte, non servirà all'app) e come regione scegli **Central EU (Frankfurt)**, la più vicina all'Italia.
3. Aspetta un paio di minuti che il progetto sia pronto.

## 2. Crea la tabella dei dati

1. Nel menu a sinistra apri **SQL Editor** e crea una nuova query.
2. Apri il file `supabase.sql`, copia tutto il contenuto, incollalo e premi **Run**.
3. Deve comparire un messaggio di successo. Lo script crea la tabella e le regole che permettono a ogni utente di leggere e modificare solo i propri dati.

## 3. Disattiva la conferma via email

L'app usa email e password. Per non dover configurare un servizio di invio email, disattiva la conferma dell'indirizzo:

1. Apri **Authentication → Sign In / Providers** e clicca su **Email**.
2. Disattiva **Confirm email** e salva.

Lascia per ora attivo **Allow new users to sign up**: lo chiuderai al passo 7, dopo aver creato il tuo account.

## 4. Copia i due codici del progetto in `config.js`

1. Apri **Project Settings** (l'ingranaggio), poi **Data API** per copiare il **Project URL** (tipo `https://abcdefghijkl.supabase.co`).
2. Sempre in Project Settings apri **API Keys** e copia la chiave **publishable** (inizia con `sb_publishable_`). Se nel tuo progetto vedi solo le chiavi legacy, usa quella chiamata **anon public**.
3. Apri `config.js` con un editor di testo e incolla i due valori tra le virgolette:

   ```js
   window.CONTI_CONFIG = {
     supabaseUrl: "https://abcdefghijkl.supabase.co",
     supabaseKey: "sb_publishable_..."
   };
   ```

Questa chiave è fatta per stare in una pagina pubblica: i tuoi dati sono protetti dalle regole create al passo 2. **Non usare mai** la chiave *secret* o *service_role*, che invece scavalca le regole.

## 5. Pubblica su GitHub Pages

1. Crea un account su [github.com](https://github.com) se non ce l'hai.
2. Premi **New repository**, chiamalo `mymoneyfolder`, lascialo **Public** e crealo.
3. Nella pagina del repository scegli **uploading an existing file** (oppure **Add file → Upload files**), trascina tutti i file di questa cartella e premi **Commit changes**.
4. Vai in **Settings → Pages**. In *Build and deployment* scegli **Deploy from a branch**, poi il ramo **main** e la cartella **/ (root)**, e premi **Save**.
5. Dopo un paio di minuti in alto compare l'indirizzo, del tipo `https://tuonome.github.io/mymoneyfolder/`.

Il repository è pubblico, quindi chiunque può vedere il codice dell'app, ma non i tuoi dati, che stanno solo su Supabase.

## 6. Collega l'indirizzo a Supabase

In Supabase apri **Authentication → URL Configuration** e come **Site URL** inserisci l'indirizzo di GitHub Pages. Salva.

## 7. Primo accesso e chiusura delle iscrizioni

1. Apri l'indirizzo, inserisci la tua email e una password di almeno 8 caratteri, poi premi **Prima volta? Crea l'account con questi dati**. Dalle volte successive userai **Accedi**.
2. Una volta dentro, torna in Supabase, apri **Authentication → Sign In / Providers** (o **Settings**) e disattiva **Allow new users to sign up**. Così solo tu puoi accedere, anche se qualcuno trova l'indirizzo. Il tuo accesso continua a funzionare.

## 8. Installala su telefono e computer

- **Android (Chrome):** apri l'indirizzo, accedi, poi menu ⋮ → **Installa app** o **Aggiungi a schermata Home**.
- **iPhone (Safari):** apri l'indirizzo, tocca Condividi → **Aggiungi alla schermata Home**, poi apri l'app dall'icona e accedi lì (l'app installata ha un accesso separato da Safari).
- **Computer (Chrome):** apri l'indirizzo e premi l'icona di installazione a destra nella barra degli indirizzi, oppure tienilo nei preferiti.

L'app funziona anche senza connessione: le modifiche fatte offline vengono sincronizzate appena torni online.

## Aggiornamenti

Quando ricevi una nuova versione di `index.html`, nel repository GitHub premi **Add file → Upload files**, carica il nuovo file sopra il vecchio e fai **Commit changes**. Non caricare un nuovo `config.js` vuoto sopra quello compilato. Se qualcosa non va, nella cronologia del repository puoi tornare alla versione precedente.

## Buono a sapersi

- **Password:** non c'è un recupero automatico via email, quindi salvala nel gestore di password del browser o del telefono. Non eliminare il tuo utente da Supabase: verrebbero cancellati anche i dati collegati.
- **Inattività:** nel piano gratuito Supabase può mettere in pausa i progetti non usati per un po' di tempo. Se succede, riattivalo dal pannello di Supabase: i dati restano.
- **Backup:** in fondo all'app trovi **Scarica backup**. Ogni tanto conviene salvarne una copia, ad esempio una volta al mese.
- **Problemi di accesso:** se l'accesso fallisce con un errore di connessione, ricontrolla i due valori in `config.js`; se l'app ti dice che l'email non è confermata, ricontrolla il passo 3, elimina l'utente in **Authentication → Users** e crea di nuovo l'account.

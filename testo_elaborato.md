## Laboratorio di Architettura degli Elaboratori
## Elaborato ASM
## A.A 2022/2023
------------------------------------------------------------
## Descrizione:

Realizzare un programma Assembly per la gestione del menù cruscotto di un’automobile. Il menù dovrà
visualizzare e permettere l’impostazione delle seguenti informazioni: 
**data, ora, impostazione blocco automatico porte, back-home, check olio**. 

Se acceduto in **modalità supervisor**, il menù dovrà premettere
anche l’impostazione di **lampeggi frecce modalità autostrada** e **reset pressione gomme**.

-----------------------------------------------------------

## Specifiche:
Il programma potrà essere avviato in **due modalità**:
• utente (lanciando solo il nome dell’eseguibile da riga di comando)
• supervisor (lanciando il nome dell’eseguibile seguito dal codice 2244).

Se avviato in **modalità utente**, il programma dovrà visualizzare, una riga alla volta, il seguente menù,
partendo dalla prima riga e scorrendo sulle altre premendo il tasto freccia-giù/freccia-su+invio (inserire
freccia-giù+invio da messaggio di riga 6 corrisponde alla visualizzazione del messaggio riga 1):
    1. Setting automobile:
    2. Data: 15/06/2014
    3. Ora: 15:32
    4. Blocco automatico porte: ON
    5. Back-home: ON
    6. Check olio

Se avviato in **modalità supervisor**, il programma dovrà visualizzare la riga 1 nel seguente modo: “Setting
automobile (supervisor)”, e poter visualizzare anche le seguenti righe:
    7. Frecce direzione
    8. Reset pressione gomme

Ad ogni voce visualizzata, premendo i tasti **freccia-destra+invio** si potrà **entrare nel sottomenù**
corrispondente, nel quale verrà visualizzato lo stato attuale del setting e data la possibilità di impostazione.
Ad esempio, una volta visualizzato il menù “Blocco automatico porte: ON”, premendo il tasto freccia-
destra+invio, si dovrà permettere il cambiamento del setting ON, tramite i tasti fraccia-giù o freccia-
su+invio. In particolare, si dovrà permettere il setting dei sottomenù 4 e 5, con possibilità di impostazione
ON/OFF come nell’esempio sopra. I sottomenù 2, 3, 6, non dovranno essere implementati in questo
elaborato. All’interno di un sottomenù, il solo inserimento di invio da tastiera corrisponde al ritorno al
menù principale.

Se avviato in modalità supervisor, il sottomenù **“Frecce direzione”** dovrà visualizzare il numero dei lampeggi
modalità autostrada (3 per default) con possibilità di variazione (valore minimo 2, valore massimo 5)
tramite tastiera (valori inseriti fuori range corrispondono al setting del max/min valore). Nel sottomenù
**“Reset pressione gomme”**, inserendo il carattere freccia-destra seguito da invio, il menù dovrà restituire il
messaggio “Pressione gomme resettata” e tornare al menù principale.

-------------------------------------

## Materiale da consegnare:
Materiale da consegnare: Il codice e la relazione vanno compressi in un unico file tarball (.tar.gz)
denominato VRXXXXXX_VRXXXXXX.tar.gz, come precedentemente specificato nel progetto SIS. Devono
essere presenti:
• Sorgenti dell’intero progetto:
    o I file assembly necessari per implementare tutte le funzionalità (system calls, conversioni,
        ecc.), tipicamente un file per ogni funzione
    o Un singolo file che implementa in C il menù del cruscotto
• Relazione in formato pdf, denominata Relazione.pdf, che affronti nel dettaglio almeno i seguenti
    punti:
    o le variabili utilizzate e il loro scopo;
    o le modalità di passaggio/restituzione dei valori delle funzioni create;
    o il diagramma di flusso o lo pseudo-codice ad alto livello della funzionalitá;
    o la descrizione delle scelte progettuali effettuate.

Il pacchetto deve contenere un’unica cartella denominata asm/ la cui struttura dovrá essere:
• asm/
    o src/
        ▪ tutti i file con estensione .s
        ▪ il file .c di implementazione del cruscotto
    o obj/
        ▪ cartella di supporto per la creazione dell’eseguibile (vuota)
    o bin/
        ▪ cartella dove verrá creato l’eseguibile (vuota)
    o Makefile
        ▪ Makefile per la catena di compilazione. File oggetto generati in obj/ ed
        eseguibile generato in bin/
    o Relazione.pdf
        ▪ File contenente la relazione


## Per gli studenti che consegnano entrambi gli elaborati:
Verranno aperte due sezioni su moodle per la consegna sia di sis che di asm. Il nome dei file rimane
invariato (VRXXXXXX_VRXXXXXX.tar.gz). In questo modo sarà possibile inviare pacchetti di progetti da
gruppi diversi. La regola della singola consegna per gruppo è sempre valida.
Modalitá di consegna:
Tutto il materiale va consegnato elettronicamente tramite procedura guidata sul sito Moodle del corso.
Indicativamente 15 giorni prima della data di consegna sarà attivata una apposita sezione denominata
"consegna_ASM_mmmaaaa" (mmm=mese, aaaa=anno); accedendo a quella pagina sarà possibile
effettuare l'upload del materiale. La consegna del materiale comporta automaticamente l'iscrizione
all'appello orale. Si ricorda che è possibile effettuare più sottomissioni, ma ogni nuova sottomissione
cancella quella precedente. Ogni gruppo deve consegnare una sola volta il materiale, ovvero un solo
membro del gruppo deve effettuare la sottomissione!

#include <stdio.h>
#include <stdbool.h>
#include <string.h>

struct settings_utente {
    char data[11];
    char ora[6];
    bool blocco_porte;
    bool back_home;
    char check_olio[3];
};

struct settings_supervisor {
    int freccie_direzione;
    char* pressione_gomme;
};

void initialize_utente(struct settings_utente *utente)
{
    strcpy(utente->data, "15/06/2014");
    strcpy(utente->ora, "15:32");
    utente->blocco_porte = true;
    utente->back_home = true;
    strcpy(utente->check_olio, "ok");
}

void main(int argc, char *argv[])
{
    if (strcmp(argv[1], "2244") == 0)
        printf("%s", argv[1]);
    else
        printf("utente");

    struct settings_utente utente;

    initialize_utente(&utente);

    printf("\n%s", utente.data);


}
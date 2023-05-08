//* done voluntarily verbose thinking about future assembly code
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#define end_supervisor 6
#define end_user 4

struct settings_utente
{
    char data[11];
    char ora[6];
    bool blocco_porte;
    bool back_home;
    char check_olio[3];
};

struct settings_supervisor
{
    int frecce_direzione;
    char *pressione_gomme;
};

void initialize_utente(struct settings_utente *utente)
{
    strcpy(utente->data, "15/06/2014");
    strcpy(utente->ora, "15:32");
    utente->blocco_porte = true;
    utente->back_home = true;
    strcpy(utente->check_olio, "ok");
}

void initialize_supervisor(struct settings_supervisor *supervisor)
{
    supervisor->frecce_direzione = 3;
}

char *user_mods(int index)
{
    if (index == 0)
        return "data";
    else if (index == 1)
        return "ora";
    else if (index == 2)
        return "blocco porte";
    else if (index == 3)
        return "back home";
    else if (index == 4)
        return "check olio";
    else
        return "";
}

char *supervisor_mods(int index)
{
    if (index == 5)
        return "frecce direzione";
    else if (index == 6)
        return "pressione gomme";
}

void main(int argc, char *argv[])
{
    //* check if is supervisor
    int supervisor = 0;
    for (unsigned int i = 0; i < argc; i++)
        if (strcmp(argv[i], "2244") == 0)
            supervisor = 1;

    printf("%d", supervisor);

    //* init settings_utente
    struct settings_utente utente;

    initialize_utente(&utente);
    printf("data: %s", utente.data);

    //* choose stat to change
    int index = 0;
    char c;
    while (true)
    {
        scanf("%c", &c);
        if (c == '\033')
        {
            scanf("%c", &c);
            if (c == '[')
            {
                scanf("%c", &c);
                //* rollback and forward the menu settings
                if (c == 'A') //* up
                {
                    if (index == 0)
                    {
                        if (supervisor == 1)
                            index = end_supervisor;
                        else
                            index = end_user;
                    }
                    else
                        index -= 1;
                }
                else if (c == 'B') //* down
                {
                    if (index == end_user || index == end_supervisor)
                        index = 0;
                    else
                        index++;
                }

                //* print position in menu settings
                if (supervisor == 1)
                {
                    char *str = user_mods(index);
                    if (strcmp(str, "") == 0)
                        printf("%d: %s", index, supervisor_mods(index));
                    else
                        printf("%d: %s", index, str);
                }
                else
                    printf("%d: %s", index, user_mods(index));

                //* select a setting
                if (c == 'C') //* right
                {
                    //TODO
                }
            }
        }
    }
}
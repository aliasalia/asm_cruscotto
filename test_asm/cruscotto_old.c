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
    char blocco_porte[4];
    char back_home[4];
    char check_olio[3];
};

struct settings_supervisore
{
    char *frecce_direzione;
    char *pressione_gomme;
};

void initialize_utente(struct settings_utente *utente)
{
    strcpy(utente->data, "15/06/2014");
    strcpy(utente->ora, "15:32");
    strcpy(utente->blocco_porte, "ON");
    strcpy(utente->back_home, "ON");
    strcpy(utente->check_olio, "OK");
}

void initialize_supervisor(struct settings_supervisore *supervisore)
{
    strcpy(supervisore->frecce_direzione, "3");
    strcpy(supervisore->pressione_gomme, "Reset pressione gomme");
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

char *user_mods_get(struct settings_utente *utente, int index)
{
    if (index == 0)
        return utente->data;
    else if (index == 1)
        return utente->ora;
    else if (index == 2)
        return utente->blocco_porte;
    else if (index == 3)
        return utente->back_home;
    else if (index == 4)
        return utente->check_olio;
    else
        return "";
}

char *supervisor_mods_get(struct settings_supervisore *supervisore, int index)
{
    if (index == 5)
        return supervisore->frecce_direzione;
    else if (index == 6)
        return supervisore->pressione_gomme;
}

char *change_on_off(char *on_off)
{
    if (strcmp(on_off, "ON") == 0)
        return "OFF";
    else
        return "ON";
}

char *change_frecce_direzione(int intensity)
{
    if (intensity > 5)
        return "5";
    else if (intensity < 2)
        return "2";
    else
    {
        if (intensity % 3 == 0)
            return "3";
        else if (intensity % 4 == 0)
            return "4";
    }
    return "";
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

    struct settings_supervisore supervisore;

    if (supervisor == 1)
        initialize_supervisor(&supervisore);

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
                    //* see the setting specs
                    if (supervisor == 1)
                    {
                        char *str = user_mods_get(&utente, index);
                        if (strcmp(str, "") == 0)
                            printf(": %s", supervisor_mods_get(&supervisore, index));
                        else
                            printf(": %s", str);
                    }
                    else
                        printf(": %s", user_mods_get(&utente, index));

                    char n;
                    scanf("%c", &n);
                    //TODO not working
                    //* change the changable settings for ON/OFF
                    if ((n == 'A' || n == 'B') && index == 2)
                    {
                        strcpy(utente.blocco_porte, change_on_off(utente.blocco_porte));
                        printf("%s: %s", user_mods(index), utente.blocco_porte);
                    }
                    else if ((n == 'A' || n == 'B') && index == 3)
                    {
                        strcpy(utente.back_home, change_on_off(utente.back_home));
                        printf("%s: %s", user_mods(index), utente.back_home);
                    }
                    //* change the changable settings for frecce
                    if (index == 5)
                    {
                        strcpy(supervisore.frecce_direzione, change_frecce_direzione(c));
                        printf("%s: %s", user_mods(index), supervisore.frecce_direzione);
                    }
                    //* change the changable settings for pressione gomme
                    if (index == 6 && c == 'C')
                        printf("%s", supervisore.pressione_gomme);
                }
            }
        }
    }
}
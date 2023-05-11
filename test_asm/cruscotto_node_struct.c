//* done voluntarily verbose thinking about future assembly code
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#define end_supervisor 6
#define end_user 4

struct node
{
    int index;
    char *mode;
    int value;
    struct node *prev;
    struct node *next;
};

void init_node(struct node *node, int index, char *mode, int value, struct node *prev, struct node *next)
{
    node->index = index;
    node->mode = mode;
    node->value = value;
    node->prev = prev;
    node->next = next;
}

int main(int argc, char *argv[])
{
    //* check if is supervisor
    int supervisor = 0;
    for (unsigned int i = 0; i < argc; i++)
        if (strcmp(argv[i], "2244") == 0)
            supervisor = 1;

    //* initialize strings utente
    char *mod_setting = "1. Setting automobile:";
    char *mod_data = "2. Data";
    char *mod_ora = "3. Ora";
    char *mod_blocco_porte = "4. Blocco automatico porte";
    char *mod_back_home = "5. Back-home";
    char *mod_check_olio = "6. Check olio";
    char *mod_frecce, mod_p_gomme;
    if (supervisor == 1)
    {
        mod_setting = "1. Setting automobile (supervisor):";
        mod_frecce = "7. Frecce direzione";
        mod_p_gomme = "8. Reset pressione gomme";
    }

    //* data values
    char *data_value = "15/06/2014";
    char *ora_value = "15:32";
    char *olio_value = "OK";
    int blocco_porte_value = 1;
    int back_home_value = 1;
    int blinks = 3;
    char *reset_p_gomme = "Reset pressione gomme";

    //* creating nodes and initialize them
    struct node setting;
    struct node data;
    struct node ora;
    struct node blocco_porte;
    struct node back_home;
    struct node check_olio;
    struct node frecce;
    struct node p_gomme;

    if (supervisor == 1)
    {
        init_node(&setting, 1, mod_setting, 0, &p_gomme, &data);
        init_node(&frecce, 7, mod_frecce, &blinks, &check_olio, &p_gomme);
        init_node(&p_gomme, 8, mod_p_gomme, &reset_p_gomme, &frecce, &setting);
        init_node(&check_olio, 6, mod_check_olio, &olio_value, &back_home, &frecce);
    }
    else
    {
        init_node(&setting, 1, mod_setting, 0, &check_olio, &data);
        init_node(&check_olio, 6, mod_check_olio, &olio_value, &back_home, &setting);
    }

    init_node(&data, 2, mod_data, &data_value, &setting, &ora);
    init_node(&ora, 3, mod_ora, &ora_value, &data, &blocco_porte);
    init_node(&blocco_porte, 4, mod_blocco_porte, &blocco_porte_value, &ora, &back_home);
    init_node(&back_home, 5, mod_back_home, &back_home_value, &blocco_porte, &check_olio);

    //* creating list of nodes
    int cruscotto[8];
    cruscotto[0] = &setting;
    cruscotto[1] = &data;
    cruscotto[2] = &ora;
    cruscotto[3] = &blocco_porte;
    cruscotto[4] = &back_home;
    cruscotto[5] = &check_olio;
    if (supervisor == 1)
    {
        cruscotto[6] = &frecce;
        cruscotto[7] = &p_gomme;
    }
}

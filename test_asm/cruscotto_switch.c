//* done voluntarily verbose thinking about future assembly code
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#define end_supervisor 8
#define end_user 6

int go_to_sub_menu(int index, char *n)
{
    scanf("%c", &n);
    if (*n == '\033')
    {
        scanf("%c", &n);
        if (*n == '[')
        {
            scanf("%c", &n);
            if (*n == 'C') //* right
                return 1;
        }
    }
    return 0;
}

void index_position_message(int index, int supervisor)
{
    char n;
    switch (index)
    {
    case 1:
        if (supervisor == 1)
            printf("1. Setting automobile (supervisor):");
        else
            printf("1. Setting automobile:");
        break;
    case 2:
        printf("2. Data");
        if (go_to_sub_menu(index, &n) == 1)
            printf("15/06/2014");
        break;
    case 3:
        printf("3. Ora");
        if (go_to_sub_menu(index, &n) == 1)
            printf("15:32");
        break;
    case 4:
        printf("4. Blocco automatico porte");
        if (go_to_sub_menu(index, &n) == 1)
            //TODO
        break;
    case 5:
        printf("5. Back-home");
        if (go_to_sub_menu(index, &n) == 1)
            //TODO
    case 6:
        printf("6. Check olio");
        if (go_to_sub_menu(index, &n) == 1)
            printf("OK");
        break;
    case 7:
        printf("7. Frecce direzione");
        if (go_to_sub_menu(index, &n) == 1)
            //TODO
        break;
    case 8:
        printf("8. Reset pressione gomme");
        if (go_to_sub_menu(index, &n) == 1)
            printf("Reset pressione gomme");
        break;
    }
}

void index_to_end(int *index, int supervisor)
{
    if (supervisor == 1)
        *index = end_supervisor;
    else    
        *index = end_user;
}

int up_or_down_pressed(char *c)
{
    scanf("%c", &c);
    if (*c == '\033')
    {
        scanf("%c", &c);
        if (*c == '[')
        {
            scanf("%c", &c);
            if (*c == 'A') //* up
                return 1;
            else if (*c == 'B') //* down
                return 0;
        }
    }
    return -1;
}

void rollback_and_forward(int *index, char *c, int supervisor)
{
    int way = up_or_down_pressed(c);
    if (way == 1)
    {
        if (index == 0)
            index_to_end(index, supervisor);
        else
            index -= 1;
    }
    else if (way == 0)//* down
    {
        if (*index == end_user || *index == end_supervisor)
            index = 0;
        else
            index++;
    }
}

int main(int argc, char *argv[])
{
    //* check if is supervisor
    int supervisor = 0;
    for (unsigned int i = 0; i < argc; i++)
        if (strcmp(argv[i], "2244") == 0)
            supervisor = 1;
            
    int index = 1;
    char c;
    while (true)
    {
        index_position_message(index, supervisor);
        printf("prima %d", index);
        rollback_and_forward(&index, &c, supervisor);
        printf("dopo %d", index);
    }
}

//* done voluntarily verbose thinking about future assembly code
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#define end_supervisor 8
#define end_user 6

void index_position_message(int index, int supervisor)
{
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
        break;
    case 3:
        printf("3. Ora");
        break;
    case 4:
        printf("4. Blocco automatico porte");
        break;
    case 5:
        printf("5. Back-home");
        break;
    case 6:
        printf("6. Check olio");
        break;
    case 7:
        printf("7. Frecce direzione");
        break;
    case 8:
        printf("8. Reset pressione gomme");
        break;
    }
}

void index_position_default_value(int index)
{
    switch (index)
    {
    case 2:
        printf("15/06/2014");
        break;
    case 3:
        printf("15:32");
        break;
    case 6:
        printf("OK");
        break;
    case 8:
        printf("Reset pressione gomme");
        break;
    }
}

void index_to_end(int supervisor, int *index)
{
    if (supervisor == 1)
        index = end_supervisor;
    else    
        index = end_user;
}

void rollback_and_forward(int *index, char c)
{
    scanf("%c", &c);
    if (c == '\033')
    {
        scanf("%c", &c);
        if (c == '[')
        {
            scanf("%c", &c);
            if (c == 'A') //* up
            {
                if (index == 0)
                    index_to_end(&index);
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
        }
    }
}

void go_to_sub_menu(int *index, char *n)
{
    scanf("%c", &n);
    if (n == '\033')
    {
        scanf("%c", &n);
        if (n == '[')
        {
            scanf("%c", &n);
            if (n == 'C') //* right
            {
                if (index == 0)
                    index_to_end(&index);
                else
                    index -= 1;
            }
        }
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
        
    }
}

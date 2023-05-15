#include <stdio.h>
#include <string.h>

// global variables shared by all functions
int ind = 1;
int sub = 0;
int door_lock = 1;
int back_home = 1;

int move() {
    char c;
    scanf("%c", &c);
    if (c == '\033') {
        scanf("%c", &c);
        if (c == '[') {
            scanf("%c", &c);
            if (c == 'A') //* up
                return -1;
            else if (c == 'B') //* down
                return 1;
            else if (c == 'C') //* right
                return 2;
        }
    }
    return 0;
}

void index_position_message(int supervisor) {
    switch (ind) {
        case 1:
            if (supervisor == 1)
                printf("1. Setting automobile (supervisor):");
            else
                printf("1. Setting automobile:");
            break;
        case 2:
            printf("2. Data: 15/06/2014");
            break;
        case 3:
            printf("3. Ora: 15:32");
            break;
        case 4:
            if (sub) {
                int read = move();
                if (read == -1 || read == 1)
                    door_lock = !door_lock;
                sub = 0;
            }
            else {
                if (door_lock)
                    printf("4. Blocco automatico porte: ON");
                else
                    printf("4. Blocco automatico porte: OFF");
            }
            break;
        case 5:
            if (sub) {
                int read = move();
                if (read == -1 || read == 1)
                    back_home = !back_home;
                sub = 0;
            }
            else {
                if (back_home)
                    printf("5. Back-home: ON");
                else
                    printf("5. Back-home: OFF");
            }
            break;
        case 6:
            printf("6. Check olio");
            break;
        case 7:
            if (sub) {
                //scanf(...);
                sub = 0;
            }
            else {
                printf("7. Frecce direzione");
            }
            break;
        case 8:
            printf("8. Reset pressione gomme");
            if (sub) {
                printf("Pressione gomme resettata");
                sub = 0;
            }
            break;
    }
}

void navigate_menu(int supervisor) {
    int read = move();
    printf("Read: %d\n", read);
    if (read == 2 && ind != 2 && ind != 3 && ind != 6)
        sub = 1;
    else if (read != 2) {
        ind += read;
        if (supervisor && (ind < 1))
            ind = 8;
        else if (supervisor && (ind > 8))
            ind = 1;
        else if (!supervisor && ind < 1)
            ind = 6;
        else if (!supervisor && ind > 6)
            ind = 1;
    }
    index_position_message(supervisor);
}

int main(int argc, char *argv[]) {
    //* check if is supervisor
    int supervisor = 0;
    if (argc == 2 && strcmp(argv[1], "2244") == 0)
        supervisor = 1;

    index_position_message(supervisor);

    char tmp;
    while (1) {
        navigate_menu(supervisor);
        scanf("%c", &tmp);
    }

    return 0;
}

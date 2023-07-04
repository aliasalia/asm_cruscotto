#include <stdio.h>
#include <string.h>

// global variables shared by all functions
int ind = 1;
int sub = 0;
int door_lock = 1;
int back_home = 1;
int blinkers = 3;

int move() {
    char c, tmp;
    scanf("%c", &c);
    if (c == '\033') {
        scanf("%c", &c);
        if (c == '[') {
            scanf("%c", &c);
            scanf("%c", &tmp);
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

void set_blinkers() {
    char tmp, c;
    printf("Quante volte devono lampeggiare le frecce? ");
    scanf("%c", &c);
    scanf("%c", &tmp);
    if (c > 53)
        blinkers = 5;
    else if (c < 50)
        blinkers = 2;
    else
        blinkers = c - 48;
}

void index_position_message(int supervisor) {
    switch (ind) {
        case 1:
            if (supervisor == 1)
                printf("1. Setting automobile (supervisor): ");
            else
                printf("1. Setting automobile: ");
            break;
        case 2:
            printf("2. Data: 15/06/2014 ");
            break;
        case 3:
            printf("3. Ora: 15:32 ");
            break;
        case 4:
            if (sub) {
                printf("Clicca SU o GIU': ");
                int read = move();
                if (read == -1 || read == 1)
                    door_lock = !door_lock;
                sub = 0;
            }
            if (door_lock)
                printf("4. Blocco automatico porte: ON ");
            else
                printf("4. Blocco automatico porte: OFF ");
            break;
        case 5:
            if (sub) {
                printf("Clicca SU o GIU': ");
                int read = move();
                if (read == -1 || read == 1)
                    back_home = !back_home;
                sub = 0;
            }
            if (back_home)
                printf("5. Back-home: ON ");
            else
                printf("5. Back-home: OFF ");
            break;
        case 6:
            printf("6. Check olio ");
            break;
        case 7:
            if (sub) {
                set_blinkers();
                sub = 0;
            }
            printf("7. Frecce direzione: %d ", blinkers);
            break;
        case 8:
            if (sub) {
                printf("Pressione gomme resettata\n");
                sub = 0;
            }
            printf("8. Reset pressione gomme ");
            break;
    }
}

void navigate_menu(int supervisor) {
    int read = move();
    if (read == 2 && ind != 1 && ind != 2 && ind != 3 && ind != 6)
        sub = 1;
    else if (read != 2) {
        ind += read;
        if (supervisor) {
            if (ind < 1)
                ind = 8;
            else if (ind > 8)
                ind = 1;
        }
        else {
            if (ind < 1)
                ind = 6;
            else if (ind > 6)
                ind = 1;
        }
    }
    index_position_message(supervisor);
}

int main(int argc, char *argv[]) {
    //* check if is supervisor
    int supervisor = 0;
    if (argc == 2 && strcmp(argv[1], "2244") == 0)
        supervisor = 1;

    index_position_message(supervisor);

    while (1)
        navigate_menu(supervisor);

    return 0;
}

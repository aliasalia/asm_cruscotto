# Pseudocodice

// initiate some global variables shared by all functions  
ind = 1 // index var  
sub = 0 // submenu var  
door_lock = 1 // bool, true if doors auto lock is on  
back_home = 1 // bool, true if back home mode is on  
blinkers = 3 // how many times blinkers blink (supervisor mode)  

### MAIN(terminal input) // return int
    supervisor = 0
    if terminal input = 2244
        supervisor = 1

    index_position_message(supervisor);

    while (true)
        navigate_menu(supervisor)

    return 0

### MOVE() // return int
    get char c

    if (c = up)
        return -1
    else if (c = down)
        return 1
    else if (c = right)
        return 2

    return 0

### SET_BLINKERS()
    get n
    if (n > 5)
        blinkers = 5
    else if (n < 2)
        blinkers = 2
    else
        blinkers = n

### INDEX_POSITION_MESSAGE(supervisor)
    switch (ind)
        case 1:
            if (supervisor = 1)
                print "1. Setting automobile (supervisor):"
            else
                print "1. Setting automobile:"
        case 2:
            print "2. Data: 15/06/2014"
        case 3:
            print "3. Ora: 15:32"
        case 4:
            if (sub)
                read = move()
                if (read = -1 or read = 1)
                    door_lock = not(door_lock)
                sub = 0
            if (door_lock)
                print "4. Blocco automatico porte: ON"
            else
                print "4. Blocco automatico porte: OFF"
        case 5:
            if (sub)
                read = move();
                if (read = -1 or read = 1)
                    back_home = not(back_home)
                sub = 0
            if (back_home)
                print "5. Back-home: ON"
            else
                print "5. Back-home: OFF"
        case 6:
            print "6. Check olio"
        case 7:
            if (sub)
                set_blinkers()
                sub = 0
            print "7. Frecce direzione: *blinkers*"
        case 8:
            if (sub)
                print "Pressione gomme resettata"
                sub = 0
            print "8. Reset pressione gomme"

### void navigate_menu(supervisor)
    read = move()
    if (pressed right arrow and index has a submenu)
        sub = 1
    else if (pressed up or down)
        ind = ind + read
        if (supervisor = true)
            if (ind < 1)
                ind = 8
            else if (ind > 8)
                ind = 1
        else
            if (ind < 1)
                ind = 6
            else if (ind > 6)
                ind = 1
    index_position_message(supervisor);

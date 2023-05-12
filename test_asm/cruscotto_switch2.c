// is supervisor?
//     - SI : supervisor = 1
//     - NO : supervisor = 0

// ciclo
//     printf "1 ..."
//     is UP? 
//         if index == 1
//             if supervisor
//                 index = end_supervisor
//             else
//                 index = end_user
//             switch
//         else
//             index --
//             switch
//     is DOWN?
//         if index == end_*
//             index = 1
//             switch
//         else
//             index ++
//             switch

#include <stdio.h>

int main(int argc, char *argv[])
{
    //* check if is supervisor
    int supervisor = 0;
    for (unsigned int i = 0; i < argc; i++)
        if (strcmp(argv[i], "2244") == 0)
            supervisor = 1;
    
}
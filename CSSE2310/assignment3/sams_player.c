
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


struct Aplayer {
    int numPlayers;
    char playerName;
    char holding[5];
    char played[20];
    char status; /* either normail' ', dead '-' or sheilded '*'*/
    int score;
};


void new_round(char* input, struct Aplayer* players, int thisPlayer,
        int* theCards);
void your_turn(char* input, struct Aplayer* players, int thisPlayer,
        int* theCards);
void remove_card(int card, int* theCards);
void discard_8(struct Aplayer* players, int thisPlayer);
void discard_7(struct Aplayer* players, int thisPlayer);
void discard_6(struct Aplayer* players, int thisPlayer);
void discard_5(struct Aplayer* players, int thisPlayer);
void discard_4(struct Aplayer* players, int thisPlayer);
void discard_3(struct Aplayer* players, int thisPlayer);
void discard_2(struct Aplayer* players, int thisPlayer);
void discard_1(struct Aplayer* players, int thisPlayer, int* theCards);
char targeting_player(struct Aplayer* players, int thisPlater);
void player_stats(struct Aplayer* players, int thisPlayer);
void this_happened(char* input, struct Aplayer* players, int thisPlayer,
        int* theCards);
void replace_card(char* input, struct Aplayer* players, int thisPlayer);


int main (int argc, char *argv[]) {
    struct Aplayer* players;
    char input[25];
    int thisPlayer;    
    int theCards[16] = {1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8};
    fprintf(stdout, "-");
    if(argc != 3) {
        fprintf(stderr, "Usage: player number_of_players myid\n");
        exit(1);
    } else if(atoi(argv[1]) < 2 || atoi(argv[1]) > 4) {
        fprintf(stderr, "Invalid player count\n");
        exit(2);
    } else if (argv[2][0] < 'A' || argv[2][0] > 'D' ||
            atoi(argv[1]) < (argv[2][0] - 'A' + 1)) {
        fprintf(stderr, "Invalid player ID\n");
        exit(3);
    } else {
        players = malloc(atoi(argv[1]) * sizeof(*players));
        thisPlayer = argv[2][0] - 'A';
        for (int i = 0; i < atoi(argv[1]); i++) {
            players[i].numPlayers = atoi(argv[1]);
            players[i].playerName = 'A' + i;
            players[i].status = ' ';
            players[i].holding[0] = '-';
            players[i].holding[1] = '-';
        }
    }
    while(1) {
        if (fgets(input, 25, stdin) == NULL || input == NULL) {
            fprintf(stderr, "Unexpected loss of hub\n");
            exit(4);
        }
        fprintf(stderr, "From hub:%s", input);
        player_stats(players, thisPlayer);
        char* subinput;
        subinput = strtok(input, " ");
        if(strcmp(subinput, "newround") == 0) { 
            new_round(strtok(NULL, " "), players, thisPlayer, theCards);
        } else if (strcmp(subinput, "yourturn") == 0) {
            your_turn(strtok(NULL, " "), players, thisPlayer, theCards);
        } else if (strcmp(subinput, "thishappened") == 0) {
            this_happened(strtok(NULL, " "), players, thisPlayer, theCards);
        } else if (strcmp(subinput, "replace") == 0) {
            replace_card(strtok(NULL, " "), players, thisPlayer);
        } else if (strcmp(subinput, "scores") == 0) {
            for(int i = 0; i < players[thisPlayer].numPlayers; i++) {
                players[i].score = atoi(strtok(NULL, " "));
            }
            if(strtok(NULL, " ") != NULL) {
                fprintf(stderr, "Bad message from hub\n");
                exit(5);
            }    
        } else if (strcmp(subinput, "gameover\n") == 0) {
            exit(0);
        } else {
            fprintf(stderr, "Bad message from hub\n");
            exit(5);
        }
        player_stats(players, thisPlayer);
    }    
}


/*player_stats loops thourgh the array of plays and prints their 
 * name, status and what cards they have player thi rounf*/
void player_stats(struct Aplayer* players, int thisPlayer) {
    for(int i = 0; i < players[thisPlayer].numPlayers; i++) {
        char* status = malloc(20);
        status[0] = players[i].playerName;
        status[1] = players[i].status;
        status[2] = ':';
        strcat(status, players[i].played);
        fprintf(stderr, "%s\n", status);
    }
    fprintf(stderr, "You are holding:%s\n", players[thisPlayer].holding);
}


/*new_round resets the array of a full deck and resets each players
 * status and cards played. This player is also given a card*/
void new_round(char* input, struct Aplayer* players, int thisPlayer,
        int* theCards) {
    theCards[0] = 1;
    theCards[1] = 1;
    theCards[2] = 1;
    theCards[3] = 1;
    theCards[4] = 1;
    theCards[5] = 2;
    theCards[6] = 2;
    theCards[7] = 3;
    theCards[8] = 3;
    theCards[9] = 4;
    theCards[10] = 4;
    theCards[11] = 5;
    theCards[12] = 5;
    theCards[13] = 6;
    theCards[14] = 7;
    theCards[15] = 8;

    for(int i = 0; i < players[thisPlayer].numPlayers; i++) {
        players[i].status = ' ';
        strcpy(players[i].played, "");
    }     
    players[thisPlayer].holding[0] = input[0];
}


/*your_turn  determine what card to dicard. This is done by first
 * chec if you hold a 7 and either a 5 or 6 as this is a special case
 * where 7 is dicarded/ Otherwise the lower is dicarded. When the card
 * to be dicarded is decided a switcj leads to the function of what
 * the card will do*/
void your_turn(char* input, struct Aplayer* players, int thisPlayer,
        int* theCards) {
    char discard;  
    players[thisPlayer].holding[1] = input[0];
    player_stats(players, thisPlayer);
    players[thisPlayer].status = ' ';
    if ((players[thisPlayer].holding[0] == '7' ||
            players[thisPlayer].holding[1] == '7') &&
            (players[thisPlayer].holding[0] == '6' ||
            players[thisPlayer].holding[1] == '6' ||
            players[thisPlayer].holding[0] == '5' ||
            players[thisPlayer].holding[1] == '5')) { 
        if (players[thisPlayer].holding[0] == '7') {
            players[thisPlayer].holding[0] = players[thisPlayer].holding[1];
            players[thisPlayer].holding[1] = '-';
        }
        if (players[thisPlayer].holding[1] == '7') {
            players[thisPlayer].holding[1] = '-';
        }
        discard = '7';
    } else if (players[thisPlayer].holding[0] <
            players[thisPlayer].holding[1]) {
        discard = players[thisPlayer].holding[0];
        players[thisPlayer].holding[0] = players[thisPlayer].holding[1];
        players[thisPlayer].holding[1] = '-';
    } else {
        discard = players[thisPlayer].holding[1];
        players[thisPlayer].holding[1] = '-';
    }
    switch (discard) {
        case '8':
            discard_8(players, thisPlayer);
            break;
        case '7':
            discard_7(players, thisPlayer);
            break;          
        case '6':
            discard_6(players, thisPlayer);
            break; 
        case '5':
            discard_5(players, thisPlayer);
            break; 
        case '4':
            discard_4(players, thisPlayer);
            break; 
        case '3':
            discard_3(players, thisPlayer);
            break; 
        case '2':
            discard_2(players, thisPlayer);
            break; 
        case '1':
            discard_1(players, thisPlayer, theCards);
            break; 
    }    
}


/*remove_card searches the array of the remaining cards and removes
 * the first occurance of the desired card*/
void remove_card(int card, int* theCards) {
    for(int i = 0; i < 16; i++) {
        if(theCards[i] == card) {
            theCards[i] = 0;
            return;
        } 
    }
    //fprintf(stderr, "Bad message from hub\n");
    //exit(5);  
}


/*dicard_8 sets a player to be out of the round*/
void discard_8(struct Aplayer* players, int thisPlayer) {
    strcat(players[thisPlayer].played, "8"); 
    players[thisPlayer].status = '-';
    fprintf(stdout, "8--\n");
    fprintf(stderr, "To hub:8--\n");
}


/*dicard_7 has no effect*/
void discard_7(struct Aplayer* players, int thisPlayer) {
    strcat(players[thisPlayer].played, "7"); 
    fprintf(stdout, "7--\n");
    fprintf(stderr, "To hub:7--\n");
}


/*discar_6 picks a target*/
void discard_6(struct Aplayer* players, int thisPlayer) {
    char target;
    char* msg = malloc(5);
    target = targeting_player(players, thisPlayer);
    strcat(players[thisPlayer].played, "6"); 
    msg[0] = '6';
    msg[1] = target;
    msg[2] = '-';
    fprintf(stdout, "%s\n", msg);
    fprintf(stderr, "To hub:%s\n", msg);
}


/*discad_5 pickes a target, if it cant find one it chooses itself*/
void discard_5(struct Aplayer* players, int thisPlayer) {
    char target;
    char* msg = malloc(5);
    target = targeting_player(players, thisPlayer);   
    if (target == '-') {
        target = players[thisPlayer].playerName;
    }   
    strcat(players[thisPlayer].played, "5"); 
    msg[0] = '5';
    msg[1] = target;
    msg[2] = '-';
    fprintf(stdout, "%s\n", msg);         
    fprintf(stderr, "To hub:%s\n", msg);         
}


/*discar_4 sets the players status to be **/
void discard_4(struct Aplayer* players, int thisPlayer) {
    players[thisPlayer].status = '*';
    strcat(players[thisPlayer].played, "4"); 
    fprintf(stdout, "4--\n");
    fprintf(stderr, "To hub:4--\n");
}


/*discard_3 picks a target*/
void discard_3(struct Aplayer* players, int thisPlayer) {
    char target;
    char* msg = malloc(5);
    target = targeting_player(players, thisPlayer);   
    strcat(players[thisPlayer].played, "3"); 
    msg[0] = '3';
    msg[1] = target;
    msg[2] = '-';
    fprintf(stdout, "%s\n", msg); 
    fprintf(stderr, "To hub:%s\n", msg); 
}


/*discard_2 has no effect*/
void discard_2(struct Aplayer* players, int thisPlayer) {
    strcat(players[thisPlayer].played, "2"); 
    fprintf(stdout, "2--\n");
    fprintf(stderr, "To hub:2--\n");
}


/*discard_1 picks a target then loops through the remaining cards and 
 * picks the largest*/
void discard_1(struct Aplayer* players, int thisPlayer, int* theCards) {
    char target;
    int guess;
    char* msg = malloc(5);
    char con;
    guess = theCards[0];
    target = targeting_player(players, thisPlayer);
    for(int i = 1; i < 16; i++) {
        if (theCards[i] > guess) {
            guess = theCards[i];
        }
    }
    strcat(players[thisPlayer].played, "1"); 
    guess = guess + (int)'0';
    con = (char)guess;
    msg[0] = '1';
    msg[1] = target;
    msg[2] = con;
    fprintf(stdout, "%s\n", msg); 
    fprintf(stderr, "To hub:%s\n", msg); 
}


/*targeting_player loops through the array of players and returns
 * the name of the first player whoes statsu is ' '*/
char targeting_player(struct Aplayer* players, int thisPlayer) {
    for (int i = 1; i < players[thisPlayer].numPlayers; i++) {
        if(thisPlayer + i > players[thisPlayer].numPlayers - 1) {
            if (players[thisPlayer + i - players[thisPlayer].numPlayers].
                    status == ' ') {
                return players[thisPlayer + i - players[thisPlayer].
                        numPlayers].playerName;
            }
        } else {
            if (players[thisPlayer + i].status == ' ') {
                return players[thisPlayer + i].playerName;
            }            
        }   
    }
    return '-';
}


/*this_happened removes any cards involved in the turn, the adds what each 
 * player played that turn to their played element*/
void this_happened(char* input, struct Aplayer* players, int thisPlayer,
        int* theCards) {
    int con;
    char* temp = malloc(2);
    if(input[0] > 'D' - (4 - players[thisPlayer].numPlayers) ||
            input[4] != '/') {
        fprintf(stderr, "Bad message from hub\n");
        exit(5);        
    }
    con = input[1] - '0';
    remove_card(con, theCards);
    con = input[6] - '0';
    remove_card(con, theCards);
    for(int i = 0; i < players[thisPlayer].numPlayers; i++) {
        if(players[i].playerName == input[0]) {
            players[i].status = ' ';
            if (input[1] == '4') {
                players[i].status = '*';
            }
            if (players[i].playerName != players[thisPlayer].playerName) {
                sprintf(temp, "%c", input[1]);            
                strcat(players[i].played, temp);
            }
            break;
        }
    }
    if(input[5] != '-') {
        for(int i = 0; i < players[thisPlayer].numPlayers; i++) {
            if(players[i].playerName == input[5]) {
                if(i == thisPlayer) {
                    if(players[i].holding[0] == input[6]) {
                        players[i].holding[0] = '-';
                    }
                }
                sprintf(temp, "%c", input[6]);            
                strcat(players[i].played, temp);
                break;
            }
        }
        if(input[7] != '-') {
            for(int i = 0; i < players[thisPlayer].numPlayers; i++) {
                if(players[i].playerName == input[7]) {
                    players[i].status = '-';
                    break;
                }                  
            }       
        }
    }
}


/*replace_card changes this players current card to th new card*/
void replace_card(char* input, struct Aplayer* players, int thisPlayer) {
    players[thisPlayer].holding[0] = input[0];
}

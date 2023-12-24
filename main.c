#include "game.h"
#include "initialize.h" // For initialization functions
#include "display.h"    // For display functions
#include "turn.h"       // For turn handling functions
#include "update.h"     // For game update functions

/**
 * Main function of the Battleship game.
 * Initializes the game, executes the game loop, and frees resources after the game ends.
 * @return Exit status of the program.
 */
int main() {
    // Seed the random number generator
    srand(time(NULL));

    // Initialize the game
    Game game;
    initializeGame(&game);

    // Define the starting player (1 for human, 2 for computer)
    int currentPlayer = 1; 

    // Main game loop
    while (!checkGameOver(&game.player1) && !checkGameOver(&game.player2)) {
        // Display game boards
        displayGameBoards(&game);

        // Handle turn
        if (currentPlayer == 1) {
            // Player's turn
            playerTurn(&game.player2, game.boats2);
	    sleep(3);
        }
	else {
            // Computer's turn
            computerTurn(&game.player1, game.boats1);
        }

        // Update the game after each turn
        updateGame(&game, &currentPlayer);
    }

    // Display the result of the game
    displayGameResult(&game);

    // Free allocated resources
    freeGameResources(&game);

    return 0;
}

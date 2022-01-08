// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.8;

contract PierreFeuilleCiseau {
    uint public state;

    address public player1;
    uint public scorePlayer1;
    bytes32 public hashPlayer1;
    uint public revealPlayer1; // 1 pierre / 2 feuille / 3 ciseau

    address public player2;
    uint public scorePlayer2;
    bytes32 public hashPlayer2; 
    uint public revealPlayer2; // 1 pierre / 2 feuille / 3 ciseau

    constructor () {
        player1 = msg.sender;
    }

    function joinGame() public {
        require(player1 != msg.sender, "Le joueur 1 ne peut pas etre le joueur 2.");
        require(state == 0, "La partie a deja commence.");

        player2 = msg.sender;
        state = 1;
    }

    function sendHash(bytes32 hash) public {
        if ((msg.sender == player1) && (state == 1 || state == 3)) {
            hashPlayer1 = hash;

            if (state == 1) state = 2;
            if (state == 3) state = 4;
        } else if ((msg.sender == player2) && (state == 1 || state == 2)) {
            hashPlayer2 = hash;

            if (state == 1) state = 3;
            if (state == 2) state = 4;
        } else revert("Une erreur est survenue, le hash n'a pas ete pris en compte.");
    }

    function reveal(uint played, uint code) public {
        if ((msg.sender == player1) && (state == 4 || state == 6)) {
            require(hashPlayer1 == keccak256(abi.encodePacked(played, code)), "Hash incorrecte.");
            revealPlayer1 = played;
            
            if (state == 4) state = 5;
            if (state == 6) endTurn();
        } else if ((msg.sender == player2) && (state == 4 || state == 5)) {
            require(hashPlayer2 == keccak256(abi.encodePacked(played, code)), "Hash incorrecte.");
            revealPlayer2 = played;
            
            if (state == 4) state = 6;
            if (state == 5) endTurn();
        } else revert("Une erreur est survenue, le hash n'a pas ete revele.");
    }

    function endTurn() public {
        if (revealPlayer1 == revealPlayer2) {
            state == 1;
        } else if ((revealPlayer1 == 2 && revealPlayer2 == 1) && (revealPlayer1 == 3 && revealPlayer2 == 2) && (revealPlayer1 == 1 && revealPlayer2 == 3)) {
            scorePlayer1 +=1;
            
            if (scorePlayer1 == 3) state == 7;
            else state == 1;
        } else {
            scorePlayer2 +=1;

            if (scorePlayer2 == 3) state == 7;
            else state == 1;
        }
    }
}
Feature: Building longest road

  Scenario: Build 5 connected roads
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | A,nw     |      1 |
      | road       | A,w      |      1 |
      | road       | A,sw     |      1 |
      | road       | E,w      |      1 |
      | road       | D,w      |      1 |
    When player 1 has cards and places a road at E,sw
    Then player 1 should receive the longest road card

  Scenario: Building 5 connected roads that forked and not a single line
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | A,w      |      1 |
      | road       | A,sw     |      1 |
      | road       | D,nw     |      1 |
      | road       | E,w      |      1 |
      | road       | D,w      |      1 |
    When player 1 places a road at A,nw
    Then player 1 should not receive the longest road card

  Scenario: Road separated by other player's settlement
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | D,t      |      2 |
      | settlement | A,t      |      1 |
      | road       | A,nw     |      1 |
      | road       | A,w      |      1 |
      | road       | A,sw     |      1 |
      | road       | E,w      |      1 |
      | road       | D,w      |      1 |
    When player 1 places a road at N,nw
    Then player 1 should not receive the longest road card

  Scenario: Taking longest road from another player
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | road       | J,nw     |      2 |
      | road       | J,w      |      2 |
      | road       | K,nw     |      2 |
      | road       | K,w      |      2 |
      | road       | K,sw     |      2 |
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | A,nw     |      1 |
      | road       | A,w      |      1 |
      | road       | A,sw     |      1 |
      | road       | E,nw     |      1 |
      | road       | F,w      |      1 |
    Then player 2 should have the longest road card
    When player 1 has cards and places a road at G,sw
    Then player 1 should receive the longest road card
    
  Scenario: Breaking longest road when a single player has new longest road
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | J,t      |      2 |
      | road       | J,nw     |      2 |
      | road       | J,w      |      2 |
      | road       | K,nw     |      2 |
      | road       | K,w      |      2 |
      | road       | K,sw     |      2 |
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | G,sw     |      1 |
      | road       | A,nw     |      1 |
      | road       | B,sw     |      1 |
      | road       | C,nw     |      1 |
      | road       | J,sw     |      1 |
    Then player 2 should have the longest road card
    When player 1 has cards and places a settlement at K,t
    Then player 1 should receive the longest road card

  Scenario: Breaking longest road when a two players are tied for new longest road
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | J,t      |      2 |
      | road       | J,nw     |      2 |
      | road       | J,w      |      2 |
      | road       | K,nw     |      2 |
      | road       | K,w      |      2 |
      | road       | K,sw     |      2 |
      | road       | L,w      |      2 |
      | road       | L,sw     |      2 |
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | G,sw     |      1 |
      | road       | A,nw     |      1 |
      | road       | B,sw     |      1 |
      | road       | C,nw     |      1 |
      | road       | J,sw     |      1 |
    Then player 2 should have the longest road card
    When player 1 has cards and places a settlement at K,t
    Then nobody should have the longest road card

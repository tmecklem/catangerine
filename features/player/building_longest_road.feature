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
    When I place a road at E,sw
    Then I should receive the longest road card

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
    When I place a road at A,nw
    Then I should not receive the longest road card

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
    When I place a road at N,nw
    Then I should not receive the longest road card

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
    When I place a road at G,sw
    Then I should receive the longest road card

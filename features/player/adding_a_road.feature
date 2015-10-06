Feature: Adding a Road

  Scenario: Successfully add a road connected to a settlement
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | A,nw     |      1 |
    When player 1 has cards and places a road at G,w
    Then the board should contain a road for player 1 at G,w
    And player 1 should have the following cards:
      | type   | count |
      | brick  |     0 |
      | lumber |     0 |
    And it should be player 2's turn

  Scenario: Successfully add a road connected to another road
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | A,nw     |      1 |
    When player 1 has cards and places a road at A,w
    Then the board should contain a road for player 1 at A,w
    
  Scenario: Fail to add a road without sufficient resources
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | A,nw     |      1 |
    When player 1 tries to place a road at A,w
    Then it should not succeed
    Then the board should not contain a road for player 1 at A,w

  Scenario: Fail to add a road that's not connected to a settlement
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | A,nw     |      1 |
    When player 1 has cards and tries to place a road at G,nw
    Then it should not succeed

  Scenario: Fail to add a road where one exists
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | A,nw     |      1 |
    When player 1 has cards and tries to place a road at A,nw
    Then it should not succeed

  Scenario: Fail to add a road when not player's turn
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement |     A,t  |      2 |
      | road       |     A,nw |      2 |
    When player 2 has cards and tries to place a road at A,w
    Then it should not succeed
    
  Scenario: Fail to add a road when player has placed all road pieces
    Given the number of road pieces is 2 per player
    And a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement |     A,t  |      1 |
      | road       |     A,nw |      1 |
      | road       |     A,w  |      1 |
    When player 1 has cards and tries to place a road at A,sw
    Then it should not succeed


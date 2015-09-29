Feature: Adding a Settlement

  Scenario: Successfully add a settlement
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement |     A,t  |      1 |
      | road       |     A,nw |      1 |
      | road       |     A,w  |      1 |
      | road       |     A,sw |      1 |
    When player 1 has cards and places a settlement at A,b
    Then the board should contain a settlement for player 1 at A,b
    And it should be player 2's turn
    
  Scenario: Fail to add a settlement without an adjacent road
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement |     A,t  |      1 |
      | road       |     A,nw |      1 |
      | road       |     A,w  |      1 |
    When player 1 has cards and tries to place a settlement at A,b
    Then it should not succeed

  Scenario: Fail to add a settlement where one already exists
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement |      A,t |      2 |
    When player 1 tries to place a settlement at A,t
    Then it should not succeed

  Scenario: Fail to add a settlement adjacent to an existing one
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement |      G,b |      2 |
    When player 1 tries to place a settlement at A,t
    Then it should not succeed

  Scenario: Fail to add a settlement when not player's turn
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement |     A,t  |      2 |
      | road       |     A,nw |      2 |
      | road       |     A,w  |      2 |
      | road       |     A,sw |      2 |
    When player 2 tries to place a settlement at A,b
    Then it should not succeed

  Scenario: Fail to add a settlement due to insufficient resource cards
    Given a 3 player game at the start of round 3
    When player 1 tries to place a settlement at A,t
    Then it should not succeed

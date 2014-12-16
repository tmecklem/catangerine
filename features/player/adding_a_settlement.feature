Feature: Adding a Settlement

  Scenario: Successfully add a settlement

    Given a 3 player game at the start of round 3
    When I place a settlement at A,t
    Then the board should contain a settlement at A,t
    And it should be player 2's turn

  Scenario: Fail to add a settlement where one already exists

    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement |      A,t |      2 |
    When I try to place a settlement at A,t
    Then it should not succeed

  Scenario: Fail to add a settlement adjacent to an existing one

    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement |      G,b |      2 |
    When I try to place a settlement at A,t
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



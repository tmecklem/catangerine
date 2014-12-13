Feature: Adding a Settlement

  Scenario: Successfully add a settlement

    Given a 3 player game at the start of round 3
    When I place a settlement at A,t
    Then the board should contain a settlement at A,t
    And it should be player 2's turn

  Scenario: Fail to add a settlement where one already exists

    Given a 3 player game at the start of round 3
    And the board has the following settlements:
      | location | player |
      |      A,t |      2 |
    When I try to place a settlement at A,t
    Then it should not succeed

  Scenario: Fail to add a settlement adjacent to an existing one

    Given a 3 player game at the start of round 3
    And the board has the following settlements:
      | location | player |
      |      G,b |      2 |
    When I try to place a settlement at A,t
    Then it should not succeed

Feature: Adding a Road

  Scenario: Successfully add a road connected to a settlement

    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | A,nw     |      1 |
    When I place a road at G,w
    Then the board should contain a road at G,w
    And it should be player 2's turn

  Scenario: Fail to add a road that's not connected

    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | A,nw     |      1 |
    When I try to place a road at G,nw
    Then it should not succeed

  Scenario: Fail to add a road where one exists

    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | A,t      |      1 |
      | road       | A,nw     |      1 |
    When I try to place a road at A,nw
    Then it should not succeed

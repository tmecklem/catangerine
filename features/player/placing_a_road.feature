Feature: Adding a Road

  Scenario: Successfully add a road

    Given a 3 player game at the start of round 3
    When I place a road at 0,0,nw
    Then the board should contain a road at 0,0,nw
    And it should be player 2's turn

  Scenario: Fail to add a road

    Given a 3 player game at the start of round 3
    And the board has the following roads:
      | location | player |
      | 0,0,nw   | 2      |
    When I try to place a road at 0,0,nw
    Then it should not succeed


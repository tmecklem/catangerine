Feature: Rolling the dice

  Scenario: Rolling the dice grants resources
    Given a 3 player game at the start of round 3
    And the board has the following items:
      | type       | location | player |
      | settlement | I,b      |      2 |
      | settlement | G,t      |      2 |
      | settlement | R,b      |      2 |
      | settlement | L,t      |      2 |
      | settlement | A,b      |      2 |
      | settlement | AC,t     |      2 |
      | settlement | P,b      |      2 |
    When player 1 rolls the dice
    Then player 2 should get 1 resource card for each terrain with a matching number

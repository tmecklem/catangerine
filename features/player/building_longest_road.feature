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
    When I place a road at N,nw
    Then I should receive the longest road card

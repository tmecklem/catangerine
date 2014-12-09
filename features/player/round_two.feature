Feature: Round Two

  A player should be able to place their second settlement and road and get one of each resource around the settlement

  Scenario: Successful Settlement and Road Placement

    Given a 3 player game at the start of round 2
    When I place a settlement at 0,0,t and a road at 1,-1,w
    Then the board should contain a settlement at 0,0,t
    And the board should contain a road at 1,-1,w
    And I should receive resource cards from the following tiles:
      | tile   | count |
      | 0,0    |     1 |
      | 1,-1   |     1 |
      | 0,-1   |     1 |

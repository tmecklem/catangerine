Feature: Round Two

  A player should be able to place their second settlement and road and get one of each resource around the settlement

  Scenario: Successful Settlement and Road Placement

    Given a 3 player game at the start of round 2
    When I place a settlement at A,t and a road at G,w
    Then the board should contain a settlement at A,t
    And the board should contain a road at G,w
    And I should receive resource cards from the following tiles:
      | tile | count |
      |    A |     1 |
      |    G |     1 |
      |    B |     1 |

Feature: Round One

  A player should be able to place their first settlement and road

  Scenario: Successful Settlement and Road Placement

    Given a 3 player game at the start of round 1
    When player 1 places a settlement at A,t and a road at G,w
    Then the board should contain a settlement for player 1 at A,t
    And the board should contain a road for player 1 at G,w
    And it should be player 2's turn

  Scenario: Failure to add, road not protruding from settlement

    Given a 3 player game at the start of round 1
    When player 1 tries to place a settlement at A,t and a road at R,w
    Then it should not succeed

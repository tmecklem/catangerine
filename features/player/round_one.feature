Feature: Round One

  A player should be able to place their first settlement and road

  Scenario: Successful Settlement and Road Placement

    Given a 3 player game at the start of round 1
    When I place a settlement at A,t and a road at G,w
    Then the board should contain a settlement at A,t
    And the board should contain a road at G,w
    And it should be player 2's turn

Feature: Round One

  A player should be able to place their first settlement and road

  Scenario: Successful Settlement and Road Placement

    Given a 3 player game at the start of round 1
    When I place a settlement at 0,0,t and a road at 1,-1,w
    Then the board should contain a settlement at 0,0,t
    And the board should contain a road at 1,-1,w
    And it should be player 2's turn

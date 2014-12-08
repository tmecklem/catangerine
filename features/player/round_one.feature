Feature: Round One

  A player should be able to place their first settlement and road

  Scenario: Successful Settlement and Road Placement

    Given 3 players
    And the game starts
    Then it should be player 1's turn
    When player 1 places a settlement at 0,0,n and a road at 1,-1,w
    Then the board should contain a settlement at 0,0,n
    And the board should contain a road at 1,-1,w
    And it should be player 2's turn

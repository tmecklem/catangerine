Feature: Round One

  A player should be able to place their first settlement and road

  Scenario: Successful Settlement and Road Placement

    Given 3 players
    And the game starts
    Then it should be player 1's turn
    When player 1 places a settlement at 0,0,n
    Then the command should succeed
    And the board should contain a settlement at 0,0,n
    And it should be player 2's turn

Feature: Board Generation

  Board generation should be accurate and random

  Scenario: Correct Tiles

    Given 3 players
    When the board generates
    Then the board should have standard tiles

  Scenario: Random Generation

    Given 2 boards
    When the boards generate
    Then the boards should have different tile layouts

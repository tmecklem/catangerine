Feature: Board Generation

  Board generation should be accurate and random

  Scenario: Correct Distribution of Tiles

    Given 3 players
    When the board generates
    Then the board should have standard tiles

  Scenario: Correct Distribution of Chits

    Given 3 players
    When the board generates
    Then the board should have standard chits

  Scenario: Correct Distribution of Harbors

    Given 3 players
    When the board generates
    Then the board should have standard harbors

  Scenario: Random Generation

    Given 2 boards
    When the boards generate
    Then the boards should have different tile and chit layouts

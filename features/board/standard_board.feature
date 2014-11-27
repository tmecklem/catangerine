Feature: Board Generation

  Board generation should be accurate and random

  Scenario Outline: Correct Distribution of Resources

    Given <number> players
    When the board generates
    Then the board should have <game_type> tiles
    And the board should have <game_type> chits
    And the board should have <game_type> harbors

    Examples:
      | number | game_type |
      | 3      | standard  |
      | 4      | standard  |
      | 5      | expanded  |
      | 6      | expanded  |

  Scenario: Random Generation

    Given 2 boards
    When the boards generate
    Then the boards should have different tile and chit layouts

Feature: Board Generation

  Board generation should be accurate and random

  Scenario Outline: Correct Distribution of Resources

    Given <number> players
    When the game starts
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

    Given 2 games
    When the games start
    Then the boards should have different tile and chit layouts

  Scenario: Game State

    Given 1 game
    When the game starts
    Then the board should be in set_up state

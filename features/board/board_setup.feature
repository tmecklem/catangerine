Feature: Board Generation

  Board generation should be accurate and random

  Scenario Outline: Correct Distribution of Resources

    Given a <number> player game at the start of round 1
    Then the board should have <game_type> tiles
    And the board should have <game_type> chits
    And the board should have <game_type> harbors
    And the board should be in set_up state

    Examples:
      | number | game_type |
      | 3      | standard  |
      | 4      | standard  |
      | 5      | expanded  |
      | 6      | expanded  |

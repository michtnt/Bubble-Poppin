#  Individual Programming Project: Bubble-Popping game

## Objectives

The purpose of this project is to demonstrate competence in the following skills:

- [ ] The full software development cycle
- [ ] iOS App UI and program design
- [ ] iOS UI programming
- [ ] Effective use of platform APIs
- [ ] Program testing

## Specification

In this game, a number of bubbles are randomly displayed on an iOS device screen. A player pops a bubble by touching the bubble, and every time they pop a bubble they earn a certain number of points. Bubbles come in five colours: red, pink, green, blue and black. Each colour corresponds to a specific number of points and has a specific probability of appearance (see table 1). 

Table 1.
- Red ( Points: 1, Probability: 40%)
- Pink  ( Points: 2, Probability: 30%)
- Green ( Points: 5, Probability: 15%)
- Blue  ( Points: 8, Probability: 10%)
- Black  ( Points: 10, Probability: 5%)

All bubbles appear on the screen briefly (see core functionality 9). A player needs to pop as many bubbles as possible within a certain timeframe (default to 60 seconds) to get high scores. Note that, if a player pops two or more bubbles of the same colour consecutively, they earn 1.5 times the points for the additional bubbles they pop. Finally, game scores are saved and a high score board is displayed after a game run is finished.  You will get 1 functionality mark for each functionality item specified below.

### Core Functionalities

1. A player must be able to enter their name before the start of a game run. (You may load the player's name from the GameKit API if you wish. This extra work is not required.)
2. A game timer shall be displayed and it must count down continuously in one-second intervals. When the timer reaches zero, the game stops.
3. A score shall be displayed. It shall be zero initially and shall be updated every time the player successfully “pops” a bubble.
4. The default timeframe for a game is 60 seconds, i.e. the game timer starts from 60 seconds and counts down to 0. This number shall be adjustable in the app settings.
5. The maximum number of bubbles displayed on the screen is defaulted to 15, i.e. there shall be between 0 and 15 bubbles shown on the screen at the same time. This number shall be adjustable in the app settings.
6. The app randomly decides how many bubbles (up to the maximum allowed bubble number) shall be displayed on the screen at a time. The bubble colour is decided according to the Probability of Appearance in Table 1.
7. Bubbles shall be displayed at random positions on the screen with the following restrictions:
 -  The entire bubble shall be displayed within the screen. There shall not be any bubble with some parts off the screen once it has fully appeared.
 -  No two (or more) bubbles shall overlap each other.
8. When a player touches a bubble, the bubble shall be removed from the screen and the corresponding game points shall be added to the overall score. For example, if the green bubble  was touched, it shall disappear and the score shall increase by 5 game points. If two or more bubbles of the same colour are popped in a consecutive sequence, the bubbles after the first one will get 1.5 times their original game points. For example, if two black bubbles were popped one after the other, 25 (10 + 1.5 * 10) shall be added to the total score. Round to the nearest integer if necessary
9. The app shall refresh bubbles displayed every game second. That is, after every game second, the app shall randomly remove a number of bubbles (do not include the bubbles that have been popped by the player) and replace them with another set of randomly positioned bubbles. There may be more or less bubbles on the screen compared with the previous game second subjected to the restrictions in 5 and 6. In this case, "random" means chosen by the program, not the user. So you have a lot of discretion in placement of new bubbles and selection of old bubbles.
10. When the game stops, the player’s score shall be saved in a persistent file (or database) that contains all players’ names and their highest scores.
11. At the end of the game, a high score board shall be displayed with the names and scores of the highest ranking players.

### Extended Functionalities

1. In addition to core function 7 and 9, displayed bubbles shall move and go off the screen if they are not removed earlier. Their moving speed shall increase as the game timer counts down. You decide the rate of change with respect to the game timer.
2. Animations of game state transitions. For example, one of:
- Flashing count down 3, 2, 1 start at the beginning of play.
- Bubbles shrinking, growing, or flying away when removed or tapped.
- Score changes or combo lengths displayed with animations in response to taps.
- The highest score in the scoreboard shall be displayed during gameplay.
- Any cool and useful features that you can think of.

## Assessment

You will demonstrate your app in your assigned lab on the week of 22 May. Your peers
will mark your app's functionality and give you feedback on usability.

**Max score**: 30 marks

### Functionality: 20 marks (marked by peers)

The Xcode project must unzip successfully and compile without errors.
- 15 marks for specified functionalities. (Full marks in functionality requires the completion of all CFs and EFs)
- 2 marks for compiling without warnings.
- 1 mark for operating without unhandled runtime errors.
- 2 marks for correct display on different screen sizes and orientations.

### Code Style: 3 marks (marked by staff)

- Deduct up to 1 mark for bad or inconsistent indentation, whitespace, or braces.
- Deduct up to 1 mark for bad or misleading comments.
- Deduct up to 1 mark for unclear symbol naming

### Program Design: 7 marks (marked by staff)
- **Data modeling**: Do the data structures reflect the problem domain?
- **Immutable data and idempotent methods**: Is the type system used to prevent incorrect code from being written?
- **Functional separation**: Is the problem broken down into meaningful parts?
- **Loose coupling**: Can parts be changed in isolation of each other?
- **Extensibility**: How easy would it be to add, remove, or change functionality? Could a new mechanic or new content be added by changing data instead of changing code?
- **Error handling**: Are errors detected at appropriate places? Is the user prevented from
entering invalid input and guided toward valid input?

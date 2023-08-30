# The Immaculate Grid 
My database enhancement is a trivia webgame inspired by the increasingly popular game also known as the [Immaculate Grid](https://www.immaculategrid.com) except that the prompts are more based off of what suited my database. The backend of this game generates templates of the queries that the user is challenged to complete (via entering a player name through the front-end) in which the query returns at least one valid solution, testing the user's knowledge of baseball trivia. 

## Game Rules and Mechanics
The game works as follows:
* There is a 3 x 3 grid with 6 different prompts
* It is the user's goal to satisfy as many cells as possible within the 9 answering attempts. Each answer entry counts as an attempt, so the user cannot answer any of the cells incorrectly in order to achieve an Immaculate Grid.
* In order to satisfy a cell within the grid, the user must input a player that satisfies both the condition attached to the row that the cell is in and the column that the cell is in.
    * These conditions can either be some sort of statistic, or it can be whether a certain player played for a certain team at any point in their career
    * For example, if for a cell one of the conditions is a statistic while the other is for a team, a correct answer for the cell must be the name of a player who achieved the given statistic for a season playing on that specific team
* The game ends when all 9 answering attempts are over
* Everytime a new game is initiated, the 6 different prompts are completely randomized and drawn from a database of prompts. 
* A user is not allowed to reuse a player that already served as a correct answer for another cell. 

## How to Run the Game
1. Clone the repository to local machine
2. Ensure local machine has requirements to run files. In particular, make sure that php is installed and can be ran locally.
3. Make sure to `cd` into `Milestone-4/immaculate-grid`
4. In terminal, enter the command `php -S localhost:8000`
5. In a web browser, go to `localhost:8000`

## Sample Gameplay
The link to a video with around 20 minutes of my gameplay is way too large to be stored here, but it can be found [here](https://drive.google.com/file/d/1SUqj6fXK3nTCg7GRLq4a85wilPRJ7OyH/view?usp=sharing).
<p align="center">
  <img src=https://github.com/kevincow/COSC61-Final-Project/assets/23646234/e97d4a32-11a1-4a8d-8747-bfc6d11b55dc alt="IMG3">
</p>

## Important Files
* `index.html` - Structures and formats the text and images used for the visualization of the game.
* `script.js` - Deals with interactive portions and event handling, such as the generation and randomization of prompts, and handling the user input and its resulting response.
* `styles.css` - Adds to the style of the page's layout
* `check_answer.php` - Takes the user input from `script.js` and checks whether the answer is correct or not, sending back the result to `script.js`. 
* `db.php` - Script that establishes the connection to the Amazon RDS database which is storing all of the data.
* `prompts.php` - Retrieves all the prompts and stores them in an array format for `check_answer.php` to access.
* `JSON_alternative.php` - Provides a text-based backup for communication between `script.js` and `check_answer.php`. 
* `prompts.sql` - Not necessary to run the game at this point, but was used to craft all of the prompts and their respective attributes.
* `images` - A subdirectory that stores all of the images, which mainly constitute logos, needed for the game.
* `baseball-db.sql` - This file was just 1 MB too large to be stored into git, but the link to the file is [here](https://drive.google.com/file/d/1nM4F9aOCGZuL3rKZIJ_iQzYb5bDk8XQz/view?usp=sharing). This sql file can be used to reconstruct the baseball database in one go and was very helpful when importing the database to RDS.




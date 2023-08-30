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
* `JSON_alternative.txt` - This is a file that `check_answer.php` writes the result of its answer checking to. Sometimes JSON_decode failed to decode properly JSON_encoded messages, so by writing to this file, we can parse the text via `JSON_alternative.php` in order to extract the data and send it directly to `script.js`. 
* `JSON_alternative2.txt` - This is a file that `check_answer.php` writes the JSON message it receives to. Sometimes JSON_decode failed to decode properly JSON_encoded messages, so by writing the JSON encoded test to the file and parsing it via string-based methods, we can protect our code from this error.

### Implementation and Logic
Here, I lay out the logic/logical flow laying out the foundation of the implementation of this code:
* Construct a prompts table via `prompts.sql` in the baseball database
    * The table must be have the columns prompt_id, prompt_name, sql_condition, and image_name
    * The prompt_id assigns a key integer to the prompt, which will be helpful when we try using a random integer to select random prompts
    * The prompt_name is a simple string name representing the prompt. For statistical prompts, it will be what we want the user to see on the grid as a prompt. Since that team prompts have logo images, we just merely write the team name for this, which will serve as the alt field for the image once embedded via HTML.
    * The sql_condition is the string for part of the WHERE clause in SQL query in `check_answer.php`. Having this here will be easy as we can have a template SQL query and then simply plug in the string representing the condition once we retrieve to get the correct query.
    * The image_name stores the name of the image file which corresponds its respective prompt, which will be helpful because we need a way to call the correct image file to be placed in the grid once the prompt is chosen. I made sure that I had the same naming conventions between the images stored in the images subdirectory and the values stored in the image field. If we have a statistical prompt (thus one that does not have an associated image), we just fill this field with the string "no_image", so it is easy to check whether we need to add an image or not once the prompt is called to be placed in the grid.
* Retrieve the prompts table and store it as an array/dictionary in `prompts.php`
    * A simple query of all the values in the prompts table will do the trick, and then we can encode this array to JSON format and echo it to `script.js`, which initiates a fetch request immediately once the code is run (see the `fetchPrompts()` function).
* Update the table once the game start with randomized prompts (see the `updateTable()` function in `script.js`)
    * We generate a prompt by generating a random number, and then using this random number as a key to access the value stored in the prompts dictionary.
    * We create an array to store the 6 prompts that are randomly chosen
         * We need to limit what kinds of prompt combinations we have since it is virtually impossible to answer a cell that has a hitting stat and pitching stat prompt combination. Thus, we first generate 3 prompts, and then check whether any of these prompts are hitting or pitching stats (since I wrote the prompts table, I know which indices belong to hitting or pitching stats). Based on the results of the first 3 prompts, we can generate the last 3 prompts accordingly based on any restrictions that are necessary.
    * We insert the prompts (either text or image) into the table, which can be super convenient because we already chosen our prompts and we also have a prompt dictionary that has the image filename and the prompt in text format.
* Once a player clicks on a grid cell (button)
    * We call the `askPlayer()` function in `script.js`
    * Using the cell's row number and column number, we can extract what the original prompt was since if there is an image, we can identify the prompt from either the alt text or the name of the image file itself and if there is just text, we can identify the prompt from the contents of the text.
    * We now create a prompt to take in user input. We first check to whether user actually inputs something, then we check whether user enters a player name that has not already been used for a correct answer (as per the rules of the Immaculate Grid game), and then once we bypass these two conditions, we encode the user's input in addition to the cell's row prompt and column prompt via JSON and send it over to `check_answer.php` via a fetch request.
* In `check_answer.php`, we now extract the data sent over from `script.js`.
    * There appears to sometimes be an issue where properly encoded JSON contents sometimes cannot be read and stored in an array via JSON_decode.
    * An alternate way of extracting the data is to obtain the JSON-encoded data and storing it in a textfile `JSON_alternative2.txt`. I can then trim this input and remove any potential whitespaces or hidden newline characters (though this is unnecessary because the string that is sent over is fine in spite of JSON_decode's inability to sometimes parse it). Then I can store the value of the raw JSON data in a string via an `fgets()` command on `JSON_alternative2.txt`.
    * To replace JSON_decode, I can use string-based methods (e.g. combinations of `substr()` and `strpos()`) to manually extract the data now stored in the string.
    * The string (since it comes JSON encoded) is always in the form {"playerName":"??????","rowPrompt":"???????","colPrompt":"???????"}, where the ??????? marks represent the variable data depending on the the input of the user and the row and column prompts of the selected cell. Therefore, there is a fixed strategy of extract each of these ??????? strings.
* We use the prompts dictionary (note that we `include 'prompts.php` at the top of this file) along with the extracted rowPrompt and colPrompt values to get the SQL query string associated with the two prompts. 
* The SQL query to check the answer will have two overarching forms:
   * If both row/col prompts makes a team-team combination, the query will be in this form:
           ```
           SELECT DISTINCT s1.playermanager_id, f1.franchise_name, f2.franchise_name
            FROM stint s1
                JOIN stint s2 ON s1.playermanager_id = s2.playermanager_id AND s1.team_id <> s2.team_id
                JOIN team t1 ON s1.team_id = t1.team_id
                JOIN franchise f1 ON t1.franchise_id = f1.franchise_id
                JOIN team t2 ON s2.team_id = t2.team_id
                JOIN franchise f2 ON t2.franchise_id = f2.franchise_id AND f1.franchise_id <> f2.franchise_id
            WHERE s1.playermanager_id IN 
                (SELECT pm.playermanager_id FROM playermanager pm
                WHERE CONCAT(pm.first_name, ' ', pm.last_name) = ?)
                AND {$rowCondition} AND {$colCondition}
           ```
   * If there is at least one prompt that is a stat prompt, the query will be in this form:
           ```
           SELECT *
           FROM stint
               LEFT JOIN hitting_stats ON stint.stint_id = hitting_stats.stint_id
               LEFT JOIN pitching_stats ON stint.stint_id = pitching_stats.stint_id
               LEFT JOIN team ON stint.team_id = team.team_id
               LEFT JOIN franchise ON team.franchise_id = franchise.franchise_id
           WHERE playermanager_id IN 
               (SELECT playermanager_id FROM playermanager
               WHERE CONCAT(first_name, ' ', last_name) = ?)
               AND {$rowCondition} AND {$colCondition}
           ```
    * There are differences between the two queries because for a team-team prompt combination, we are interesting in seeing if a player has ever played for the two specified teams in his entire career at any point, while the for a team-stat or a stat-stat prompt combination, we are interested in seeing if a player has ever either achieved a specific stat/played for a specific team while achieving some other stat in the same season.
    * We can easily check which prompt we need to use due to the convenient fact that none of the team prompts contain numerical values in them while all of the stat prompts do.
* Execute the query via a prepared statement to prevent SQL injection attacks
* If there are any results, we send a "correct" message back, if not, we send an "incorrect" message back.
    * Due to issues regarding the json_decode of json_encoded text, we also write the necessary data inside the file `JSON_alternative.txt`
        * This data will be in the form "[message], ["playerName"]" (ignore the brackets). Message can either be "Correct!" or "Incorrect."
* Since JS cannot conduct file I/O without using node.js (which I am not using), we first extract the data via `JSON_alternative.php`'s `getResult()` function and return them to `script.js`.
* Back in the catch part of the fetch request/promise in `script.js` (since it will always be directed there if JSON_decode runs into any problems, we can extract both the message and player using a string `split()` function. If we find that message stored incorrect, we return the button back to its original state, alert the player, and decrement guessesRemaining by one. If we find that the message stored correct, we change the button to the correct-answer state, disable it, add the playerName to the usedName list, alert the player, and then decrement the number of guessesRemaining by one.
* Finally, we check at the end of the fetch request/promise whether guessesRemaining equals 0. If so, we end the game via a call to the `gameOver()` function. If not, we continue playing, repeating this process, until guessesRemaining === 0 happens or the page is exited/reloaded.
* In the `gameOver()` function, we disable all answer buttons, alert the user, and call `restartGame()`
* In `restartGame()`, we simply reload the page, which will provide a new randomized prompts, clean grid cells to fill in, and guessesRemaining set back to its original value. 

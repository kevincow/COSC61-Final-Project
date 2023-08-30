let guessesRemaining = 9; // Stores the number of attempts the player has left
let usedNames = []; // Stores the players that have already been used for a successful answer
var prompts; // Stores the dictionary of prompts along with their associated data

// Fetches and stores the prompts data (which is stored in the baseball database) sent from prompts.php
function fetchPrompts() {

    return fetch('prompts.php')
        .then(response => response.json())
        .then(data => {
            prompts = data;
            updateTable();
        })
        .catch(error => {
            console.error("Error fetching prompts data:", error);
        });
    
}

fetchPrompts();

// Update the row and column prompts, which should be randomized with each iteration of the game
function updateTable() {

    var headers = new Array();
    var numRows = 3;
    var numCols = 3;
    
    // We need to ensure that we don't get a grid where a row is a hitting stat and a col is a pitching stat (or vice versa)
    // since that prompts with both hitter and pitcher requirements are often impossible
    var limitHittingStats = false;
    var limitPitchingStats = false;

    // Randomly pick enough unique prompts to fill up rows and cols
    // We first pick 3 to fill up the rows so that we can check whether we need to limit what kinds of prompts the columns can have
    for (var i = 0; i < numRows; i++) {

        // Generate a random number between a 1 and 50 inclusive, each number represents one of the prompts in the database
        var randomElement = Math.floor(Math.random() * 50 + 1);
        if (headers.includes(randomElement)) {

            // Ensures that the prompts are unique
            i--;

        } else {

            headers.push(randomElement);
            if (randomElement > 30 && randomElement < 40) {

                // If we have a hitting stat in any of the rows, we prevent columns from having a pitching stat
                limitPitchingStats = true;

            } else if (randomElement >= 40) {

                // If we have a pitching stat in any of the rows, we prevent columns from having any hitting stats
                limitHittingStats = true;

            }

        }

    }

    // The same thing but now we can fill up the columns
    for (var i = numRows; i < numRows + numCols; i++) {

        if (limitPitchingStats && limitHittingStats) {

            var randomElement = Math.floor(Math.random() * 30 + 1);

        } else if (limitPitchingStats) {

            var randomElement = Math.floor(Math.random() * 39 + 1);

        } else if (limitHittingStats) {

            var useFirstInterval = Math.random() < 0.75;
            if(useFirstInterval) {

                var randomElement = Math.floor(Math.random() * 30 + 1);

            } else {

                var randomElement = Math.floor(Math.random() * 11 + 40);

            }

        } else {

            var randomElement = Math.floor(Math.random() * 50);

        }

        if (headers.includes(randomElement)) {

            i--;

        } else {

            headers.push(randomElement);

        }

    }

    var columnInfo = new Array();
    var rowInfo = new Array();

    for (var i = 0; i < 3; i++) {

        console.log(prompts[headers[i]]);
        columnInfo.push(prompts[headers[i]]);
        rowInfo.push(prompts[headers[i + 3]]);

    }

    // We now update the visual presentations of the prompts in the the grid
    var myTable = document.getElementById('gameTable');

    for (var i = 0; i < numRows; i++) {

        // Insert the image of the logo if there is an image associated with the prompt in the database
        if (rowInfo[i]["image_name"] !== "no_image") {

            var imgID = "img" + (i + 1);
            var fileName = 'images/' + rowInfo[i]["image_name"] + '.png';
            var buildText = "<img id=\"" + imgID + "\" src=\"" + fileName + "\" alt =\"" + rowInfo[i]["prompt_name"] + "\"></img>";
            myTable.rows[i + 1].cells[0].innerHTML = buildText;

        } else {

            // Else just display simple text attached to the prompt
            myTable.rows[i + 1].cells[0].innerHTML = rowInfo[i]["prompt_name"];

        }

    }

    // Same thing but for columns
    for (var i = 0; i < numCols; i++) {

        if (columnInfo[i]["image_name"] !== "no_image") {

            var imgID = "img" + (i + 4);
            var fileName = 'images/' + columnInfo[i]["image_name"] + '.png';
            var buildText = "<img id=\"" + imgID + "\" src=\"" + fileName + "\" alt =\"" + columnInfo[i]["prompt_name"] + "\"></img>";
            myTable.rows[0].cells[i + 1].innerHTML = buildText;

        } else {

            myTable.rows[0].cells[i + 1].innerHTML = columnInfo[i]["prompt_name"];

        }

    }

}    

// Updates the visual text denoting the number of guesses a player has
function updateGuessesDisplay() {

    document.getElementById("guesses").innerText = "Attempts Remaining: " + guessesRemaining;

}

// Handles what happens when a player selects a grid cell
function askPlayer(btnid, row, col) {

    // First much match the cell with the associated prompts
    var rowID = "row" + row;
    var colID = "col" + col;

    var myRow = document.getElementById(rowID);
    var myCol = document.getElementById(colID);

    var rowPrompt;
    if (myRow.innerHTML.indexOf('alt') !== -1) {

        // The prompt is stored in the alt field in images
        rowPrompt = myRow.innerHTML.match(/alt="([^"]*)"/)[1];

    } else {

        rowPrompt = myRow.innerHTML;

    }

    var colPrompt;
    if (myCol.innerHTML.indexOf('alt') !== -1) {

        colPrompt = myCol.innerHTML.match(/alt="([^"]*)"/)[1]

    } else {

        colPrompt = myCol.innerHTML;

    }

    // Ask the user for their answer
    let playerName = prompt("Enter player's name: ");

    // Check the JSON (which should always be right)
    // bruh = JSON.stringify({ playerName, rowPrompt, colPrompt});
    // console.log(bruh);


    // If the user actually inputs something
    if (playerName) {

        // Check if the user already used the player for a different answer
        if (usedNames.includes(playerName.toLowerCase())) {
            alert("You've already used that player!");
            return;
        }

        // Add the inputted name to the cell
        var btn = document.getElementById(btnid);
        btn.innerHTML = playerName;

        // Send over the player's answer to check_answer.php, which will determine whether the answer is correct or not
        fetch("check_answer.php", {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({ playerName, rowPrompt, colPrompt}),
        })
        .then(response => response.json())
        .then(data => {

            // We get a valid JSON message back from check_answer.php
            console.log(data.message);
            if (data.message === "Incorrect.") {

                // Remove the name on the cell if it is incorrect
                btn.innerHTML = ""; 
            } else if (data.message === "Correct!") {

                // Update the cell's color and disable the button if correct
                btn.classList.add("correct-answer");
                btn.disabled = true;

                // Add the name to the usedNames list
                usedNames.push(playerName.toLowerCase());
            } 

            // Notify the player of the result
            alert(data.message);

            // Decrement the number of attempts left by one
            guessesRemaining--;
            updateGuessesDisplay();

            // If there are no more attempts, end the game
            if (guessesRemaining === 0) {
                setTimeout(gameOver, 1000);
            }

        })
        .catch(error => {

            // Similar to the code directly above but we use a txt file based
            // backup in case there is an issue with the JSON decoding

            // Call JSON_alternative.php to read the txt file that is returned from check_answer.php
            fetch('JSON_alternative.php')
                .then(response => response.text())
                .then(data => {

                    // Extract the message and the player
                    message = data.split(", ")[0];
                    player = data.split(", ")[1];
                    if (message === "Incorrect.") {
                        btn.innerHTML = "";
                    } else if (message === "Correct!") {
                        btn.classList.add("correct-answer");
                        btn.disabled = true;
                        usedNames.push(player.toLowerCase());
                        console.log("Player: " + player.toLowerCase());
                    }
                    alert(message);

                    guessesRemaining--;
                    updateGuessesDisplay();
                    if (guessesRemaining === 0) {
                        setTimeout(gameOver, 1000);
                    }
                })

        });

    }

}

// Handles the event in which the player has no more attempts left
function gameOver() {

    // Disable all answer buttons
    const buttons = document.querySelectorAll("button");
    buttons.forEach(btn => {
        btn.disabled = true;
    })

    alert("Game Over! Click OK to Play Again!");

    restartGame();

}

// Restarts the game by refreshing the page
function restartGame() {

    location.reload();

}

function exitGame() {

    window.close();

}

window.onload = function() {

    updateGuessesDisplay();

}


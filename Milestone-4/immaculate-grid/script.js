let guessesRemaining = 9;
let usedNames = [];
var prompts;

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

function updateTable() {

    var headers = new Array();
    var numRows = 3;
    var numCols = 3;
    
    // we need to ensure that we don't get a grid where a row is a hitting stat and a col is a pitching stat (or vice versa)
    let limitHittingStats = false;
    let limitPitchingStats = false;

    // randomly pick enough unique prompts to fill up rows and cols
    for (var i = 0; i < numRows; i++) {

        var randomElement = Math.floor(Math.random() * 50 + 1);
        if (headers.includes(randomElement)) {

            i--;

        } else {

            headers.push(randomElement);
            if (randomElement > 30 && randomElement < 40) {

                limitHittingStats = true;

            } else if (randomElement >= 40) {

                limitPitchingStats = true;

            }

        }

    }

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

    var myTable = document.getElementById('gameTable');

    // update the first row
    for (var i = 0; i < numRows; i++) {

        if (rowInfo[i]["image_name"] !== "no_image") {

            var imgID = "img" + (i + 1);
            var fileName = 'images/' + rowInfo[i]["image_name"] + '.png';
            var buildText = "<img id=\"" + imgID + "\" src=\"" + fileName + "\" alt =\"" + rowInfo[i]["prompt_name"] + "\"></img>";
            myTable.rows[i + 1].cells[0].innerHTML = buildText;

        } else {

            myTable.rows[i + 1].cells[0].innerHTML = rowInfo[i]["prompt_name"];

        }

    }

    // update the first column
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


function updateGuessesDisplay() {

    document.getElementById("guesses").innerText = "Attempts Remaining: " + guessesRemaining;
    // insert a check for if guesses = 0 then head to game over screen or something...

}

function askPlayer(btnid, row, col) {

    var rowID = "row" + row;
    var colID = "col" + col;

    var myRow = document.getElementById(rowID);
    var myCol = document.getElementById(colID);

    console.log(myRow);
    console.log(myCol);

    var rowPrompt;
    if (myRow.innerHTML.indexOf('alt') !== -1) {

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

    let playerName = prompt("Enter player's name: ");

    bruh = JSON.stringify({ playerName, rowPrompt, colPrompt});
    console.log(bruh);

    if (playerName) {

        // check if the user already used the player for a different answer
        if (usedNames.includes(playerName.toLowerCase())) {
            alert("You've already used that player!");
            return;
        }

        var btn = document.getElementById(btnid);
        btn.innerHTML = playerName;

        fetch("check_answer.php", {
            method: "POST",
            headers: {
                "Content-Type": "application/json; charset=UTF-8",
            },
            body: JSON.stringify({ playerName, rowPrompt, colPrompt}),
        })
        .then(response => response.json())
        .then(data => {
            console.log(data.message);
            if (data.message === "Incorrect.") {
                btn.innerHTML = ""; 
            } else if (data.message === "Correct!") {
                btn.classList.add("correct-answer");
                btn.disabled = true;
                usedNames.push(playerName.toLowerCase());
            } 
            alert(data.message);


            guessesRemaining--;
            updateGuessesDisplay();

            if (guessesRemaining === 0) {
                setTimeout(gameOver, 1000);
            }

        })
        .catch(error => {

            fetch('JSON_alternative.php')
                .then(response => response.text())
                .then(data => {
                    message = data.split(",")[0];
                    player = data.split(",")[1];
                    if (message === "Incorrect.") {
                        btn.innerHTML = "";
                    } else if (message === "Correct!") {
                        btn.classList.add("correct-answer");
                        btn.disabled = true;
                        usedNames.push(player.toLowerCase());
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

function gameOver() {

    // Disable all answer buttons
    const buttons = document.querySelectorAll("button");
    buttons.forEach(btn => {
        btn.disabled = true;
    })

    alert("Game Over! Click OK to Play Again!");

    restartGame();
    /*
    //Hide attempt counts
    const countDiv = document.getElementById("guesses");
    countDiv.style.visibility = 'hidden';
    countDiv.style.display = 'none';

    // Show the game over modal
    const modal = document.getElementById("gameOverModal");
    modal.style.display = 'block';
    modal.style.visibility = 'visible';

    const btnRestart = document.getElementById("btnRestart");
    btnRestart.disabled = false;

    const btnExit = document.getElementById("btnExit");
    btnExit.disabled = false;
    */


}

function restartGame() {

    location.reload();

}

function exitGame() {

    window.close();

}

window.onload = function() {

    updateGuessesDisplay();

}

/*

function CustomAlert() {

    this.alert = function(message, title) {

        document.body.innerHTML = document.body.innerHTML + '<div id="dialogoverlay"></div><div id="dialogbox" class="slit-in-vertical"><div><div id="dialogboxhead"></div><div id="dialogboxbody"></div><div id="dialogboxfoot"></div></div></div>';

        let dialogoverlay = document.getElementById('dialogoverlay');
        let dialogbox = document.getElementById('dialogbox');
      
        let winH = window.innerHeight;
        dialogoverlay.style.height = winH + "px";
      
        dialogbox.style.top = "100px";
  
        dialogoverlay.style.display = "block";
        dialogbox.style.display = "block";
      
        document.getElementById('dialogboxhead').style.display = 'block';
  
        if (typeof title === 'undefined') {
        
            document.getElementById('dialogboxhead').style.display = 'none';
      
        } else {
        
            document.getElementById('dialogboxhead').innerHTML = '<i class="fa fa-exclamation-circle" aria-hidden="true"></i> ' + title;
      
        }
      
        document.getElementById('dialogboxbody').innerHTML = message;
        document.getElementById('dialogboxfoot').innerHTML = '<button class="pure-material-button-contained active" onclick="customAlert.ok()">OK</button>';

    }
    
    this.ok = function() {

        document.getElementById('dialogbox').style.display = "none";
        document.getElementById('dialogoverlay').style.display = "none";

    }

}
*/


// let customAlert = new CustomAlert();


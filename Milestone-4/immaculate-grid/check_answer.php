<?php
include 'db.php';
include 'prompts.php';

// Manually clean the JSON input first (avoid JSON_decode bug)
$rawData = file_get_contents('php://input');
$rawData = trim(str_replace("\n", "", $rawData));
file_put_contents('JSON_alternative2.txt', $rawData);
$rawData = fgets(fopen('JSON_alternative2.txt', 'r'));

// Prepare to parse through the data that was sent from script.js via string based methods
$firstColonIndex = 13;
$firstCommaIndex = strpos($rawData, ",");
$secondCommaIndex = $firstCommaIndex + 1 + strpos(substr($rawData, $firstCommaIndex + 1), ",");

// Extract the playername, the type of row/col prompt
$playerName = substr($rawData, $firstColonIndex + 2, $firstCommaIndex - $firstColonIndex - 3);
$rowPrompt = substr($rawData, $firstCommaIndex + 14, $secondCommaIndex - $firstCommaIndex - 15);
$colPrompt = substr($rawData, $secondCommaIndex + 14, strlen($rawData) - $secondCommaIndex - 16);

// Obtain the SQL syntax by using the type of row prompt as a key in the prompts dictionary
foreach ($promptsMap as $key => $values) {

    if (in_array($rowPrompt, $values)) {

        $rowCondition = $values["sql_condition"];
        break;

    }

}

// Obtain the SQL syntax by using the type of col prompt as a key in the prompts dictionary
foreach ($promptsMap as $key => $values) {

    if (in_array($colPrompt, $values)) {

        $colCondition = $values["sql_condition"];
        break;

    }

}

/* Check whether the row/col prompts ask for whether a player played for certain teams.
The query will be slightly different if we ask for whether a player played for two certain teams
across their career than asking for a stat-stat or stat-team combination within a specific season.
Conveniently, all the prompts that ask for a team have no numeric values in them while
all of them that ask for a stat do, so we can check this by checking for numerical values in the prompt strings */

$rowNonumeric = true;
$rowChars = str_split($rowPrompt);
foreach ($rowChars as $char) {
    if (is_numeric($char)) {
        $rowNonumeric = false;
        break;
    }
}

$colNonumeric = true;
$colChars = str_split($colPrompt);
foreach ($colChars as $char) {
    if (is_numeric($char)) {
        $colNonumeric = false;
        break;
    }
}

// The default prompt for a row/col pairing that generates a stat-stat combination or a team-stat combination
$sql = "SELECT *
        FROM stint
            LEFT JOIN hitting_stats ON stint.stint_id = hitting_stats.stint_id
            LEFT JOIN pitching_stats ON stint.stint_id = pitching_stats.stint_id
            LEFT JOIN team ON stint.team_id = team.team_id
            LEFT JOIN franchise ON team.franchise_id = franchise.franchise_id
        WHERE playermanager_id IN 
            (SELECT playermanager_id FROM playermanager
            WHERE CONCAT(first_name, ' ', last_name) = ?)
            AND {$rowCondition} AND {$colCondition}";

// Modified sql statement for a team-team prompt combination
if ($rowNonumeric && $colNonumeric) {

    // Need to slightly adjust the row and col conditions first before throwing it into the query
    $rowCondition = preg_replace('/franchise\.franchise_name/', "f1.franchise_name", $rowCondition);
    $colCondition = preg_replace('/franchise\.franchise_name/', "f2.franchise_name", $colCondition);

    $sql = "SELECT DISTINCT s1.playermanager_id, f1.franchise_name, f2.franchise_name
            FROM stint s1
                JOIN stint s2 ON s1.playermanager_id = s2.playermanager_id AND s1.team_id <> s2.team_id
                JOIN team t1 ON s1.team_id = t1.team_id
                JOIN franchise f1 ON t1.franchise_id = f1.franchise_id
                JOIN team t2 ON s2.team_id = t2.team_id
                JOIN franchise f2 ON t2.franchise_id = f2.franchise_id AND f1.franchise_id <> f2.franchise_id
            WHERE s1.playermanager_id IN 
                (SELECT pm.playermanager_id FROM playermanager pm
                WHERE CONCAT(pm.first_name, ' ', pm.last_name) = ?)
                AND {$rowCondition} AND {$colCondition}";

}

// Execute the query via prepared statement
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $playerName);
$stmt->execute();
$result = $stmt->get_result();

// If there are any results, we send a correct message back. Incorrect message if not.
if ($row = $result->fetch_assoc()) {

    // We use both a file method in addition to a JSON method in case the JSON errors
    file_put_contents('JSON_alternative.txt', "Correct!, {$playerName}");
    echo json_encode(["status" => "success", "message" => "Correct!", "playerName" => $playerName]);

} else {

    file_put_contents('JSON_alternative.txt', "Incorrect., ''");
    echo json_encode(["status" => "error", "message" => "Incorrect.", "playerName" => ""]);

}

?>

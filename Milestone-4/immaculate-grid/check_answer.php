<?php
include 'db.php';
include 'prompts.php';

// for some reason I have to clean the input first
$rawData = file_get_contents('php://input');
file_put_contents('raw_data.log', $rawData . "\n");
$rawData = trim(str_replace("\n", "", $rawData));
file_put_contents('help_me.txt', $rawData);
$rawData = fgets(fopen('help_me.txt', 'r'));
// $data = json_decode($rawData, true);

/*
$data = json_decode(file_get_contents("php://input"), true);
$logEntry = json_encode($data) . "\n";
file_put_contents('raw_data.log', $data . "\n", FILE_APPEND);
*/

$firstColonIndex = 13;
$firstCommaIndex = strpos($rawData, ",");
$secondCommaIndex = $firstCommaIndex + 1 + strpos(substr($rawData, $firstCommaIndex + 1), ",");

// file_put_contents('help_me.txt', $firstColonIndex, FILE_APPEND);
// file_put_contents('help_me.txt', $firstCommaIndex, FILE_APPEND);
// file_put_contents('help_me.txt', $secondCommaIndex, FILE_APPEND);

$playerName = substr($rawData, $firstColonIndex + 2, $firstCommaIndex - $firstColonIndex - 3);
$rowPrompt = substr($rawData, $firstCommaIndex + 14, $secondCommaIndex - $firstCommaIndex - 15);
$colPrompt = substr($rawData, $secondCommaIndex + 14, strlen($rawData) - $secondCommaIndex - 16);

// file_put_contents('help_me.txt', $playerName, FILE_APPEND);
// file_put_contents('help_me.txt', $rowPrompt, FILE_APPEND);
// file_put_contents('help_me.txt', $colPrompt, FILE_APPEND);

/*
$keys = ["playerName", "rowPrompt", "colPrompt"];
$prompts = [];

foreach ($keys as $key) {

    $startPos = strpos($rawData, "\"$key\":\"") + strlen("\"$key\":\"");
    $endPos = strpos($rawData, "\"", $startPos);

    // Extract the value using the substr
    $value = substr($rawData, $startPos, $endPos - $startPos);

    // Add the value to the array
    $prompts[$key] = $value;

}
*/

/*
$playerName = $data["playerName"];
// $row = $data["rowPrompt"];
// $col = $data["colPrompt"];
$rowPrompt = $data["rowPrompt"];
$colPrompt = $data["colPrompt"];
*/


foreach ($promptsMap as $key => $values) {

    if (in_array($rowPrompt, $values)) {

        $rowCondition = $values["sql_condition"];
        break;

    }

}

foreach ($promptsMap as $key => $values) {

    if (in_array($colPrompt, $values)) {

        $colCondition = $values["sql_condition"];
        break;

    }

}

// $rowCondition = "franchise.franchise_name = 'New York Yankees'";
// $colCondition = "hitting_stats.home_runs >= 30";

// hard-code the conditions for now
// fetch these conditions from a database later

// need to create a dictionary (database) of row/col conditions

/*
$rowConditions = [

    "franchise.franchise_name = 'New York Yankees'",
    "franchise.franchise_name = 'Boston Red Sox'",
    "franchise.franchise_name = 'Los Angeles Dodgers'"

];

$colConditions = [

    "hitting_stats.home_runs >= 30",
    "pitching_stats.strikeouts >= 200",
    "hitting_stats.stolen_bases >= 25"

];
*/

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

$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $playerName);
$stmt->execute();
$result = $stmt->get_result();

if ($row = $result->fetch_assoc()) {

    file_put_contents('JSON_alternative.txt', "Correct!, {$playerName}");
    echo json_encode(["status" => "success", "message" => "Correct!", "playerName" => $playerName]);

} else {

    file_put_contents('JSON_alternative.txt', "Incorrect., ''");
    echo json_encode(["status" => "error", "message" => "Incorrect.", "playerName" => ""]);

}

?>